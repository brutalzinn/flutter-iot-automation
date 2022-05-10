


import 'dart:async';

import 'package:application/app/data/model/database/dispositive_model.dart';
import 'package:application/app/data/model/item_abstract.dart';
import 'package:application/app/data/model/mqtt_payload.dart';
import 'package:application/app/data/provider/mqtt_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DevicePower extends ItemAbstract 
{

  RxDouble powerLevel = 0.0.obs;
  Timer? _senderTime;

  late MQTTClient mqttClient;

  DevicePower({ required Dispositive dispositive }) : super(dispositive: dispositive){
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
          print(data.message!["status"]);
          powerLevel.value = data.message!["status"];
      });
     mqttClient.connect();

  }


  void sendMQTTMessage()  {
    if(_senderTime?.isActive ?? false) _senderTime?.cancel();
    _senderTime= Timer(Duration(seconds: 1),() {
        var message = MessagePayload(message: {"power":powerLevel.value}, event: 0);
        mqttClient.sendMessage(message);
    });
 
  }
  
  
  @override
  Widget getView() {
    return Center(
      child: Column(
        children: [
            const Text("DEVICE POWER",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
           ),

            Obx(() =>Column(children: [
            // Text("Status: ${powerLevel != 0 ? "Desconectado"}",
            // style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            // ),
            Slider(
            divisions: 10,
            min: 0.0,
            max: 100.0,
            value: powerLevel.value,
            onChanged: (value) {
              powerLevel.value = value;
              sendMQTTMessage();
            },
          ),
           Text("Potência: ${powerLevel.value.toInt()}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),



           ]))
            
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