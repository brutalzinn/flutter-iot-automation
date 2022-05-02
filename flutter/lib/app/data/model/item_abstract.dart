
import 'package:application/app/data/model/database/dispositive_model.dart';
import 'package:flutter/material.dart';
abstract class ItemAbstract
{
  final Dispositive dispositive;

  ItemAbstract({required this.dispositive});

  Widget getView();

  Widget getCustomOption();

  void executeMQTT();
}
