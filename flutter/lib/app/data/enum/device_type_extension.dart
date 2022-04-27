import 'package:application/app/data/enum/device_type.dart';

extension ItemEnumExtension on DeviceType{
 String get displayTitle
 {
   switch(this){
     case DeviceType.fanControl:
      return "fan";
     case DeviceType.powerControl:
      return "power";
     case DeviceType.simpleSwitch:
      return "simpleSwitch";
     case DeviceType.simpleToggle:
      return "simpleToggle";
   }
 }

  int get displayId
 {
   return index;
 }
}