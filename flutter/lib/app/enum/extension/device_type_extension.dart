import 'package:application/app/enum/device_type.dart';

extension DeviceTypeExtension on DeviceType{
 String get displayTitle
 {
   switch(this){

     case DeviceType.deviceRGB:
      return "Device RGB";
     case DeviceType.deviceToggle:
      return "Device Toggle";
     case DeviceType.devicePower:
      return "Device Power";
   }
 }

}