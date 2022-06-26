


import 'dart:async';
import 'package:application/app/core/infra/provider/mqtt_provider.dart';
import 'package:application/app/core/infra/repository/dispositivo_repository.dart';
import 'package:application/app/model/custom_data.dart';
import 'package:application/app/model/database/dispositivo_model.dart';
import 'package:application/app/mqtt/devices/device_rgb/model/color.dart';
import 'package:application/app/mqtt/item_abstract.dart';
import 'package:application/app/mqtt/mqtt_payload.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
class DeviceRGB extends ItemAbstract 
{

  Rx<String>? messagePayload = Rx<String>("");
  RxBool toggleButton = false.obs;
  Timer? _senderTime;

  late MQTTClient mqttClient;

  DeviceRGB({ Dispositivo? dispositive }) : super(dispositive: dispositive){
    onConnectMQTT();
  }

  
  @override
  void onClose() {
    if(dispositive == null){
      return;
    }
      print("Desconectando MQTT..");
      mqttClient.disconnect();
  }
  
  @override
  void onConnectMQTT(){
    if(dispositive == null){
      return;
    }
   mqttClient = MQTTClient(dispositive!, (data) {
          messagePayload!.value = data.message!["status"] ? 'Ativo' : 'Inativo';
      });
     mqttClient.connect();

  }


  void sendMQTTMessage(RgbColor color)  {
    if(dispositive == null){
      return;
    }
    if(_senderTime?.isActive ?? false) _senderTime?.cancel();
    _senderTime= Timer(Duration(seconds: 1),() {
      var message = MessagePayload(message: {"payload": color.toJson()},  event: 0);
      mqttClient.sendMessage(message);
    });
    
  }
  
  @override
  Widget getView() {
    return Center(
      child: Column(
        children: [
            const Text("SIMPLE RGB",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
           ),
            Obx(() =>
            Text("Status: ${messagePayload ?? "Desconectado"}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
           )),
          ColorPicker(
            pickerColor: Colors.blue, 
            onColorChanged: (Color color)
            {
            var payload = RgbColor(blue: color.blue, red: color.red,green: color.green);
              sendMQTTMessage(payload);
            }, 
          )
        ],
      ),
    );
  }

  @override
  Widget getCustomOption() {
        return TextFormField(
          decoration: const InputDecoration(
          labelText: 'Custom dynamic widget',
        ),
        textInputAction: TextInputAction.next,
      );
  }

  @override
  void loadCustomData() {
    // TODO: implement loadCustomData
  }

  @override
  List<CustomData> saveCustomData() {
    // TODO: implement saveCustomData
    throw UnimplementedError();
  }

 

}