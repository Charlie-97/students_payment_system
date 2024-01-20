import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:students_payment_system/presentation/pages/home_page.dart';
import 'package:students_payment_system/services/api.dart';
import 'package:students_payment_system/services/model/auth_model/auth_model.dart';
import 'package:students_payment_system/utils/constants.dart';
import 'package:students_payment_system/utils/router/base_navigator.dart';

class AuthService extends ChangeNotifier {
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
  void register(BuildContext context, {dynamic value}) async {
    startloading();
    await postRequest(
      url: 'register',
      body: value!.toForm(),
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
          // Navigator.pushNamed(context, otpVerificationRoute);
        } else {
          // AppFunction.showAlert(context, model.message!, type: AlertType.error);
        }
      },
      onError: (resp, {error}) {
        stoploading();

        // AppFunction.showAlert(context, resp.message, type: AlertType.error);
      },
    );
  }

  /// Login user
  void login(BuildContext context, String value) async {
    startloading();
    await postRequest(
      url: 'login',
      body: {
        "userInfo": value,
        "app": "DRIVER",
      },
      onResponse: (response) {
        AuthModel model = AuthModel.fromJson(response.data);
        stoploading();

        if (model.id != null) {
          BaseNavigator.key.currentState!.pushNamed(HomePage.routeName);
        } else {
          // AppFunction.showAlert(context, model.message!, type: AlertType.error);
        }
      },
      onError: (resp, {error}) {
        stoploading();
        // AppFunction.showAlert(context, resp.message, type: AlertType.error);
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

  // @override
  // void disposeValues() {
  //   authModel = AuthModel();
  // }
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
