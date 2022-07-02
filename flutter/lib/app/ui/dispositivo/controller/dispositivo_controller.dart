
import 'package:application/app/core/infra/repository/dispositivo_repository.dart';
import 'package:application/app/enum/device_type.dart';
import 'package:application/app/enum/extension/device_type_extension.dart';
import 'package:application/app/model/database/dispositivo_model.dart';
import 'package:application/app/mqtt/mqtt_connection.dart';
import 'package:application/app/ui/dispositivo/dispositivo_click.dart';
import 'package:application/app/ui/dispositivo/dispositivo_edit.dart';
import 'package:application/app/ui/dispositivo/utils/device_widget_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DispositivoController extends GetxController {

  final DispositivoRepository repository;

  DispositivoController(this.repository);

  RxString titulo = RxString("");

  RxBool loading = RxBool(false);

  final deviceList = <Dispositivo>[].obs;

  Rx<Dispositivo> dispositivoAtual = Rx<Dispositivo>(Dispositivo(id:null, tipoId: 0, roomId: 0));
  Rx<DeviceType> tipoDispositivoAtual = Rx<DeviceType>(DeviceType.deviceToggle);

  //Rx<DeviceType> tipoDispositivo = Rx<DeviceType>(DeviceType.devicePower);
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

  onClickDevice(Dispositivo device){
    dispositivoAtual.value = device;
    Get.to(() => DispositivoClickPage());
  }

  definirTipo(DeviceType tipo){
    tipoDispositivoAtual.value = tipo;
    dispositivoAtual.value.definirTipo(tipo);
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

  void closeView(){
    dispositivoAtual.value.obterEspecialidade().onClose();
    dispositivoAtual.value = Dispositivo(id: null, tipoId: 0, roomId: 0);
    Get.back();
  }

  @override
  void onReady() {
    dispositivoAtual.value.roomId = int.parse(Get.parameters['roomId'] ?? "-1");
    if(dispositivoAtual.value.roomId != -1) {
      getAll(dispositivoAtual.value.roomId);
      return;
    }
    getAllFavoriteDevices();
    super.onReady();

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
    dispositivoAtual.value.customData = [];
    definirTipo(DeviceType.deviceToggle);
    titulo.value = 'Adicionar dispositivo';
    Get.to(() => DispositivoEditPage());
  }

  editNote(Dispositivo dispositivo) {
    dispositivoAtual.value = dispositivo;
    nomeController.text = dispositivo.nome ?? "";
    descricaoController.text = dispositivo.descricao ?? "";
    mqttPortController.text = dispositivo.mqttConfig?.mQTTPORT.toString() ?? "";
    mqttHostController.text = dispositivo.mqttConfig?.mQTTHost ?? "";
    mqttIdUserController.text = dispositivo.mqttConfig?.mQTTID ?? "";
    mqttUserController.text = dispositivo.mqttConfig?.mQTTUSER ?? "";
    mqttOutTopicController.text = dispositivo.mqttConfig?.mqTTOutTopic ?? "";
    mqttInputTopicController.text = dispositivo.mqttConfig?.mqTTInputTopic ?? "";
    mqttPasswordController.text = dispositivo.mqttConfig?.mQTTPASSWORD ?? "";
    isFavorite.value = dispositivo.isFavorite as bool;
    tipoDispositivoAtual.value = dispositivo.obterTipo();
    //device.customData = device.obterEspecialidade().createCustomData();
    definirTipo(dispositivo.obterTipo());

    titulo.value = 'Editar Dispositivo';
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
    final dispositivo = Dispositivo(
      roomId: dispositivoAtual.value.roomId,
      isFavorite: isFavorite.value,
      tipoId: dispositivoAtual.value.tipoId,
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

    dispositivo.customData = dispositivoAtual.value.obterEspecialidade().createCustomData();

    repository.save(dispositivo).then((data) {
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

    dispositivo.customData = dispositivoAtual.value.obterEspecialidade().createCustomData();
    
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