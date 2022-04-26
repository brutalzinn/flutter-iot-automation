import 'package:application/app/core/menu.dart';
import 'package:application/app/ui/android/dispositive/dispositive_edit.dart';
import 'package:application/app/ui/android/dispositive/dispositive_list.dart';
import 'package:application/app/ui/android/home/home_list.dart';
import 'package:get/get.dart';
part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: Routes.initial, page: () => MenuListPage()),
    GetPage(name: Routes.home, page: () => HomeListPage()),
    GetPage(name: Routes.devicesList, page: () => DispositiveListPage()),
    GetPage(name: Routes.devicesEdit, page: () => DispositiveEditPage())
  ];
}