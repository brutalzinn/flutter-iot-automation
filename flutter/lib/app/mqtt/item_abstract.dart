import 'package:application/app/model/custom_data.dart';
import 'package:application/app/model/database/dispositivo_model.dart';
import 'package:flutter/material.dart';
abstract class ItemAbstract
{
  final Dispositivo? dispositive;

  ItemAbstract({this.dispositive});

  Widget getView();

  Widget getCustomOption();

  List<CustomData> createCustomData();

  void loadCustomData();

  void onClose();

  void onConnect();
}
