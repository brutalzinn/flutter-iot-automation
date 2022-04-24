
import 'package:application/app/data/enum/item_enum.dart';
import 'package:flutter/material.dart';
import 'mqtt_client_config.dart';

abstract class ItemAbstract
{

  abstract String message;

  abstract String topic;

  ItemAbstract(topic);

  abstract String itemTitle;

  abstract ItemType itemType;
  
  Widget getView();

  void executeMQTT(String topic, MQTTConnection connection);
}
