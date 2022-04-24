import 'dart:ffi';

import 'package:application/app/data/model/dispositive_model.dart';
import 'package:application/app/data/model/mqtt_client_config.dart';
import 'package:application/app/data/model/quarto_model.dart';
import 'package:application/app/data/repository/dispositive_repository.dart';
import 'package:application/app/ui/android/dispositive/dispositive_edit.dart';
import 'package:application/app/ui/android/home/home_edit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DispositiveController extends GetxController {

  final DispositiveRepository repository;
  
  DispositiveController(this.repository);

  //variavel do titulo
  String titulo = '';

  //variavel que controla o loading
  RxBool loading = false.obs;

  //variaveis da lista de notas
  final deviceList = <Dispositive>[].obs;

  //variaveis do form
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nomeController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();
  //---
  TextEditingController mqttHostController = TextEditingController();
  TextEditingController mqttPasswordController = TextEditingController();
  TextEditingController mqttUserController = TextEditingController();
  TextEditingController mqttPortController = TextEditingController();
  TextEditingController mqttIdUserController = TextEditingController();
  TextEditingController mqttTopicController = TextEditingController();

  //---
  FocusNode titleFocusNode = FocusNode();
  FocusNode contentFocusNode = FocusNode();

  //recuperar notas para apresentar na tela inicial
  @override
  void onReady() async {
    super.onReady();
    getAll();
  }

  //recuperar todas as notas
  getAll() {
    loading(true);
    repository.getAll(Get.arguments).then((data) {
      deviceList.value = data;
      loading(false);
    });
  }

  //tratar formulario para inclusao de uma nota
  addNote() {
    formKey.currentState?.reset();
    nomeController.text = '';
    descricaoController.text = '';
    titulo = 'Incluir Nota';
    Get.to(() => DispositiveEditPage());
  }

  //tratar formulario para edicao de uma nota passando id via arguments
  editNote(Dispositive note) {
    nomeController.text = note.nome;
    descricaoController.text = note.descricao;
    titulo = 'Editar Dispositivo';
    Get.to(() => DispositiveEditPage(), arguments: note.id);
  }

  editMode() {
    contentFocusNode.unfocus();
    if (formKey.currentState!.validate()) {
      loading(true);
      if (Get.arguments == null) {
        saveNote();
      } else {
        updateNote();
      }
    }
  }

  saveNote() async {
    final device = Dispositive(
      nome: nomeController.text.trim(),
      descricao: descricaoController.text.trim(),
      mqttConfig: MQTTConnection(mQTTHost: mqttHostController.text.trim(), mQTTPORT: int.parse(mqttPortController.text), mQTTUSER: mqttUserController.text.trim(), mQTTID: mqttIdUserController.text.trim(), mQTTPASSWORD: mqttPasswordController.text.trim(), mqTTtopic: mqttTopicController.text.trim())
    );
    repository.save(device, Get.arguments).then((data) {
      loading(false);
      refreshNoteList();
    });
  }

  updateNote() async {
    final device = Dispositive(
      id: Get.arguments,
      nome: nomeController.text.trim(),
      descricao: descricaoController.text.trim(),
      mqttConfig: MQTTConnection(mQTTHost: mqttHostController.text.trim(), mQTTPORT: int.parse(mqttPortController.text), mQTTUSER: mqttUserController.text.trim(), mQTTID: mqttIdUserController.text.trim(), mQTTPASSWORD: mqttPasswordController.text.trim(), mqTTtopic: mqttTopicController.text.trim())

    );
    repository.update(device, Get.arguments).then((data) {
      loading(false);
      refreshNoteList();
    });
  }

  deleteNote(int noteId) async {
    loading(true);
    repository.delete(noteId).then((data) {
      loading(false);
      refreshNoteList();
    });
  }

    refreshNoteList() {
    // recuperar lista de notas
    getAll();
    //fechar dialog
    Get.back();
    //voltar para a lista de notas
    Get.back();
  }

  // validar campo titulo
  validarTitulo(String? value) {
    if (value == null || value.isEmpty) {
      return 'Preencha o campo Título.';
    }
    return null;
  }

  //validar campo conteudo
  validarConteudo(String? value) {
    if (value == null || value.isEmpty) {
      return 'Preencha o campo Conteúdo.';
    }
    return null;
  }
}