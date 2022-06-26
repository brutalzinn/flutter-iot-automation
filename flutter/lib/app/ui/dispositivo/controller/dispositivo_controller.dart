
import 'package:application/app/core/infra/repository/dispositivo_repository.dart';
import 'package:application/app/enum/device_type.dart';
import 'package:application/app/enum/extension/device_type_extension.dart';
import 'package:application/app/model/custom_data.dart';
import 'package:application/app/model/database/dispositivo_model.dart';
import 'package:application/app/mqtt/devices/device_power/device_power.dart';
import 'package:application/app/mqtt/devices/device_rgb/device_rgb.dart';
import 'package:application/app/mqtt/devices/device_toggle/device_toggle.dart';
import 'package:application/app/mqtt/item_abstract.dart';
import 'package:application/app/mqtt/mqtt_connection.dart';
import 'package:application/app/ui/dispositivo/dispositivo_click.dart';
import 'package:application/app/ui/dispositivo/dispositivo_edit.dart';
import 'package:application/app/ui/dispositivo/utils/device_widget_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DispositivoController extends GetxController {

  final DispositivoRepository repository;

  DispositivoController(this.repository);

  //variavel do titulo
  RxString titulo = "".obs;

  //variavel que controla o loading
  RxBool loading = false.obs;

  //variaveis da lista de notas
  final deviceList = <Dispositivo>[].obs;

  final deviceType = Rx<DeviceType>(DeviceType.deviceToggle);

  Rx<Dispositivo?> dispositivoAtual = Rx<Dispositivo?>(null);

//forma errada. MDS
  int roomId = Get.parameters['roomId'] != null ? int.parse(Get.parameters['roomId'] as String) : -1;
  
  RxBool isFavorite = false.obs;

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
  TextEditingController mqttOutTopicController = TextEditingController();
  TextEditingController mqttInputTopicController = TextEditingController();

  Widget showDeviceView(){
   
    final deviceId = Get.arguments['id'] as int;
    final device = deviceList.firstWhereOrNull((element) => element.id == deviceId);
    if(device != null) {
      device.itemAbstract = obterTipoDispositivo(tipoIdToDeviceType(device.tipoId as int));
      titulo.value = device.nome ?? "";
      return onPreviewWidget(device);
    }
    return const Text("Sem implementação.");
  }

  ItemAbstract obterTipoDispositivo(DeviceType deviceType){
  switch(deviceType)
    {
      case DeviceType.deviceToggle:
        return DeviceToggle(dispositive: dispositivoAtual.value);

      case DeviceType.deviceRGB:
        return DeviceRGB(dispositive: dispositivoAtual.value);

      case DeviceType.devicePower:
        return DevicePower(dispositive: dispositivoAtual.value);
   }
  }

  defineType(DeviceType tipo){
    deviceType.value = tipo;
    dispositivoAtual.value?.itemAbstract = obterTipoDispositivo(tipo);
  }

  defineFavorite(bool deviceFavorite){
    isFavorite.value = deviceFavorite;
  }
 
  String getAmbience(){
   return Get.parameters["room"] as String;
 } 

 String getDeviceTypeEnumTitle(int? type){
   return tipoIdToDeviceType(type ?? 0).displayTitle;
 } 

  
  onClickDevice(Dispositivo device){
    Get.to(() => DispositivoClickPage(), arguments: {"id":device.id});
  }

  void closeView(){
    final deviceId = Get.arguments['id'] as int;
    final device = deviceList.firstWhereOrNull((element) => element.id == deviceId);
    if(device != null){
      device.itemAbstract?.onClose();
    }
     Get.back();
  }

  @override
  void onReady() async {
    super.onReady();
    if(roomId != -1) {
      getAll(roomId);
      return;
    }
    getAllFavoriteDevices();
  }

  getAll(int bedRoomId) {
    loading(true);
    repository.getAllDevicesById(bedRoomId).then((data) {
      deviceList.value = data;
      loading(false);
    });
  }

  getAllFavoriteDevices() {
    loading(true);
    repository.getAllFavoriteDevices().then((data) {
      deviceList.value = data;
      loading(false);
    });
  }

  addNote() {
    dispositivoAtual.value = Dispositivo();
    formKey.currentState?.reset();
    nomeController.text = "";
    descricaoController.text = "";
    mqttPortController.text = "1883";
    mqttHostController.text = "";
    mqttIdUserController.text = "";
    mqttUserController.text = "";
    mqttOutTopicController.text = "";
    mqttInputTopicController.text = "";
    mqttPasswordController.text = "";
    deviceType.value = DeviceType.deviceToggle;
    isFavorite.value = false;
    titulo.value = 'Adicionar dispositivo';
    Get.to(() => DispositivoEditPage(), arguments: {"room":roomId});
  }

  editNote(Dispositivo device) {
    dispositivoAtual.value = device;
    nomeController.text = device.nome ?? "";
    descricaoController.text = device.descricao ?? "";
    mqttPortController.text = device.mqttConfig?.mQTTPORT.toString() ?? "";
    mqttHostController.text = device.mqttConfig?.mQTTHost ?? "";
    mqttIdUserController.text = device.mqttConfig?.mQTTID ?? "";
    mqttUserController.text = device.mqttConfig?.mQTTUSER ?? "";
    mqttOutTopicController.text = device.mqttConfig?.mqTTOutTopic ?? "";
    mqttInputTopicController.text = device.mqttConfig?.mqTTInputTopic ?? "";
    mqttPasswordController.text = device.mqttConfig?.mQTTPASSWORD ?? "";
    deviceType.value =  DeviceType.values[device.tipoId!];
    isFavorite.value = device.isFavorite as bool;
    titulo.value = 'Editar Dispositivo';
    Get.to(() => DispositivoEditPage(), arguments: {"room":device.roomId, "id":device.id});
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
    final device = Dispositivo(
      roomId: roomId,
      isFavorite: isFavorite.value,
      tipoId: deviceType.value.index,
      nome: nomeController.text.trim(),
      descricao: descricaoController.text.trim(),
      customData: [],
      mqttConfig: MQTTConnection(
        mQTTHost: mqttHostController.text.trim(), 
        mQTTPORT: mqttPortController.text.trim() != "" ? int.parse(mqttPortController.text.trim()) : 1883, 
        mQTTUSER: mqttUserController.text.trim(), 
        mQTTID: mqttIdUserController.text.trim(), 
        mQTTPASSWORD: mqttPasswordController.text.trim(), 
        mqTTOutTopic: mqttOutTopicController.text.trim(),
        mqTTInputTopic: mqttInputTopicController.text.trim()
        )
    );
    repository.save(device).then((data) {
      loading(false);
      refreshNoteList();
    });
  }

  updateNote() async {

    final dispositivo = Dispositivo(
      id: Get.arguments['id'] as int,
      roomId: roomId,
      isFavorite: isFavorite.value,
      tipoId: deviceType.value.index,
      nome: nomeController.text.trim(),
      customData: dispositivoAtual.value?.itemAbstract?.saveCustomData() ?? [],
      descricao: descricaoController.text.trim(),
      mqttConfig: MQTTConnection(mQTTHost: mqttHostController.text.trim(),
       mQTTPORT: int.parse(mqttPortController.text.trim()),
        mQTTUSER: mqttUserController.text.trim(), 
        mQTTID: mqttIdUserController.text.trim(), 
        mQTTPASSWORD: mqttPasswordController.text.trim(), 
        mqTTOutTopic: mqttOutTopicController.text.trim(),
        mqTTInputTopic: mqttInputTopicController.text.trim()
        )
    );

    repository.update(dispositivo).then((data) {
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