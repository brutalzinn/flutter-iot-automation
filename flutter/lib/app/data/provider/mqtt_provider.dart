// ignore_for_file: avoid_print

import 'dart:io';
import 'package:mqtt_client/mqtt_client.dart';
import '../model/mqtt_connection.dart';

class MQTTClient 
{

final MQTTConnection config;

MQTTClient({required this.config});

Future<bool> sendMessage(String message, String topic) async {
  
  MqttClient client = MqttClient(config.mQTTHost, config.mQTTID );
  client.port = config.mQTTPORT;

  // client.onDisconnected = config.onEvent;
  // client.onConnected = config.onEvent;
  // client.onSubscribed = config.onEvent;
 
  final connMess = MqttConnectMessage()
      .withClientIdentifier(config.mQTTID)
      .withWillTopic(topic) // If you set this you must set a will message
      .withWillMessage(message)
      .startClean() // Non persistent session for testing
      .withWillQos(MqttQos.atLeastOnce);

  print('EXAMPLE::Mosquitto client connecting....');
  client.connectionMessage = connMess;
    try {
    await client.connect();
  } on NoConnectionException catch (e) {
    // Raised by the client when connection fails.
    print('EXAMPLE::client exception - $e');
    client.disconnect();
  } on SocketException catch (e) {
    // Raised by the socket layer
    print('EXAMPLE::socket exception - $e');
    client.disconnect();
  }
  if (client.connectionStatus!.state == MqttConnectionState.connected) {
    print('EXAMPLE::Mosquitto client connected');
  } else {
    /// Use status here rather than state if you also want the broker return code.
    print(
        'EXAMPLE::ERROR Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
    client.disconnect();
    exit(-1);
  }

  return false;
}


  //method to handle homeassistant message here
}