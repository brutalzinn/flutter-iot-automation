


import 'package:application/app/data/model/database/dispositive_model.dart';
import 'package:application/app/data/model/item_abstract.dart';
import 'package:flutter/material.dart';

class Power extends ItemAbstract 
{
  Power({required Dispositive dispositive}) : super(dispositive: dispositive);

  @override
  void onConnectMQTT() {
    print("Executando mqtt");
  }

  @override
  Widget getView() {
    return const Text("Controle de potências");
  }

  @override
  void onClose() {
    // TODO: implement onClose
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