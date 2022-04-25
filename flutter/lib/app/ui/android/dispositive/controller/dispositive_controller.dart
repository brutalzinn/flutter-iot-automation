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
    getAll(Get.parameters['room'] as int);
  }

  //recuperar todas as notas
  getAll(int bedRoomId) {
    loading(true);
    repository.getAll(bedRoomId).then((data) {
      deviceList.value = data;
      loading(false);
    });
  }

  //tratar formulario para inclusao de uma nota
  addNote(int bedRoomId) {
    formKey.currentState?.reset();
    nomeController.text = '';
    descricaoController.text = '';
    titulo = 'Adicionar dispositivo';
    Get.offAllNamed("/devices?room=$bedRoomId&id=null");

    //Get.to(() => DispositiveEditPage(), arguments: {"room":bedRoomId, "id":null});
  }

  //tratar formulario para edicao de uma nota passando id via arguments
  editNote(int bedRoomId, Dispositive note) {
    nomeController.text = note.nome;
    descricaoController.text = note.descricao;
    titulo = 'Editar Dispositivo';
    Get.offAllNamed("/devices?room=$bedRoomId&id=${note.id}");

   // Get.to(() => DispositiveEditPage(), arguments: {"room":bedRoomId, "id":note.id});
  }

  editMode() {
    contentFocusNode.unfocus();
    if (formKey.currentState!.validate()) {
      loading(true);
      if (Get.parameters['id'] == null) {
        saveNote();
      } else {
        updateNote();
      }
    }
  }

  saveNote() async {
    final device = Dispositive(
      roomId: Get.parameters['room'] as int,
      nome: nomeController.text.trim(),
      descricao: descricaoController.text.trim(),
      mqttConfig: MQTTConnection(mQTTHost: mqttHostController.text.trim(), mQTTPORT: int.parse(mqttPortController.text), mQTTUSER: mqttUserController.text.trim(), mQTTID: mqttIdUserController.text.trim(), mQTTPASSWORD: mqttPasswordController.text.trim(), mqTTtopic: mqttTopicController.text.trim())
    );
    repository.save(device).then((data) {
      loading(false);
      refreshNoteList();
    });
  }

  updateNote() async {
    final device = Dispositive(
      id: Get.parameters['id'] as int,
      roomId: Get.parameters['room'] as int,
      nome: nomeController.text.trim(),
      descricao: descricaoController.text.trim(),
      mqttConfig: MQTTConnection(mQTTHost: mqttHostController.text.trim(), mQTTPORT: int.parse(mqttPortController.text.trim()), mQTTUSER: mqttUserController.text.trim(), mQTTID: mqttIdUserController.text.trim(), mQTTPASSWORD: mqttPasswordController.text.trim(), mqTTtopic: mqttTopicController.text.trim())

    );
    repository.update(device).then((data) {
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
    getAll(Get.arguments);
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
  // validarConteudo(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Preencha o campo Conteúdo.';
  //   }
  //   return null;
  // }
}