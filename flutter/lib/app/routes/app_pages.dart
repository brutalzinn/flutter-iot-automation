import 'package:application/app/ui/android/home/home_list.dart';
import 'package:get/get.dart';
part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: Routes.initial, page: () => HomeListPage()),
    GetPage(name: Routes.initial, page: () => HomeListPage())
        
  ];
}