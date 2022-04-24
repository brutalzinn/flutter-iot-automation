import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MQTTConnection
{
  String mQTTHost;
  String mQTTPORT;
  String mQTTUSER;
  String mQTTPASSWORD;
  int mQTTID;
  MqttServerClient? client;

  MQTTConnection(this.mQTTHost, this.mQTTPORT, this.mQTTUSER,
  this.mQTTID, this.mQTTPASSWORD
  )

Future connect() async {
  client = MqttServerClient(mQTTHost, '');

  return client;
}
}