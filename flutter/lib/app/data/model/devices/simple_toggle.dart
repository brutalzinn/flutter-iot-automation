


import 'package:application/app/data/model/database/dispositive_model.dart';
import 'package:application/app/data/model/item_abstract.dart';
import 'package:application/app/data/model/mqtt_payload.dart';
import 'package:application/app/data/provider/mqtt_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SimpleToggle extends ItemAbstract 
{

  Rx<String>? messagePayload = Rx<String>("");

  late MQTTClient mqttClient;

  SimpleToggle({ required Dispositive dispositive }) : super(dispositive: dispositive){
    executeMQTT();
   
  }
  @override
  void executeMQTT(){
   mqttClient = MQTTClient(dispositive, (data) {
          messagePayload!.value = data.message!["status"] ? 'Ativo' : 'Inativo';
      });
     mqttClient.connect();

  }

  void sendMQTTMessage()  {
    var message = MessagePayload(message: {"status":"on"}, event: 0);
    mqttClient.sendMessage(message);
  }
  
  
  @override
  Widget getView() {
    return Center(
      child: Column(
        children: [
            const Text("SIMPLE TOGGLE",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
           ),
            Obx(() =>
            Text("Status: ${messagePayload ?? "Desconectado"}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
           )),
            TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            onPressed: () {
             sendMQTTMessage();
            },
            child: const Text('TextButton'),
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