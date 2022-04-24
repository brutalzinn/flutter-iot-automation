import 'package:application/app/database/bedroom_service.dart';
import 'package:application/app/ui/android/home/home_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => BedroomsService().init());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HomeAssistant e Flutter - Teste',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeListPage(),
    );
  }
}