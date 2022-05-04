import 'package:application/app/data/provider/dispositive_provider.dart';
import 'package:application/app/data/repository/dispositive_repository.dart';
import 'package:application/app/ui/android/dispositive/controller/dispositive_favorite_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DispositiveListFavorite extends GetView<DispositiveFavoriteController> {

  @override
  final controller = Get.put(DispositiveFavoriteController(DispositiveRepository(DispositiveProvider())));
  
  DispositiveListFavorite({Key? key}) : super(key: key);
  
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
            title: Text(controller.deviceList[index].nome),
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