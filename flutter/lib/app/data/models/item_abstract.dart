import '../enums/item_enum.dart';
import 'mqtt_connection.dart';

abstract class ItemAbstract extends MQTTConnection{
  String itemTitle = "";
  ItemType? itemType;
  String payload = "";

   void executeMQTT();
}