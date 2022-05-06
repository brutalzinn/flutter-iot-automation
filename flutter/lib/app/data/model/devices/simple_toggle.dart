


import 'package:application/app/data/model/database/dispositive_model.dart';
import 'package:application/app/data/model/item_abstract.dart';
import 'package:application/app/data/model/mqtt_payload.dart';
import 'package:application/app/data/provider/mqtt_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SimpleToggle extends ItemAbstract 
{

  Rx<String>? messagePayload = Rx<String>("");
  RxBool toggleButton = false.obs;

  late MQTTClient mqttClient;

  SimpleToggle({ required Dispositive dispositive }) : super(dispositive: dispositive){
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
  //TODO: colocar em um part of pois são
  // utilidades especificas do MQTT
  // regra de negócio entre Aplicativo, HomeAssistant e dispositivos IOT
  //TODO: renomear classe e nome de métodos. Esses nomes não estão batendo
  //TODO: Traduzir tudo para inglês e criar um arquivo de testes para o GetX

  String mqttTranslator(bool status){
     return status ? "on" : "off";
  }

  void sendMQTTMessage()  {
    toggleButton.value = !toggleButton.value;
    var message = MessagePayload(message: {"status":mqttTranslator(toggleButton.value)}, event: 0);
    mqttClient.sendMessage(message);
  }
  
  
  @override
  Widget getView() {
    return Center(
      child: Column(
        children: [
            const Text("SIMPLE TOGGLE TEST",
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
            child: Obx(() => Text(mqttTranslator(toggleButton.value))),
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