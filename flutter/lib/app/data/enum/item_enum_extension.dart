import 'package:application/app/data/enum/item_enum.dart';

extension ItemEnumExtension on ItemType{
 String get displayTitle
 {
   switch(this){
     case ItemType.fanControl:
      return "fan";
     case ItemType.powerControl:
      return "power";
     case ItemType.simpleSwitch:
      return "simpleSwitch";
     case ItemType.simpleToggle:
      return "simpleToggle";
   }
 }
}