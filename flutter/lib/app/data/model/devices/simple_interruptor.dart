


import 'package:application/app/data/enum/device_type.dart';
import 'package:application/app/data/enum/device_type_extension.dart';
import 'package:application/app/data/model/item_abstract.dart';
import 'package:application/app/data/model/mqtt_connection.dart';
import 'package:flutter/material.dart';

class SimpleInterruptor extends ItemAbstract
{
  @override
  String message = "";

  @override
  String topic = "";

  @override
  String itemTitle = "Interruptor Simples";

  @override
  DeviceType itemType = DeviceType.simpleToggle;

  SimpleInterruptor(topic) : super(topic);


  @override
  void executeMQTT(String topic, MQTTConnection connection) {
    String message = "{\"${itemType.displayTitle}\":\"on\"}";
    
  }

  @override
  Widget getView() {
    // TODO: implement getView
    return const Text("teste");
  }


 


  
 
}