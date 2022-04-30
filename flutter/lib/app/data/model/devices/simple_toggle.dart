


import 'package:application/app/data/model/dispositive_model.dart';
import 'package:application/app/data/model/item_abstract.dart';
import 'package:application/app/data/model/mqtt_payload.dart';
import 'package:application/app/data/provider/mqtt_provider.dart';
import 'package:flutter/material.dart';

class SimpleToggle extends ItemAbstract 
{
  SimpleToggle({required Dispositive dispositive}) : super(dispositive: dispositive);

  @override
  void executeMQTT() {
    final mqtt =  MQTTClient(dispositive, (message) {
      print("recebido $message");
    });
    final message = MessagePayload(message: {"teste":true});

    mqtt.sendMessage(message);
  }

  @override
  Widget getView() {
    return Center(
      child: Column(
        children: [
           const Text("SIMPLE TOGGLE"),
           const Text("Simple toggle"),
            TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            onPressed: () {
              executeMQTT();
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