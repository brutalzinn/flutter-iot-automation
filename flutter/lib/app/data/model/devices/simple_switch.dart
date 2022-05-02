


import 'package:application/app/data/model/database/dispositive_model.dart';
import 'package:application/app/data/model/item_abstract.dart';
import 'package:flutter/material.dart';

class SimpleSwitch extends ItemAbstract 
{
  SimpleSwitch({required Dispositive dispositive}) : super(dispositive: dispositive);

  @override
  void executeMQTT() {
    print("Executando mqtt");
  }

  @override
  Widget getView() {
    return const Text("Simple SWITCHHH");
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