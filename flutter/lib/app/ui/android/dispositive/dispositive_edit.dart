import 'package:application/app/data/enum/device_type.dart';
import 'package:application/app/ui/android/dispositive/controller/dispositive_controller.dart';
import 'package:application/app/ui/android/widgets/dropdown_widget_devices_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DispositiveEditPage extends GetView<DispositiveController> {
  @override
  final controller = Get.find<DispositiveController>();

  DispositiveEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(controller.titulo)),
      body: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
            Obx(() =>DropDownDeviceType(
              value:  controller.tipoDevice.value,
              onChange: (value){
                controller.defineType(value);
                })),
            TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
                controller: controller.nomeController,
                focusNode: controller.nomeFocusNode,
                textInputAction: TextInputAction.next,
          
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                ),
                controller: controller.descricaoController,
                focusNode: controller.descricaoFocusNode,
                textInputAction: TextInputAction.next,
          
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'MQTT HOST',
                ),
                controller: controller.mqttHostController,
                focusNode: controller.mqttHostFocusNode,
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'MQTT PORT',
                ),
                controller: controller.mqttPortController,
                focusNode: controller.mqttPortFocusNode,
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'MQTT Id',
                ),
                controller: controller.mqttIdUserController,
                focusNode: controller.mqttIdUserFocusNode,
                textInputAction: TextInputAction.next
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'MQTT TOPIC',
                ),
                controller: controller.mqttTopicController,
                focusNode: controller.mqttTopicFocusNode,
                textInputAction: TextInputAction.next
              ),

              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'MQTT USER',
                ),
                controller: controller.mqttUserController,
                focusNode: controller.mqttUserFocusNode,
                textInputAction: TextInputAction.next
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'MQTT PASSWORD',
                ),
                controller: controller.mqttPasswordController,
                focusNode: controller.mqttPasswordFocusNode,
                textInputAction: TextInputAction.next
              ),
              
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.editMode();
                      if (controller.loading.value == true) {
                        Get.dialog(const Center(child: CircularProgressIndicator()));
                      }
                    },
                    child: const Text('Salvar'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}