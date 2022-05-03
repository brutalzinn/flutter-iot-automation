import 'package:application/app/data/provider/dispositive_provider.dart';
import 'package:application/app/data/repository/dispositive_repository.dart';
import 'package:application/app/ui/android/dispositive/controller/dispositive_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DispositiveListFavorite extends GetView<DispositiveController> {

  @override
  final controller = Get.put(DispositiveController(DispositiveRepository(DispositiveProvider())));
  
  DispositiveListFavorite({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            ]),
          ),
        );
      })
    );
  }
}