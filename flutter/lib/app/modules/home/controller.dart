import 'package:application/app/modules/home/repository.dart';

import 'package:get/get.dart';


class HomeController extends GetxController {
  final HomeRepository repository;

  final index = 0.obs;
  HomeController(this.repository);
  AppConfigService appConfigService;
  @override
  void onInit() {
    this.appConfigService = Get.find<AppConfigService>();
    super.onInit();
  }

  changePage(i) => this.index.value = i;
}