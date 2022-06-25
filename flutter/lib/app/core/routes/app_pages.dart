import 'package:application/app/core/menu.dart';
import 'package:application/app/ui/dispositive/dispositivo_edit.dart';
import 'package:application/app/ui/dispositive/dispositivo_list.dart';

import 'package:get/get.dart';
part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: Routes.initial, page: () => MenuListPage()),
    GetPage(name: Routes.deviceFavorite, page: () => DispositivoListFavorite()),
    GetPage(name: Routes.devicesList, page: () => DispositivoListPage()),
    GetPage(name: Routes.devicesEdit, page: () => DispositivoEditPage())
  ];
}