
import 'package:application/app/model/database/dispositivo_model.dart';
import 'package:flutter/material.dart';
abstract class ItemAbstract
{
  final Dispositivo dispositive;

  ItemAbstract({required this.dispositive});


  Widget getView();

  Widget getCustomOption();

  void onClose();

  void onConnectMQTT();
}
