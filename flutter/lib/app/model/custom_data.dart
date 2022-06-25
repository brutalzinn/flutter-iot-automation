import 'dart:convert';

List<CustomData> customDataFromJson(String str) =>
    List<CustomData>.from(json.decode(str).map((x) => CustomData.fromJson(x)));

String customDataListToJson(List<CustomData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class CustomData {
  String customDataToJson() => json.encode(this.toJson());

  String key;
  dynamic value;

  CustomData({
     this.key = "",
     this.value = "",
  });

  factory CustomData.fromJson(Map<String, dynamic> json) => CustomData(
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value
      };

}