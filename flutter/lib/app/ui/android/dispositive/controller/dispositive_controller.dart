import 'dart:ffi';

import 'package:application/app/data/model/dispositive_model.dart';
import 'package:application/app/data/model/mqtt_client_config.dart';
import 'package:application/app/data/model/quarto_model.dart';
import 'package:application/app/data/repository/dispositive_repository.dart';
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
  final noteList = <Dispositive>[].obs;

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
  // @override
  // void onReady() async {
  //   super.onReady();
  //   getAll();
  // }

  //recuperar todas as notas
  getAll(int bedRoomId) {
    loading(true);
    repository.getAll(bedRoomId).then((data) {
      noteList.value = data;
      loading(false);
    });
  }

  //tratar formulario para inclusao de uma nota
  addNote() {
    formKey.currentState?.reset();
    nomeController.text = '';
    descricaoController.text = '';
    titulo = 'Incluir Nota';
    Get.to(() => HomeEditPage());
  }

  //tratar formulario para edicao de uma nota passando id via arguments
  editNote(Dispositive note) {
    nomeController.text = note.nome;
    descricaoController.text = note.descricao;
    titulo = 'Editar Nota';
    Get.to(() => HomeEditPage(), arguments: note.id);
  }

  //verificar se o formulario esta validado sem erros
  //e se um id de nota eh enviado para a tela de edicao
  //a nota sera atualizada, caso contrario sera criada uma nova nota
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

  //salvar uma nova nota
  saveNote() async {
    final note = Dispositive(
      nome: nomeController.text.trim(),
      descricao: descricaoController.text.trim(),
      mqttConfig: MQTTConnection(mQTTHost: mqttHostController.text.trim(), mQTTPORT: int.parse(mqttPortController.text), mQTTUSER: mqttUserController.text.trim(), mQTTID: mqttIdUserController.text.trim(), mQTTPASSWORD: mqttPasswordController.text.trim(), mqTTtopic: mqttTopicController.text.trim())
    );
    repository.save(note).then((data) {
      loading(false);
      refreshNoteList();
    });
  }

  //atualizar uma nota existente cujo id eh recuperado via arguments
  updateNote() async {
    final note = Dispositive(
      id: Get.arguments,
      nome: nomeController.text.trim(),
      descricao: descricaoController.text.trim(),
      mqttConfig: MQTTConnection(mQTTHost: mqttHostController.text.trim(), mQTTPORT: int.parse(mqttPortController.text), mQTTUSER: mqttUserController.text.trim(), mQTTID: mqttIdUserController.text.trim(), mQTTPASSWORD: mqttPasswordController.text.trim(), mqTTtopic: mqttTopicController.text.trim())

    );
    repository.update(note).then((data) {
      loading(false);
      refreshNoteList();
    });
  }

  //excluir nota via id
  deleteNote(int noteId) async {
    loading(true);
    repository.delete(noteId).then((data) {
      loading(false);
      refreshNoteList();
    });
  }

  // atualizar lista de notas apos uma inclusao, alteracao ou exclusao
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