
import 'dart:convert';

RgbColor rgbColorFromJson(String str) => RgbColor.fromJson(json.decode(str));

String rgbColorToJson(RgbColor data) => json.encode(data.toJson());

class RgbColor {
    RgbColor({
      required this.red,
      required this.green,
      required  this.blue,
    });

    int red;
    int green;
    int blue;

    factory RgbColor.fromJson(Map<String, dynamic> json) => RgbColor(
        red: json["red"],
        green: json["green"],
        blue: json["blue"],
    );

    Map<String, dynamic> toJson() => {
        "red": red,
        "green": green,
        "blue": blue,
    };
}
