import 'package:application/app/data/provider/bedroom_provider.dart';
import 'package:application/app/data/repository/bedroom_repository.dart';
import 'package:application/app/ui/android/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeListPage extends GetView<HomeController> {

  @override
  final controller = Get.put(HomeController(BedRoomRepository(BedRoomProvider())));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GetX SQLite CRUD Tutorial')),
      body: Obx(() {
        //para testar melhor o loading, descomente a future delayed
        //no provider pra simular uma pequena demora no retorno da requisicao
        if (controller.loading.value == true) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: controller.noteList.length,
          itemBuilder: (BuildContext context, int index) => ListTile(
            title: Text('${controller.noteList[index].nome}'),
            trailing: Wrap(children: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  controller.editNote(controller.noteList[index]);
                },
              ),
              IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    Get.defaultDialog(
                        title: 'Excluir Nota',
                        middleText:
                            'Excluir nota de título ${controller.noteList[index].nome}?',
                        textCancel: 'Voltar',
                        onConfirm: () {
                          controller.deleteNote(controller.noteList[index].id!);
                          if (controller.loading.value == true) {
                            Get.dialog(
                              Center(child: CircularProgressIndicator()),
                            );
                          }
                        });
                  }),
            ]),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          controller.addNote();
        },
      ),
    );
  }
}