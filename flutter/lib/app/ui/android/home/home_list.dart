import 'package:application/app/data/provider/bedroom_provider.dart';
import 'package:application/app/data/repository/bedroom_repository.dart';
import 'package:application/app/ui/android/dispositive/dispositive_list.dart';
import 'package:application/app/ui/android/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeListPage extends GetView<HomeController> {

  final homeController = Get.put(HomeController(BedRoomRepository(BedRoomProvider())));

  HomeListPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Obx(() {
        //para testar melhor o loading, descomente a future delayed
        //no provider pra simular uma pequena demora no retorno da requisicao
        if (homeController.loading.value == true) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
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
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          homeController.addNote();
        },
      ),
    );
  }
}