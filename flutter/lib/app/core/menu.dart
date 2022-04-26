// ignore_for_file: unnecessary_string_interpolations, unrelated_type_equality_checks

import 'package:application/app/data/provider/bedroom_provider.dart';
import 'package:application/app/data/repository/bedroom_repository.dart';
import 'package:application/app/ui/android/dispositive/dispositive_edit.dart';
import 'package:application/app/ui/android/home/controller/home_controller.dart';
import 'package:application/app/ui/android/home/home_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//mudar isso de lugar depois dos testes com o MQTT
class DrawerItem {
  String title;
  final int? homeId;
  IconData icon;

  DrawerItem({required this.title, required this.icon, this.homeId});
}

class MenuPage extends StatefulWidget {


  MenuPage({Key? key}) : super(key: key);

  final drawerItems = [
    DrawerItem(title:"Principal", icon: Icons.inbox),
  ];

  @override
  State<StatefulWidget> createState() {
    return MenuPageState();
  }
}

class MenuPageState extends State<MenuPage> {




  @override
  Widget build(BuildContext context) {

    List<Widget> drawerOptions = [];

    final _selectedDrawerIndex = RxInt(0);

    final homeController = Get.put(HomeController(BedRoomRepository(BedRoomProvider())));
    

    for (var i = 0; i < homeController.noteList.length; i++) {

        var room = homeController.noteList[i];
        
        drawerOptions.add(ListTile(
        title: Text(room.nome),
        selected: i == _selectedDrawerIndex.value,
        onTap: ()
        {
          _selectedDrawerIndex.value = i;
          Get.toNamed("/devices/${room.id ?? 0}");
          },
      ));
      
    }

    return Scaffold(
      appBar: AppBar(
        title: Obx(()=> Text('${homeController.noteList[_selectedDrawerIndex.value].nome}')),
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Column(children: drawerOptions)
          ],
        ),
      ),
      // body: _getDrawerItemWidget(room.id!),
    );
  }
}