


import 'package:application/app/data/model/database/dispositive_model.dart';
import 'package:application/app/data/model/devices/device_rgb/model/color.dart';
import 'package:application/app/data/model/item_abstract.dart';
import 'package:application/app/data/model/mqtt_payload.dart';
import 'package:application/app/data/provider/mqtt_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'dart:convert';
class RgbWidget extends ItemAbstract 
{

  Rx<String>? messagePayload = Rx<String>("");
  RxBool toggleButton = false.obs;

  late MQTTClient mqttClient;

  RgbWidget({ required Dispositive dispositive }) : super(dispositive: dispositive){
    onConnectMQTT();
  }

  
  @override
  void onClose() {
      print("Desconectando MQTT..");
      mqttClient.disconnect();
  }
  
  @override
  void onConnectMQTT(){
   mqttClient = MQTTClient(dispositive, (data) {
          messagePayload!.value = data.message!["status"] ? 'Ativo' : 'Inativo';
      });
     mqttClient.connect();

  }


  void sendMQTTMessage(RgbColor color)  {
    var message = MessagePayload(message: {"payload": color.toJson()},  event: 0);
    mqttClient.sendMessage(message);
  }
  
  
  @override
  Widget getView() {
    return Center(
      child: Column(
        children: [
            const Text("SIMPLE RGB ARDUINO TEST",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
           ),
            Obx(() =>
            Text("Status: ${messagePayload ?? "Desconectado"}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
           )),
          ColorPicker(
            pickerColor: Colors.blue, //default color
            onColorChanged: (Color color){ //on color picked
            var payload = RgbColor(blue: color.blue,red: color.red,green: color.green);
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

 

 


  
 
}