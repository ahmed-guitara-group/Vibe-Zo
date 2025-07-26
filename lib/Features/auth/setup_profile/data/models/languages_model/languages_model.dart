import 'datum.dart';

class CountriesModel {
  bool? status;
  String? code;
  String? message;
  List<CountriesModelDatum>? data;

  CountriesModel({this.status, this.code, this.message, this.data});

  factory CountriesModel.fromJson(Map<String, dynamic> json) {
    return CountriesModel(
      status: json['status'] as bool?,
      code: json['code'] as String?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CountriesModelDatum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'code': code,
    'message': message,
    'data': data?.map((e) => e.toJson()).toList(),
  };
}
