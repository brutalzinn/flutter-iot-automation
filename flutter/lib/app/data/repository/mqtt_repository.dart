import 'package:application/app/data/model/item_abstract.dart';
import 'package:application/app/data/provider/mqtt_provider.dart';

class MQTTRepository {
  final MQTTClient mqttClient;

  MQTTRepository({required this.mqttClient});

  sendMessage(String message, ItemAbstract item) {
    return mqttClient.sendMessage(message, item.dispositive.mqttConfig.mqTTtopic);
  }
}