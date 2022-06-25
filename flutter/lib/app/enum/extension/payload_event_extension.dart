
import 'package:application/app/enum/payload_event.dart';

extension MessagePayloadExtension on MessagePayloadEventEnum{
 String get displayTitle
 {
   switch(this){
     case MessagePayloadEventEnum.request:
      return "request";
     case MessagePayloadEventEnum.response:
      return "response";
   }
 }

}