import 'package:application/app/data/enum/device_type.dart';
extension DeviceTypeExtension on DeviceType{
 String get displayTitle
 {
   switch(this){

     case DeviceType.simpleRgb:
      return "simple rgb";
     case DeviceType.simpleToggle:
      return "simple Toggle (padrão)";
   }
 }

}