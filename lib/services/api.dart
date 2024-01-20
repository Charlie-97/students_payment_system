import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:students_payment_system/services/api_client.dart';
import 'package:students_payment_system/services/model/resp_model.dart';
import 'package:students_payment_system/utils/functions.dart';
import 'package:students_payment_system/utils/texts.dart';

const Duration timeOut = Duration(seconds: 90);
Client _client = Client();

Future getRequest({
  required String url,
  String? baseUrl,
  Options? options,
  required void Function(Response response) onResponse,
  required void Function(ApiResponse response, {dynamic error}) onError,
}) async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      final response =
          await _client.init(baseUrl: baseUrl).get(url, options: options);
      onResponse(response);
    } else {
      onError(ApiResponse(message: AppTexts.noInternet, status: false));
    }
  } on DioException catch (e) {
    if (e.response != null && e.response!.statusCode == 401) {
      onError(
        ApiResponse(
          message: 'Session expired, please login again',
          status: false,
        ),
        error: e,
      );
      AppFunction.softlogout();
      return;
    }
    /*  if (e.response?.statusCode == 400) {
      onError(
        ApiResponse(
          message: e.response!.data['message'],
          status: false,
        ),
        error: e,
      );
      return;
    } */
    onError(
      ApiResponse(
        message: e.response != null
            ? "${e.response?.data['message']}"
            : e.message ?? 'Error occurred, please try again',
        status: false,
      ),
      error: e,
    );
  } on SocketException catch (_) {
    onError(ApiResponse(message: AppTexts.noInternet, status: false));
  } on TimeoutException catch (_) {
    onError(ApiResponse(message: AppTexts.timeoutMsg, status: false));
  } catch (e) {
    onError(ApiResponse(message: AppTexts.unableConn, status: false), error: e);
  }
}

Future postRequest({
  required String url,
  String? baseUrl,
  Object? body,
  Options? options,
  required void Function(Response response) onResponse,
  required void Function(ApiResponse response, {dynamic error}) onError,
}) async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      final response = await _client
          .init(baseUrl: baseUrl)
          .post(url, data: body, options: options);
      onResponse(response);
    } else {
      onError(ApiResponse(message: AppTexts.noInternet, status: false));
    }
  } on DioException catch (e) {
    if (e.response != null && e.response!.statusCode == 401) {
      onError(
        ApiResponse(
          message: 'Session expired, please login again',
          status: false,
        ),
        error: e,
      );
      AppFunction.softlogout();
      return;
    }
    if (e.response!.data.toString().contains('html')) {
      onError(
        ApiResponse(
          message: 'Server error, please try again',
          status: false,
        ),
        error: e,
      );
      return;
    }
    /* if (e.response?.statusCode == 400) {
      onError(
        ApiResponse(
          message: e.response!.data['message'],
          status: false,
        ),
        error: e,
      );
      return;
    } */

    onError(
      ApiResponse(
        message: e.response != null
            ? "${e.response?.data['message']}"
            : e.message ?? 'Error occurred, please try again',
        status: false,
      ),
      error: e,
    );
  } on SocketException catch (_) {
    onError(ApiResponse(message: AppTexts.noInternet, status: false));
  } on TimeoutException catch (_) {
    onError(ApiResponse(message: AppTexts.timeoutMsg, status: false));
  } catch (e) {
    onError(ApiResponse(message: AppTexts.unableConn, status: false), error: e);
  }
}

Future deleteRequest({
  required String url,
  String? baseUrl,
  Object? body,
  Options? options,
  required void Function(Response response) onResponse,
  required void Function(ApiResponse response, {dynamic error}) onError,
}) async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      final response = await _client
          .init(baseUrl: baseUrl)
          .delete(url, data: body, options: options);
      onResponse(response);
    } else {
      onError(ApiResponse(message: AppTexts.noInternet, status: false));
    }
  } on DioException catch (e) {
    if (e.response != null && e.response!.statusCode == 401) {
      onError(
          ApiResponse(
            message: 'Session expired, please login again',
            status: false,
          ),
          error: e);
      AppFunction.softlogout();
      return;
    }
    if (e.response?.statusCode == 400) {
      onError(
        ApiResponse(
          message: e.response!.data['message'],
          status: false,
        ),
        error: e,
      );
      return;
    }
    onError(
      ApiResponse(
        message: e.response != null
            ? "${e.response!.statusMessage}"
            : e.message ?? 'Error occurred, please try again',
        status: false,
      ),
      error: e,
    );
  } on SocketException catch (_) {
    onError(ApiResponse(message: AppTexts.noInternet, status: false));
  } on TimeoutException catch (_) {
    onError(ApiResponse(message: AppTexts.timeoutMsg, status: false));
  } catch (e) {
    onError(ApiResponse(message: AppTexts.unableConn, status: false), error: e);
  }
}

Future putRequest({
  required String url,
  String? baseUrl,
  Object? body,
  Options? options,
  required void Function(Response response) onResponse,
  required void Function(ApiResponse response, {dynamic error}) onError,
}) async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      final response = await _client
          .init(baseUrl: baseUrl)
          .put(url, data: body, options: options);
      onResponse(response);
    } else {
      onError(ApiResponse(message: AppTexts.noInternet, status: false));
    }
  } on DioException catch (e) {
    if (e.response != null && e.response!.statusCode == 401) {
      onError(
        ApiResponse(
          message: 'Session expired, please login again',
          status: false,
        ),
        error: e,
      );
      AppFunction.softlogout();
      return;
    }
    if (e.response?.statusCode == 400) {
      onError(
        ApiResponse(
          message: e.response!.data['message'],
          status: false,
        ),
        error: e,
      );
      return;
    }
    onError(
      ApiResponse(
        message: e.response != null
            ? "${e.response!.statusMessage}"
            : e.message ?? 'Error occurred, please try again',
        status: false,
      ),
      error: e,
    );
  } on SocketException catch (_) {
    onError(ApiResponse(message: AppTexts.noInternet, status: false));
  } on TimeoutException catch (_) {
    onError(ApiResponse(message: AppTexts.timeoutMsg, status: false));
  } catch (e) {
    onError(ApiResponse(message: AppTexts.unableConn, status: false), error: e);
  }
}

class ApiResponse {
  final bool status;
  final String message;
  final dynamic data;
  ApiResponse({
    required this.status,
    required this.message,
    this.data,
  });
}

String getMessage(var data, String message) {
  if (data != null && data is List<ErrorModel> && data.isNotEmpty) {
    String msg = '';
    for (ErrorModel element in data) {
      int currentIndex = data.indexOf(element);
      int lastIndex = data.indexOf(data.last);
      msg += "* ${element.message}${currentIndex != lastIndex ? '\n' : ''}";
    }
    return msg;
  }

  return message;
}
