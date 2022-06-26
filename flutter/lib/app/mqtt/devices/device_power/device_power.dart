


import 'dart:async';
import 'package:application/app/core/infra/provider/mqtt_provider.dart';
import 'package:application/app/core/infra/repository/dispositivo_repository.dart';
import 'package:application/app/model/custom_data.dart';
import 'package:application/app/model/database/dispositivo_model.dart';
import 'package:application/app/mqtt/item_abstract.dart';
import 'package:application/app/mqtt/mqtt_connection.dart';
import 'package:application/app/mqtt/mqtt_payload.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';

class DevicePower extends ItemAbstract 
{

  RxDouble powerLevel = 0.0.obs;

  RxInt stepLevel = RxInt(1);

  Timer? _senderTime;

  late MQTTClient mqttClient;

  DevicePower({ Dispositivo? dispositive }) : super(dispositive: dispositive){
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
          print(data.message!["status"]);
          powerLevel.value = double.parse(data.message!["status"]);
      });
     mqttClient.connect();
  }


  void sendMQTTMessage()  {
    if(dispositive == null){
      return;
    }
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
            divisions: stepLevel.value,
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
        return Obx(()=> Column(
            children:[ 
              DropdownButton<String>(
                 items : ["1", "5", "10", "15", "20"].map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                       value : dropDownStringItem,
                       child : Text(dropDownStringItem),
                ); 
               }).toList(),
               value: stepLevel.value.toString(),
               onChanged: (String? novoItemSelecionado) {
                    stepLevel.value = int.parse(novoItemSelecionado ?? "0");                    
              },
          ), 
              Text("Step selecionado \n${stepLevel.value}", style: TextStyle(fontSize: 20.0))           
          ]
        ),
        );
            
    }
    
      @override
      void loadCustomData(List<CustomData>? customData) {
        if(customData?.length == 0 ){
            return;
        }
         
          final element = customData?.firstWhereOrNull((element) => element.key.contains("key1"));
          stepLevel.value = element?.value ?? 1;
      }
    
      @override
      List<CustomData> saveCustomData() {

        List<CustomData> teste = [];
        teste.add(CustomData(key: "key1",value: stepLevel.value));
        return teste;
       //  final deviceId = dispositive?.id as int;
       // repository?.executeQuery("UPDATE dispositivo SET custom_data = ? WHERE id = ?", [customDataListToJson(teste) , deviceId]);
      }

 

 


  
 
}