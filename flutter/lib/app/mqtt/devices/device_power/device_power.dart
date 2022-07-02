


import 'dart:async';
import 'package:application/app/core/infra/provider/mqtt_provider.dart';
import 'package:application/app/model/custom_data.dart';
import 'package:application/app/model/database/dispositivo_model.dart';
import 'package:application/app/mqtt/item_abstract.dart';
import 'package:application/app/mqtt/mqtt_payload.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DevicePower extends TipoDispositivoAbstract 
{
  RxDouble powerLevel = 0.0.obs;

  RxnInt stepLevel = RxnInt(0);

  Timer? _senderTime;

  MQTTClient? mqttClient;

  List<int> items = [0, 10, 20, 30, 40, 50];

  DevicePower({ Dispositivo? dispositive }) : super(dispositive: dispositive){
     loadCustomData();
  }

  @override
  void onClose() {
    if(dispositive == null || mqttClient == null){
      return;
    }
    print("Desconectando MQTT..");
    mqttClient?.disconnect();
  }
  
  @override
  void onConnect(){
    if(dispositive == null || mqttClient == null){
      return;
    }
   mqttClient = MQTTClient(dispositive!, (data) {
          print(data.message!["status"]);
          powerLevel.value = double.parse(data.message!["status"]);
      });
     mqttClient?.connect();
  }

  void sendMQTTMessage()  {
    if(dispositive == null || mqttClient == null){
      return;
    }
    if(_senderTime?.isActive ?? false) _senderTime?.cancel();
    _senderTime= Timer(Duration(seconds: 1),() {
        var message = MessagePayload(message: {"power":powerLevel.value}, event: 0);
        mqttClient?.sendMessage(message);
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
            divisions: stepLevel.value != 0 ? stepLevel.value : null,
            min: 0.0,
            max: 100.0,
            value: powerLevel.value,
            onChanged: (value) {
              powerLevel.value = value;
              sendMQTTMessage();
            },
          ),
           Column(
             children: [
               Text("Potência: ${powerLevel.value.toInt()}",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              Text("Steps selecionado \n${stepLevel.value != 0 ? stepLevel.value : "Sem STEP"}", style: const TextStyle(fontSize: 20.0))
             ]),
            ],
            ),
            ),
        ],
      ),
    );
  }

  @override
  Widget getCustomOption() {
        return Obx(()=> Column(
            children:[ 
              DropdownButton<int>(
                 items : items.map((int dropDownItem) {
                  return DropdownMenuItem<int>(
                       value : dropDownItem,
                       child : Text(dropDownItem.toString()),
                ); 
               }).toList(),
               value: stepLevel.value,
               onChanged: (int? novoItemSelecionado) {
                  stepLevel.value = novoItemSelecionado;                          
              },
          ), 
              Text("Passos: ${stepLevel.value != 0 ? stepLevel.value : "Sem STEP"} ", style: TextStyle(fontSize: 20.0))           
          ]
        ),
        );
            
    }
    
      @override
      void loadCustomData() {
          final element = dispositive?.customData?.firstWhereOrNull((element) => element.key.contains("key1"));
          if(element == null) return;
          if(items.contains(element.value)){
            stepLevel.value = element.value;
            return;
          }
          stepLevel.value = 0;
      }
    
    @override
    List<CustomData> createCustomData() {
      List<CustomData> customData = [];
      if(stepLevel.value == 0){
        return customData;
      }
      customData.add(CustomData(key: "key1",value: stepLevel.value));
      return customData;
    }
}