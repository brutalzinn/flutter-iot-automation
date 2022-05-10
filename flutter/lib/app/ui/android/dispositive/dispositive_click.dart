import 'package:application/app/ui/android/dispositive/controller/dispositive_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DispositiveClickPage extends GetView<DispositiveController> {
  @override
  final controller = Get.find<DispositiveController>();

  DispositiveClickPage({Key? key}) : super(key: key);

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