
import 'package:application/app/core/infra/repository/dispositivo_repository.dart';
import 'package:application/app/enum/device_type.dart';
import 'package:application/app/model/database/dispositivo_model.dart';
import 'package:application/app/mqtt/devices/device_power/device_power.dart';
import 'package:application/app/mqtt/devices/device_rgb/device_rgb.dart';
import 'package:application/app/mqtt/devices/device_toggle/device_toggle.dart';
import 'package:flutter/material.dart';

DeviceType tipoIdToDeviceType(int id){
   return DeviceType.values[id];
 }

Widget onPreviewWidget(Dispositivo? device){

    if(device == null ||  device.itemAbstract == null ){
      return  Text("Sem implementação.");
    }
    return device.itemAbstract!.getView();
}

Widget onPreviewWidgetCustomData(Dispositivo? device){
  
      if(device == null ||  device.itemAbstract == null ){
        return  Text("Sem implementação.");
      }
      return device.itemAbstract!.getCustomOption();
    
}