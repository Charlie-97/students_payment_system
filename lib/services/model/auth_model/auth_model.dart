// To parse this JSON data, do
//
//     final authModel = authModelFromJson(jsonString);

import 'dart:convert';

AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel {
  int? id;
  String? username;
  String? email;
  String? token;
  String? paymentUrl;

  AuthModel({
    this.id,
    this.username,
    this.email,
    this.token,
    this.paymentUrl,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        token: json["token"],
        paymentUrl: json["payment link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "token": token,
        "payment link": paymentUrl,
      };
}
