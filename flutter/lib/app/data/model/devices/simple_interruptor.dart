


import 'package:application/app/data/model/dispositive_model.dart';
import 'package:application/app/data/model/item_abstract.dart';
import 'package:flutter/material.dart';

class SimpleInterruptor extends ItemAbstract 
{
  SimpleInterruptor({required Dispositive dispositive}) : super(dispositive: dispositive);

  @override
  void executeMQTT(dispositive) {
    print("Executando mqtt");
  }

  @override
  Widget getView() {
    return const Text("Testandoooo 1, 2, 3...");
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