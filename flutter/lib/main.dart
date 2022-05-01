import 'package:application/app/database/bedroom_service.dart';
import 'package:application/app/database/database_service.dart';
import 'package:application/app/database/dispositive_service.dart';
import 'package:application/app/routes/app_pages.dart';
import 'package:application/app/ui/android/home/home_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => DatabaseService().init());
  await Get.putAsync(() => BedroomsService().init());
  await Get.putAsync(() => DispositiveService().init());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HomeAssistant e Flutter - Teste',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      getPages: AppPages.pages
    );
   
  }
}