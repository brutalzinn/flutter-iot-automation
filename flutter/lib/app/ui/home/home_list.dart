
import 'package:application/app/core/infra/provider/ambiente_provider.dart';
import 'package:application/app/core/infra/repository/ambiente_repository.dart';
import 'package:application/app/ui/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeListPage extends GetView<HomeController> {

  final homeController = Get.put(HomeController(AmbienteRepository(AmbienteProvider())));

  HomeListPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de ambientes')),
      body: Obx(() {
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
                Get.toNamed("/devices/${homeController.noteList[index].id}");
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
                        title: 'Excluir Ambiente',
                        middleText:
                            'Excluir ambiente ${homeController.noteList[index].nome}? Todos os seus dispositivos serão apagados.',
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