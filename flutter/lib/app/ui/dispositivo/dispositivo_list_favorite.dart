import 'package:application/app/core/infra/provider/dispositivo_provider.dart';
import 'package:application/app/core/infra/repository/dispositivo_repository.dart';
import 'package:application/app/ui/dispositivo/controller/dispositivo_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DispositivoListFavorite extends GetView<DispositivoController> {

  @override
  //final controller = Get.put(DispositiveFavoriteController(DispositiveRepository(DispositiveProvider())));
  final controller = Get.put(DispositivoController(DispositivoRepository(DispositivoProvider())));

  DispositivoListFavorite({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos')),
      body: Obx(() {
        if (controller.loading.value == true) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: controller.deviceList.length,
          itemBuilder: (BuildContext context, int index) => ListTile(
            title: Text(controller.deviceList[index].nome ?? ""),
            onTap: () {
              controller.onClickDevice(controller.deviceList[index]);
            },
            trailing: Wrap(children: <Widget>[
              Text("Favorite: ${controller.deviceList[index].isFavorite} "),
              Text(controller.getDeviceTypeEnumTitle(controller.deviceList[index].tipoId)),  
            ]),
          ),
        );
      })
    );
  }
}