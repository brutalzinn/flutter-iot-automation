import 'package:application/app/data/provider/dispositive_provider.dart';
import 'package:application/app/data/repository/dispositive_repository.dart';
import 'package:application/app/ui/android/dispositive/controller/dispositive_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DispositiveListPage extends GetView<DispositiveController> {

  @override
  final controller = Get.put(DispositiveController(DispositiveRepository(DispositiveProvider())));

  DispositiveListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GetX SQLite CRUD Tutorial')),
      body: Obx(() {
        //para testar melhor o loading, descomente a future delayed
        //no provider pra simular uma pequena demora no retorno da requisicao
        if (controller.loading.value == true) {
          return const Center(
            child: const CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: controller.deviceList.length,
          itemBuilder: (BuildContext context, int index) => ListTile(
            title: Text('${controller.deviceList[index].nome}'),
            trailing: Wrap(children: <Widget>[
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  controller.editNote(controller.deviceList[index]);
                },
              ),
              IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    Get.defaultDialog(
                        title: 'Excluir Nota',
                        middleText:
                            'Excluir dispositivo ${controller.deviceList[index].nome}? Todos os seus dispositivos serão apagados.',
                        textCancel: 'Voltar',
                        onConfirm: () {
                          controller.deleteNote(controller.deviceList[index].id!);
                          if (controller.loading.value == true) {
                            Get.dialog(
                              const Center(child: const CircularProgressIndicator()),
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
          controller.addNote();
        },
      ),
    );
  }
}