import 'package:application/app/data/model/dispositive_model.dart';
import 'package:application/app/data/model/mqtt_connection.dart';
import 'package:application/app/data/repository/dispositive_repository.dart';
import 'package:application/app/ui/android/dispositive/dispositive_edit.dart';
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

  final roomId = int.parse(Get.parameters['roomId']!);
  final tipoDevice = Rx<int>(0);
  //variaveis do form
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nomeController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();

  //-MQTT--
  TextEditingController mqttHostController = TextEditingController();
  TextEditingController mqttPasswordController = TextEditingController();
  TextEditingController mqttUserController = TextEditingController();
  TextEditingController mqttPortController = TextEditingController();
  TextEditingController mqttIdUserController = TextEditingController();
  TextEditingController mqttTopicController = TextEditingController();
  
  //---
  FocusNode nomeFocusNode = FocusNode();
  FocusNode descricaoFocusNode = FocusNode();
  FocusNode mqttHostFocusNode = FocusNode();
  FocusNode mqttPasswordFocusNode = FocusNode();
  FocusNode mqttUserFocusNode = FocusNode();
  FocusNode mqttPortFocusNode = FocusNode();
  FocusNode mqttIdUserFocusNode = FocusNode();
  FocusNode mqttTopicFocusNode = FocusNode();


  //recuperar notas para apresentar na tela inicial
  @override
  void onReady() async {
    super.onReady();
    getAll(roomId);
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
  addNote() {
    formKey.currentState?.reset();
    nomeController.text = '';
    descricaoController.text = '';
    titulo = 'Adicionar dispositivo';
    Get.to(() => DispositiveEditPage(), arguments: {"room":roomId});
  }

  //tratar formulario para edicao de uma nota passando id via arguments
  editNote(Dispositive note) {
    nomeController.text = note.nome;
    descricaoController.text = note.descricao;
    titulo = 'Editar Dispositivo';
    Get.to(() => DispositiveEditPage(), arguments: {"room":note.roomId, "id":note.id});
  }

  editMode() {
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
      roomId: roomId,
      tipoId: tipoDevice.value,
      nome: nomeController.text.trim(),
      descricao: descricaoController.text.trim(),
      mqttConfig: MQTTConnection(mQTTHost: mqttHostController.text.trim(), mQTTPORT: mqttPortController.text.trim() != "" ? int.parse(mqttPortController.text.trim()) : 1883, mQTTUSER: mqttUserController.text.trim(), mQTTID: mqttIdUserController.text.trim(), mQTTPASSWORD: mqttPasswordController.text.trim(), mqTTtopic: mqttTopicController.text.trim())
    );
    repository.save(device).then((data) {
      loading(false);
      refreshNoteList();
    });
  }

  updateNote() async {
    final device = Dispositive(
      id: Get.arguments['id'] as int,
      roomId: roomId,
      tipoId: tipoDevice.value,
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
    getAll(roomId);
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