
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

  Rx<Dispositivo> dispositivoAtual = Rx<Dispositivo>(Dispositivo());

//forma errada. MDS  
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
 
    titulo.value = dispositivoAtual.value.nome ?? "";
    return onPreviewWidget(dispositivoAtual.value);
    
    // return const Text("Sem implementação.");
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
    dispositivoAtual.value = device;
    Get.to(() => DispositivoClickPage());
  }

  void closeView(){
    dispositivoAtual.value.itemAbstract()?.onClose();
     Get.back();
  }

  @override
  void onReady() async {
    super.onReady();
    int roomId  = int.parse(Get.parameters['roomId'] ?? "-1");
    if(roomId != -1) {
      getAll(roomId);
      return;
    }
    getAllFavoriteDevices();
  }

  getAll(int ambienteId) {
    loading(true);
    repository.getAllDevicesByAmbiente(ambienteId).then((data) {
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
    Get.to(() => DispositivoEditPage());
  }

  editNote(Dispositivo device) {
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
    dispositivoAtual.value = device;
    Get.to(() => DispositivoEditPage());
  }

  editMode() {
    if (formKey.currentState!.validate()) {
      loading(true);
      if (dispositivoAtual.value.id == null) {
        saveNote();
      } else {
        updateNote();
      }
    }
  }

  saveNote() async {
    final device = Dispositivo(
      roomId: int.parse(Get.parameters['roomId'] ?? "-1"),
      isFavorite: isFavorite.value,
      tipoId: deviceType.value.index,
      nome: nomeController.text.trim(),
      descricao: descricaoController.text.trim(),
      // customData: dispositivoAtual.value?.obterTipo().saveCustomData() ?? [],
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
    device.customData = device.itemAbstract()?.saveCustomData();
    dispositivoAtual.value = device;
    repository.save(device).then((data) {
      loading(false);
      refreshNoteList();
    });
  }

  updateNote() async {

    final dispositivo = Dispositivo(
      id: dispositivoAtual.value.id,
      roomId: dispositivoAtual.value.roomId,
      isFavorite: isFavorite.value,
      tipoId: deviceType.value.index,
      nome: nomeController.text.trim(),
      customData: dispositivoAtual.value.itemAbstract()?.saveCustomData(),
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
    if(dispositivoAtual.value.roomId != -1) {
      getAll(int.parse(Get.parameters['roomId'] ?? "-1"));
    }
    //fechar dialog
    Get.back();
    //voltar para a lista de notas
    Get.back();
  }
}