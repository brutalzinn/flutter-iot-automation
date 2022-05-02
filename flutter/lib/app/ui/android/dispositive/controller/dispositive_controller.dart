import 'package:application/app/data/enum/device_type.dart';
import 'package:application/app/data/enum/device_type_extension.dart';
import 'package:application/app/data/model/devices/power.dart';
import 'package:application/app/data/model/devices/simple_switch.dart';
import 'package:application/app/data/model/devices/simple_toggle.dart';
import 'package:application/app/data/model/database/dispositive_model.dart';
import 'package:application/app/data/model/mqtt_connection.dart';
import 'package:application/app/data/repository/dispositive_repository.dart';
import 'package:application/app/ui/android/dispositive/dispositive_click.dart';
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

  final deviceType = Rx<DeviceType>(DeviceType.simpleToggle);

  final roomId = int.parse(Get.parameters['roomId']!);

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
  // FocusNode nomeFocusNode = FocusNode();
  // FocusNode descricaoFocusNode = FocusNode();
  // FocusNode mqttHostFocusNode = FocusNode();
  // FocusNode mqttPasswordFocusNode = FocusNode();
  // FocusNode mqttUserFocusNode = FocusNode();
  // FocusNode mqttPortFocusNode = FocusNode();
  // FocusNode mqttIdUserFocusNode = FocusNode();
  // FocusNode mqttTopicFocusNode = FocusNode();

  //recuperar notas para apresentar na tela inicial
 DeviceType tipoIdToDeviceType(int id){
   return DeviceType.values[id];
 }

  Widget showDeviceView(){
    final deviceId = Get.arguments['id'] as int;
    final device = deviceList.firstWhereOrNull((element) => element.id == deviceId);
    if(device != null) {
      return onPreviewWidget(device);
    }
    return const Text("Sem implementação.");
  }

 String getDeviceTypeEnumTitle(int? type){
   return tipoIdToDeviceType(type ?? 0).displayTitle;
 } 

 Widget onPreviewWidget(Dispositive device){
    switch(tipoIdToDeviceType(device.tipoId as int)){
     case DeviceType.simpleToggle:
        return SimpleToggle(dispositive: device).getView();

      case DeviceType.simpleSwitch:
        return SimpleSwitch(dispositive: device).getView();

      case DeviceType.powerControl:
        return Power(dispositive: device).getView();
      default:
        return const Text("Sem implementação.");
   }
  }

  onClickDevice(Dispositive device){
    Get.to(() => DispositiveClickPage(), arguments: {"id":device.id});
  }

  defineType(DeviceType tipo){
    deviceType.value = tipo;
  }

  @override
  void onReady() async {
    super.onReady();
    getAll(roomId);
  }

  getAll(int deviceId) {
    loading(true);
    repository.getAllDevicesById(deviceId).then((data) {
      deviceList.value = data;
      loading(false);
    });
  }

  addNote() {
    formKey.currentState?.reset();
    nomeController.text = "";
    descricaoController.text = "";
    mqttPortController.text = "1883";
    mqttHostController.text = "";
    mqttIdUserController.text = "";
    mqttUserController.text = "";
    mqttTopicController.text = "";
    mqttPasswordController.text = "";
    deviceType.value = DeviceType.simpleSwitch;
    titulo = 'Adicionar dispositivo';
    Get.to(() => DispositiveEditPage(), arguments: {"room":roomId});
  }

  editNote(Dispositive device) {
    
    nomeController.text = device.nome;
    descricaoController.text = device.descricao;
    mqttPortController.text = device.mqttConfig.mQTTPORT.toString();
    mqttHostController.text = device.mqttConfig.mQTTHost;
    mqttIdUserController.text = device.mqttConfig.mQTTID;
    mqttUserController.text = device.mqttConfig.mQTTUSER;
    mqttTopicController.text = device.mqttConfig.mqTTtopic;
    mqttPasswordController.text = device.mqttConfig.mQTTPASSWORD;
    deviceType.value =  DeviceType.values[device.tipoId!];

    titulo = 'Editar Dispositivo';
    Get.to(() => DispositiveEditPage(), arguments: {"room":device.roomId, "id":device.id});
  }

  editMode() {
    if (formKey.currentState!.validate()) {
      loading(true);
      if (Get.arguments['id'] == null) {
        saveNote();
      } else {
        updateNote();
      }
    }
  }

  saveNote() async {
    final device = Dispositive(
      roomId: roomId,
      tipoId: deviceType.value.index,
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
      tipoId: deviceType.value.index,
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
}