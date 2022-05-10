import 'package:application/app/data/enum/device_type.dart';
import 'package:application/app/data/enum/extension/device_type_extension.dart';
import 'package:application/app/data/model/devices/device_power/device_power.dart';
import 'package:application/app/data/model/devices/device_rgb/device_rgb.dart';
import 'package:application/app/data/model/devices/device_toggle/device_toggle.dart';
import 'package:application/app/data/model/database/dispositive_model.dart';
import 'package:application/app/data/repository/dispositive_repository.dart';
import 'package:application/app/ui/android/dispositive/dispositive_click.dart';
import 'package:application/app/ui/android/dispositive/utils/device_widget_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DispositiveFavoriteController extends GetxController {

  final DispositiveRepository repository;

  DispositiveFavoriteController(this.repository);

  //variavel do titulo
  String titulo = '';

  //variavel que controla o loading
  RxBool loading = false.obs;

  //variaveis da lista de notas
  final deviceList = <Dispositive>[].obs;

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
 
  onClickDevice(Dispositive device){
    Get.to(() => DispositiveClickPage(), arguments: {"id":device.id});
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