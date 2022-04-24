import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AppConfigService extends GetxService {
  Future<AppConfigService> init() async {
    box = GetStorage();
    await box.writeIfNull(THEME, false);
    Get.changeTheme(box.read(THEME) ? ThemeData.dark() : ThemeData.light());
    return this;
  }

  GetStorage box;
  bool getTheme() => box.read(THEME);
  changeTheme(b) async {
    Get.changeTheme(b ? ThemeData.dark() : ThemeData.light());
    await box.write(THEME, b);
  }
}