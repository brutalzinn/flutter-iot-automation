import 'package:application/app/ui/android/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeEditPage extends GetView<HomeController> {
  @override
  final controller = Get.find<HomeController>();

  HomeEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(controller.titulo)),
      body: Form(
        key: controller.formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Cômodo',
                ),
                controller: controller.nomeController,
                focusNode: controller.titleFocusNode,
                textInputAction: TextInputAction.next,
            
                onEditingComplete: controller.contentFocusNode.requestFocus,
                onFieldSubmitted: (String value) {
                  controller.contentFocusNode.requestFocus();
                },
                validator: (value) {
                  return controller.validarTitulo(value, "Preencha o campo Cômodo");
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                ),
                controller: controller.descricaoController,
                focusNode: controller.contentFocusNode,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (String value) {
                  controller.editMode();
                  if (controller.loading.value == true) {
                    Get.dialog(const Center(child: CircularProgressIndicator()));
                  }
                },
                // validator: (value) {
                //   return controller.validarConteudo(value);
                // },
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