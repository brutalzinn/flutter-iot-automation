
import 'package:application/app/core/infra/repository/dispositivo_repository.dart';
import 'package:application/app/enum/device_type.dart';
import 'package:application/app/enum/extension/device_type_extension.dart';
import 'package:application/app/model/database/dispositivo_model.dart';
import 'package:application/app/ui/dispositivo/dispositivo_click.dart';
import 'package:application/app/ui/dispositivo/utils/device_widget_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DispositivoFavoriteController extends GetxController {

  final DispositivoRepository repository;

  DispositivoFavoriteController(this.repository);

  //variavel do titulo
  String titulo = '';

  //variavel que controla o loading
  RxBool loading = false.obs;

  //variaveis da lista de notas
  final deviceList = <Dispositivo>[].obs;

  final deviceType = Rx<DeviceType>(DeviceType.deviceToggle);

  RxBool isFavorite = false.obs;
  
  //recuperar notas para apresentar na tela inicial

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
 
  onClickDevice(Dispositivo device){
    Get.to(() => DispositivoClickPage(), arguments: {"id":device.id});
  }

//wrong way but i need to finish this project and implement small unit tests
//for sql models
  defineFavorite(bool deviceFavorite){
    isFavorite.value = deviceFavorite;
  }
  defineType(DeviceType tipo){
    deviceType.value = tipo;
  }

  @override
  void onReady(){
    super.onReady();
    getAllFavoriteDevices();
  }

  getAllFavoriteDevices() {
    loading(true);
    repository.getAllFavoriteDevices().then((data) {
      deviceList.value = data;
      loading(false);
    });
  }

    refreshNoteList() {
    // recuperar lista de notas
    getAllFavoriteDevices();
    //fechar dialog
    Get.back();
    //voltar para a lista de notas
    Get.back();
  }
}