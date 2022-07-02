import 'package:application/app/core/infra/provider/mqtt_provider.dart';
import 'package:application/app/mqtt/item_abstract.dart';
import 'package:application/app/mqtt/mqtt_payload.dart';

class MQTTRepository {
  final MQTTClient mqttClient;

  MQTTRepository({required this.mqttClient});

  sendMessage(MessagePayload message, TipoDispositivoAbstract item) {
    return mqttClient.sendMessage(message);
  }
}