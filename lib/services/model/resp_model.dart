
// To parse this JSON data, do
//
//     final respModel = respModelFromJson(jsonString);

import 'dart:convert';

RespModel respModelFromJson(String str) => RespModel.fromJson(json.decode(str));

String respModelToJson(RespModel data) => json.encode(data.toJson());

class RespModel {
  bool? status;
  String? message;
  // dynamic data;
  List<ErrorModel>? errors;

  RespModel({
    this.status,
    this.message,
    // this.data,
    this.errors,
  });

  factory RespModel.fromJson(Map<String, dynamic> json) => RespModel(
        status: json["status"],
        message: json["message"],
        // data: json["data"] ?? '',
        errors: json["errors"] == null
            ? []
            : List<ErrorModel>.from(
                json["errors"]!.map((x) => ErrorModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        // "data": data,
        "errors": errors == null
            ? []
            : List<dynamic>.from(errors!.map((x) => x.toJson())),
      };
}

class ErrorModel {
  String? message;
  String? field;

  ErrorModel({
    this.message,
    this.field,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        message: json["message"],
        field: json["field"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "field": field,
      };
}
