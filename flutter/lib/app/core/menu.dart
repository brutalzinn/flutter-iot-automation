import 'package:application/app/data/provider/bedroom_provider.dart';
import 'package:application/app/data/repository/bedroom_repository.dart';
import 'package:application/app/ui/android/home/controller/home_controller.dart';
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
        title: const Text("Gerenciador de IOT - MQTT"),
      ),
      drawer: Obx(() => Drawer(
        child: ListView(
        children: [
          ListTile(
          title: const Text("Favoritos"),
          onTap: () {
            Get.toNamed("/device/favorite");
          }),
          ListView.builder(
          // scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: homeController.noteList.length,
          itemBuilder: (BuildContext context, int index) => ListTile(
            
            title: Text(homeController.noteList[index].nome),
            onTap: () {
                Get.toNamed("/devices/${homeController.noteList[index].id}", parameters: {"room":homeController.noteList[index].nome});
            },
            trailing: Wrap(children: <Widget>[
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  homeController.editNote(homeController.noteList[index]);
                },
              ),
              IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    Get.defaultDialog(
                        title: 'Excluir Nota',
                        middleText:
                            'Excluir cômodo ${homeController.noteList[index].nome}? Todos os seus dispositivos serão apagados.',
                        textCancel: 'Voltar',
                        onConfirm: () {
                          homeController.deleteNote(homeController.noteList[index].id!);
                          if (homeController.loading.value == true) {
                            Get.dialog(
                              const Center(child: CircularProgressIndicator()),
                            );
                          }
                        });
                        
                  }),
            ]),
          ),
      ),
        
       
      ],
      ),
      //separar depois
      )),

       body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[                  
          Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.only(bottom: 10, right: 10),
            child: FloatingActionButton(child: const Icon(Icons.add),
            onPressed: () {
                homeController.addNote();
            })
            )
            ]
          )
        )
          ),
          );
                
                
              
       
           
           
           



          //  DispositiveListFavorite(),
          //   Container(
          //     alignment: Alignment.bottomRight,
          //     padding: EdgeInsets.only(bottom: 60, right: 10),
          //     child: FloatingActionButton(child: const Icon(Icons.add),
          //         onPressed: () {
          //         homeController.addNote();
          // }),
          //   )
       
      
      
     
     
  }
}