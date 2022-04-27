
import 'package:application/app/data/enum/device_type.dart';
import 'package:flutter/material.dart';
import 'mqtt_connection.dart';

abstract class ItemAbstract
{

  abstract String message;

  abstract String topic;

  ItemAbstract(topic);

  abstract String itemTitle;

  abstract DeviceType itemType;
  
  Widget getView();

  void executeMQTT(String topic, MQTTConnection connection);
}
