
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

Widget onPreviewWidget(Dispositivo device){
    switch(tipoIdToDeviceType(device.tipoId as int))
    {

      case DeviceType.deviceToggle:
        return DeviceToggle(dispositive: device).getView();

      case DeviceType.deviceRGB:
        return DeviceRGB(dispositive: device).getView();

      case DeviceType.devicePower:
        return DevicePower(dispositive: device).getView();

     default:
        return const Text("Sem implementação.");
   }
}

Widget onPreviewWidgetCustomData(Dispositivo? device){
  
      if(device == null){
        return  Text("Sem implementação.");
      }
      
      switch(tipoIdToDeviceType(device.tipoId as int))
      {
        case DeviceType.deviceToggle:
          return DeviceToggle().getCustomOption();

        case DeviceType.deviceRGB:
          return DeviceRGB().getCustomOption();
        //editando custom data aqui
        case DeviceType.devicePower:
          return DevicePower().getCustomOption();
      }
    
}