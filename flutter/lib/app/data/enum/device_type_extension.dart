import 'package:application/app/data/enum/device_type.dart';
extension DeviceTypeExtension on DeviceType{
 String get displayTitle
 {
   switch(this){
     case DeviceType.powerControl:
      return "power";
     case DeviceType.simpleSwitch:
      return "simple Switch";
     case DeviceType.simpleToggle:
      return "simple Toggle (padrão)";
   }
 }

}