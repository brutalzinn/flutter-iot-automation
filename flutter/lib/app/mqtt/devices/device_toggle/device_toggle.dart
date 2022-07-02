
import 'package:application/app/core/infra/provider/mqtt_provider.dart';
import 'package:application/app/model/custom_data.dart';
import 'package:application/app/model/database/dispositivo_model.dart';
import 'package:application/app/mqtt/item_abstract.dart';
import 'package:application/app/mqtt/mqtt_payload.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeviceToggle extends TipoDispositivoAbstract 
{

  Rx<String>? messagePayload = Rx<String>("");
  RxBool toggleButton = false.obs;

  MQTTClient? mqttClient;

  DeviceToggle({ Dispositivo? dispositive}) : super(dispositive: dispositive);
  
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
          messagePayload!.value = data.message!["status"] ? 'Ativo' : 'Inativo';
      });
     mqttClient?.connect();
  }

  String mqttTranslator(bool status){
     return status ? "on" : "off";
  }

  void sendMQTTMessage()  {
    if(dispositive == null || mqttClient == null){
      return;
    }
    toggleButton.value = !toggleButton.value;
    var message = MessagePayload(message: {"status":mqttTranslator(toggleButton.value)}, event: 0);
    mqttClient?.sendMessage(message);
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

  @override
  void loadCustomData() {
     final element = dispositive?.customData?.firstWhereOrNull((element) => element.key.contains("key1"));
    //stepLevel?.value = element?.value ?? null;

  }

  @override
  List<CustomData> createCustomData() {
      List<CustomData> customData = [];
      customData.add(CustomData(key: "key1",value: 666));
      return customData;
  }

}