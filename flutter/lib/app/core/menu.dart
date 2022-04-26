// ignore_for_file: unnecessary_string_interpolations, unrelated_type_equality_checks
import 'package:application/app/data/provider/bedroom_provider.dart';
import 'package:application/app/data/repository/bedroom_repository.dart';
import 'package:application/app/ui/android/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuListPage extends GetView<HomeController> {

  final homeController = Get.put(HomeController(BedRoomRepository(BedRoomProvider())));

  MenuListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Obx(() =>  Scaffold(
        appBar: AppBar(
          title: const Text('Menu'),
          actions: <Widget>[
  
          Expanded(child: 
          SizedBox(child: 
          
          ListView.builder(
          shrinkWrap: true,
          itemCount: homeController.noteList.length,
          itemBuilder: (BuildContext context, int index) => ListTile(
            title: Text(homeController.noteList[index].nome),
            onTap: () {
                //exibir dispositivos
                Get.toNamed("/devices/${homeController.noteList[index].id}");
              //  Get.to(() => DispositiveListPage(), arguments: homeController.noteList[index].id!);
            })
          )))],
          ),
        ),
      ),
          
        );
    
    }
  }