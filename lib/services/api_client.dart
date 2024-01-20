import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:students_payment_system/services/model/auth_model/auth_model.dart';
import 'package:students_payment_system/utils/constants.dart';

String url = "https://mint-backend-mbjq.onrender.com/api/";

class Client {
  Future<CacheOptions> cacheOption() async {
    final dir = await getApplicationDocumentsDirectory();
    final options = CacheOptions(
      store: HiveCacheStore(dir.path),
      policy: CachePolicy.request,
      hitCacheOnErrorExcept: [401, 403],
      maxStale: const Duration(days: 7),
      priority: CachePriority.normal,
      cipher: null,
      keyBuilder: CacheOptions.defaultCacheKeyBuilder,
      allowPostMethod: false,
    );
    return options;
  }

  Dio init({String? baseUrl}) {
    Dio dio = Dio();
    dio.options.baseUrl = baseUrl ?? url;
    print("1. ${dio.options.baseUrl}");
    dio.interceptors.add(ApiInterceptors());
    cacheOption().then(
        (value) => dio.interceptors.add(DioCacheInterceptor(options: value)));
    return dio;
  }
}

class ApiInterceptors extends QueuedInterceptorsWrapper {
  final Dio _dio = Dio();
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final box = Hive.box(Boxes.authBox);
    final accessToken = box.get(BxKey.accessToken, defaultValue: "");
    print("$accessToken --check");
    options.headers['Authorization'] = 'Token $accessToken';
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final options = err.response!.requestOptions;
      final box = Hive.box(Boxes.authBox);
      final tokenResult = await _dio.post(
        '${url}refreshToken',
        data: {
          "refreshToken": box.get(BxKey.refreshToken, defaultValue: ""),
        },
      );
      if (tokenResult.statusCode != null &&
          tokenResult.statusCode! ~/ 100 == 2) {
        AuthModel model = AuthModel.fromJson(tokenResult.data);
        if (model.id != null) {
          if (model.token == null) {
            // AppFunction.softlogout();
            return handler.reject(
              DioException(
                requestOptions: options,
                message: "Session expired, please login again",
                response: Response(
                  requestOptions: options,
                  statusCode: 401,
                  statusMessage: "Session expired, please login again",
                ),
              ),
            );
          } else {
            box.put(BxKey.accessToken, model.token);
            options.headers['Authorization'] = "Bearer ${model.token}";
            final originResult = await _dio.fetch(options);
            if (originResult.statusCode != null &&
                originResult.statusCode! ~/ 100 == 2) {
              return handler.resolve(originResult);
            }
          }
        }
      }

      return handler.reject(
        DioException(
          requestOptions: options,
          message: "Session expired, please login again",
        ),
      );
    }
    return handler.next(err);
  }
}
