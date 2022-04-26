// ignore_for_file: unnecessary_string_interpolations, unrelated_type_equality_checks
import 'package:application/app/data/provider/bedroom_provider.dart';
import 'package:application/app/data/repository/bedroom_repository.dart';
import 'package:application/app/ui/android/home/controller/home_controller.dart';
import 'package:application/app/ui/android/home/home_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


 class DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  const DrawerItem({Key? key,  required this.title, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(title:Text(title),leading: Icon(icon));
  }
  }

class MenuListPage extends GetView<HomeController> {

  final homeController = Get.put(HomeController(BedRoomRepository(BedRoomProvider())));
 
  MenuListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: Text("Gerenciador de IOT - MQTT"),
      ),
      drawer: Drawer(
        child: Column(
        children: <Widget> [
          const ListTile(title:Text("Home")),
          ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: homeController.noteList.length,
          itemBuilder: (BuildContext context, int index) => ListTile(
            title: Text(homeController.noteList[index].nome),
            onLongPress: () {
                //exibir dispositivos
                Get.toNamed("/devices/${homeController.noteList[index].id}");
              //  Get.to(() => DispositiveListPage(), arguments: homeController.noteList[index].id!);
            },
            trailing: Wrap(children: <Widget>[
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  homeController.editNote(homeController.noteList[index]);
                },
              ),
              // IconButton(
              //     icon: const Icon(Icons.delete),
              //     onPressed: () {
              //       Get.defaultDialog(
              //           title: 'Excluir Nota',
              //           middleText:
              //               'Excluir cômodo ${homeController.noteList[index].nome}? Todos os seus dispositivos serão apagados.',
              //           textCancel: 'Voltar',
              //           onConfirm: () {
              //             homeController.deleteNote(homeController.noteList[index].id!);
              //             if (homeController.loading.value == true) {
              //               Get.dialog(
              //                 const Center(child: CircularProgressIndicator()),
              //               );
              //             }
              //           });
              //     }),
            ]),
          ),
      ),
      
      
      ],
      ),
      ),
      // body: HomeListPage(),
    );  
  }
}