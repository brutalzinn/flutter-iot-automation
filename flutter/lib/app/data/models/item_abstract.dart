import '../enums/item_enum.dart';
import 'mqtt_connection.dart';

abstract class ItemAbstract extends MQTTConnection{
   abstract String itemTitle;
   abstract ItemType itemType;
   abstract String payload;
  
   abstract Function onMessage;
   abstract Function onError;

   void executeMQTT();
}