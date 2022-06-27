
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

  Rx<Dispositivo> dispositivoAtual = Rx<Dispositivo>(Dispositivo(tipoId: 0, roomId: 0));

  Rx<DeviceType> tipoDispositivo = Rx<DeviceType>(DeviceType.devicePower);
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
  }

  definirTipo(DeviceType tipo){
    tipoDispositivo.value = tipo;
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
    dispositivoAtual.value.obterEspecialidade().onClose();
     Get.back();
  }

  @override
  void onReady() async {
    super.onReady();
    dispositivoAtual.value.roomId = int.parse(Get.parameters['roomId'] ?? "-1");
    if(dispositivoAtual.value.roomId != -1) {
      getAll(dispositivoAtual.value.roomId);
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
    isFavorite.value = device.isFavorite as bool;
    tipoDispositivo.value = device.obterTipo();
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
      roomId: dispositivoAtual.value.roomId,
      isFavorite: isFavorite.value,
      tipoId: tipoDispositivo.value.tipoId,
      nome: nomeController.text.trim(),
      descricao: descricaoController.text.trim(),
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
    device.customData = device.obterEspecialidade().saveCustomData();
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
      tipoId: dispositivoAtual.value.tipoId,
      nome: nomeController.text.trim(),
      customData: dispositivoAtual.value.obterEspecialidade().saveCustomData(),
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
   
    getAll(dispositivoAtual.value.roomId);
    
    //fechar dialog
    Get.back();
    //voltar para a lista de notas
    Get.back();
  }
}