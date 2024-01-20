import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:students_payment_system/presentation/pages/home_page.dart';
import 'package:students_payment_system/presentation/widgets/webview.dart';
import 'package:students_payment_system/services/api.dart';
import 'package:students_payment_system/services/model/auth_model/auth_model.dart';
import 'package:students_payment_system/utils/constants.dart';
import 'package:students_payment_system/utils/functions.dart';
import 'package:students_payment_system/utils/providers/provider_list.dart';
import 'package:students_payment_system/utils/router/base_navigator.dart';

class AuthService extends DisposableProvider {
  bool isLoading = false;
  final box = Hive.box(Boxes.authBox);
  AuthModel authModel = AuthModel();

  startloading() {
    isLoading = true;
    notifyListeners();
  }

  stoploading() {
    isLoading = false;
    notifyListeners();
  }

  /// Register User
  void register(BuildContext context, {uname, email, pass}) async {
    startloading();
    await postRequest(
      url: 'register',
      body: {"username": uname, "email": email, "password": pass},
      onResponse: (response) {
        stoploading();

        AuthModel model = AuthModel.fromJson(response.data);
        authModel = model;

        if (model.id != null) {
          box.put(BxKey.accessToken, model.token);
          saveLoginInfo(
            LoginInfoModel(
              accessToken: model.token,
              refreshToken: model.token,
              refreshTokenExpires: model.token,
            ),
          );
          BaseNavigator.key.currentState!.pushNamed(HomePage.routeName);
        } else {
          AppFunction.showAlert(context, "An error occured!",
              type: AlertType.error);
        }
      },
      onError: (resp, {error}) {
        stoploading();
        AppFunction.showAlert(context, resp.message, type: AlertType.error);
      },
    );
  }

  /// Login user
  void login(BuildContext context, {uname, pass}) async {
    startloading();
    await postRequest(
      url: 'login',
      body: {"username": uname, "password": pass},
      onResponse: (response) {
        AuthModel model = AuthModel.fromJson(response.data);
        stoploading();

        if (model.token != null) {
          box.put(BxKey.accessToken, model.token);
          BaseNavigator.key.currentState!.pushNamed(HomePage.routeName);
        } else {
          AppFunction.showAlert(context, "An error occured!",
              type: AlertType.error);
        }
      },
      onError: (resp, {error}) {
        stoploading();
        AppFunction.showAlert(context, resp.message, type: AlertType.error);
      },
    );
  }

  void paymentlink(BuildContext context) async {
    startloading();
    await postRequest(
      url: 'wallet/load',
      baseUrl: 'https://mint-backend-mbjq.onrender.com/api/',
      body: {"wallet_id": 1, "amount": 12100},
      // options: Options(headers: {
      //   'Authorization': 'Token ${getLoginInfo().accessToken}',
      // }),
      // body: FormData.fromMap({"wallet_id": 1, "amount": 12100}),

      onResponse: (response) {
        print(response.data);
        // AuthModel model = AuthModel.fromJson(response.data);
        stoploading();
        print(response.data['payment_link']['checkout_url']);

        // if (model.paymentUrl != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => WebViewWidget(
              data: {
                'url': response.data['payment_link']['checkout_url'],
                'cancelUrl': 'random.com',
              },
            ),
          ),
        ); // model.paymentUrl,
        // } else {
        //   AppFunction.showAlert(context, "An error occured!",
        //       type: AlertType.error);
        // }
      },
      onError: (resp, {error}) {
        stoploading();
        AppFunction.showAlert(context, resp.message, type: AlertType.error);
      },
    );
  }

  /// user profile
  // Future<void> userProfile(BuildContext context) async {
  //   await getRequest(
  //     url: 'userInfo',

  //     onResponse: (response) {
  //       UserInfoModel model = UserInfoModel.fromJson(response.data);
  //       User.saveInfo(
  //         userInfo: model.data.userInfo,
  //         balanceInfo: model.data.balance,
  //         accounts: model.data.accounts,
  //       );
  //       notifyListeners();
  //     },
  //     onError: (resp, {error}) {},
  //   );
  // }

  /// get user information
  // User get user => User.getUser();

  // void updateField(String key, dynamic value) {
  //   final box = Hive.box(Boxes.authBox);
  //   box.put(key, value);
  //   notifyListeners();
  // }

  void saveLoginInfo(LoginInfoModel info) {
    final box = Hive.box(Boxes.authBox);
    box.put(BxKey.accessToken, info.accessToken ?? '');
    box.put(BxKey.refreshToken, info.refreshToken ?? '');

    box.put(BxKey.password, info.password ?? '');
    notifyListeners();
  }

  LoginInfoModel getLoginInfo() {
    final box = Hive.box(Boxes.authBox);
    return LoginInfoModel(
      // isLoggedIn: box.get(BxKey.isLoggedin, defaultValue: false),
      accessToken: box.get(BxKey.accessToken, defaultValue: ""),
      refreshToken: box.get(BxKey.refreshToken, defaultValue: ""),
      // refreshTokenExpires: box.get(BxKey.refreshTokenExpires, defaultValue: ""),
      password: box.get(BxKey.password, defaultValue: ""),
    );
  }

  @override
  void disposeValues() {
    authModel = AuthModel();
  }
}

class LoginInfoModel {
  bool? isLoggedIn;
  String? accessToken;
  String? refreshToken;
  String? refreshTokenExpires;
  String? password;

  LoginInfoModel({
    this.isLoggedIn,
    this.accessToken,
    this.refreshToken,
    this.refreshTokenExpires,
    this.password,
  });
}
