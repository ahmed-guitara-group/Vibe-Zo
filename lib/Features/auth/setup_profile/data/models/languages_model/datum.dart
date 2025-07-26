class CountriesModelDatum {
  String? name;
  String? nameEn;
  String? nameAr;
  String? code;

  CountriesModelDatum({this.name, this.code, this.nameAr, this.nameEn});

  factory CountriesModelDatum.fromJson(Map<String, dynamic> json) =>
      CountriesModelDatum(
        name: json['name'] as String?,
        code: json['code'] as String?,
        nameAr: json['name_ar'] as String?,
        nameEn: json['name_en'] as String?,
      );

  Map<String, dynamic> toJson() => {
    'name': name,
    'code': code,
    'name_ar': nameAr,
    'name_en': nameEn,
  };
}
