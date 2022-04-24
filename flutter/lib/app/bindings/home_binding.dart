// import 'package:application/app/controller/home/home_controller.dart';
// import 'package:application/app/data/repository/mqtt_repository.dart';
// import 'package:get/get.dart';

// class HomeBinding implements Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut<HomeController>(() {
//       return HomeController(
//           repository:
//               MQTTRepository(apiClient: MyApiClient(httpClient: http.Client())));
//     });
//   }
// }