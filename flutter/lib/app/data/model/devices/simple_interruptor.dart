


import 'package:application/app/data/enum/item_enum.dart';
import 'package:application/app/data/enum/item_enum_extension.dart';
import 'package:application/app/data/model/item_abstract.dart';
import 'package:application/app/data/model/mqtt_client_config.dart';
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
  ItemType itemType = ItemType.simpleToggle;

  SimpleInterruptor(topic) : super(topic);


  @override
  void executeMQTT(String topic, MQTTConnection connection) {
    String message = "{\"${itemType.displayTitle}\":\"on\"}";
    
  }

  @override
  Widget getView() {
    // TODO: implement getView
    throw UnimplementedError();
  }


 


  
 
}