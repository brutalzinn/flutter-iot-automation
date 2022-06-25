import 'package:application/app/ui/dispositivo/controller/dispositivo_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DispositivoClickPage extends GetView<DispositivoController> {
  @override
  final controller = Get.find<DispositivoController>();

  DispositivoClickPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Obx(()=>Text(controller.titulo.value)), leading: BackButton(onPressed: () => controller.closeView())),
      body: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          child: controller.showDeviceView()  
          
        ),
      ),
    );
  }
}