
import 'package:application/app/enum/device_type.dart';
import 'package:application/app/model/database/dispositivo_model.dart';
import 'package:flutter/material.dart';

DeviceType tipoIdToDeviceType(int id){
   return DeviceType.values[id];
 }

Widget onPreviewWidget(Dispositivo dispositivo){
    return dispositivo.obterEspecialidade().getView();
}

Widget onPreviewWidgetCustomData(Dispositivo dispositivo){
    return dispositivo.obterEspecialidade().getCustomOption();
}