import 'package:application/app/core/infra/provider/dispositivo_provider.dart';
import 'package:application/app/core/infra/repository/dispositivo_repository.dart';
import 'package:application/app/ui/dispositivo/controller/dispositivo_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DispositivoListPage extends GetView<DispositivoController> {

  @override
  final controller = Get.put(DispositivoController(DispositivoRepository(DispositivoProvider())));
  
  DispositivoListPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(controller.getAmbience())),
      body: Obx(() {
        if (controller.loading.value == true) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: controller.deviceList.length,
          itemBuilder: (BuildContext context, int index) => ListTile(
            title: Text(controller.deviceList[index].nome),
            onTap: () {
              controller.onClickDevice(controller.deviceList[index]);
            },
            trailing: Wrap(children: <Widget>[
          Text(controller.getDeviceTypeEnumTitle(controller.deviceList[index].tipoId)),
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
                        title: 'Excluir dispositivo',
                        middleText:
                            'Excluir dispositivo ${controller.deviceList[index].nome}?',
                        textCancel: 'Voltar',
                        onConfirm: () {
                          controller.deleteNote(controller.deviceList[index].id!);
                          if (controller.loading.value == true) {
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
          controller.addNote();
        },
      ),
    );
  }
}