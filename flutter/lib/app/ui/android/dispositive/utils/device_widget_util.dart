import 'package:application/app/data/enum/device_type.dart';
import 'package:application/app/data/model/database/dispositive_model.dart';
import 'package:application/app/data/model/devices/device_power/device_power.dart';
import 'package:application/app/data/model/devices/device_rgb/device_rgb.dart';
import 'package:application/app/data/model/devices/device_toggle/device_toggle.dart';
import 'package:flutter/material.dart';

DeviceType tipoIdToDeviceType(int id){
   return DeviceType.values[id];
 }

Widget onPreviewWidget(Dispositive device){
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