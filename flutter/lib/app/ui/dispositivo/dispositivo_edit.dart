import 'package:application/app/ui/dispositivo/controller/dispositivo_controller.dart';
import 'package:application/app/ui/widgets/dropdown_widget_devices_type.dart';
import 'package:application/app/ui/widgets/favorite_widget_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DispositivoEditPage extends GetView<DispositivoController> {
  @override
  final controller = Get.find<DispositivoController>();

  DispositivoEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(controller.titulo.value)),
      body: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Obx(()=>(Column(
              children: [
               DropDownDeviceType(
                value:  controller.deviceType.value,
                onChange: (value){
                  controller.defineType(value);
                  }),
          
              FavoriteWidgetSelector(
                isFavorite: controller.isFavorite.value,
                onChange: (){
                  controller.defineFavorite(!controller.isFavorite.value);
                })
              ]
              )),
          ),
            TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
                controller: controller.nomeController,          
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                ),
                controller: controller.descricaoController,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'MQTT HOST',
                ),
                controller: controller.mqttHostController,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'MQTT PORT',
                ),
                controller: controller.mqttPortController,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'MQTT Id',
                ),
                controller: controller.mqttIdUserController,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'MQTT OUT TOPIC',
                ),
                controller: controller.mqttOutTopicController,
              ),
              
               TextFormField(
                decoration: const InputDecoration(
                  labelText: 'MQTT INPUT TOPIC',
                ),
                controller: controller.mqttInputTopicController,
              ),

              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'MQTT USER',
                ),
                controller: controller.mqttUserController,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'MQTT PASSWORD',
                ),
                controller: controller.mqttPasswordController
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