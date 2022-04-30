
import 'package:application/app/data/model/dispositive_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
abstract class ItemAbstract extends GetxController
{
  final Dispositive dispositive;

  ItemAbstract({required this.dispositive});

  Widget getView();

  Widget getCustomOption();

  void executeMQTT();
}
