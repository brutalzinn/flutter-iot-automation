import 'package:application/app/ui/android/dispositive/controller/dispositive_controller.dart';
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
                controller: controller.nomeController,
                focusNode: controller.titleFocusNode,
                textInputAction: TextInputAction.next,
            
                onEditingComplete: controller.contentFocusNode.requestFocus,
                onFieldSubmitted: (String value) {
                  controller.contentFocusNode.requestFocus();
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                ),
                controller: controller.descricaoController,
                focusNode: controller.titleFocusNode,
                textInputAction: TextInputAction.next,
            
                onEditingComplete: controller.contentFocusNode.requestFocus,
                onFieldSubmitted: (String value) {
                  controller.contentFocusNode.requestFocus();
                },
              ),
                TextFormField(
                decoration: const InputDecoration(
                  labelText: 'MQTT HOST',
                ),
                controller: controller.mqttHostController,
                focusNode: controller.titleFocusNode,
                textInputAction: TextInputAction.next,
            
                onEditingComplete: controller.contentFocusNode.requestFocus,
                onFieldSubmitted: (String value) {
                  controller.contentFocusNode.requestFocus();
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'MQTT PORT',
                ),
                controller: controller.mqttPortController,
                focusNode: controller.titleFocusNode,
                textInputAction: TextInputAction.next,
            
                onEditingComplete: controller.contentFocusNode.requestFocus,
                onFieldSubmitted: (String value) {
                  controller.contentFocusNode.requestFocus();
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'MQTT Id',
                ),
                controller: controller.mqttIdUserController,
                focusNode: controller.titleFocusNode,
                textInputAction: TextInputAction.next,
            
                onEditingComplete: controller.contentFocusNode.requestFocus,
                onFieldSubmitted: (String value) {
                  controller.contentFocusNode.requestFocus();
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'MQTT TOPIC',
                ),
                controller: controller.mqttTopicController,
                focusNode: controller.titleFocusNode,
                textInputAction: TextInputAction.next,
            
                onEditingComplete: controller.contentFocusNode.requestFocus,
                onFieldSubmitted: (String value) {
                  controller.contentFocusNode.requestFocus();
                },
              ),

              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'MQTT USER',
                ),
                controller: controller.mqttUserController,
                focusNode: controller.titleFocusNode,
                textInputAction: TextInputAction.next,
            
                onEditingComplete: controller.contentFocusNode.requestFocus,
                onFieldSubmitted: (String value) {
                  controller.contentFocusNode.requestFocus();
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'MQTT PASSWORD',
                ),
                controller: controller.mqttPasswordController,
                focusNode: controller.titleFocusNode,
                textInputAction: TextInputAction.next,
            
                onEditingComplete: controller.contentFocusNode.requestFocus,
                onFieldSubmitted: (String value) {
                  controller.contentFocusNode.requestFocus();
                },
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