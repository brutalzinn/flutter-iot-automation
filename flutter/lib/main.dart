import 'package:application/app/core/infra/database/ambiente_service.dart';
import 'package:application/app/core/infra/database/database_service.dart';
import 'package:application/app/core/infra/database/dispositivo_service.dart';
import 'package:application/app/core/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//essa gambiarra de aguardar os serviços iniciarem na ordem é esquisita.
//o problema são as "relações" que criamos nos serviços do SQL LITE
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => DatabaseService().init());
  await Get.putAsync(() => AmbienteService().init());
  await Get.putAsync(() => DispositivoService().init());

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