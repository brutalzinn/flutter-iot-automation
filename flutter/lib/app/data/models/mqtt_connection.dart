// ignore_for_file: avoid_print

import 'dart:io';

import 'package:mqtt_client/mqtt_client.dart';

class MQTTConnection
{
  String? mQTTHost;
  int? mQTTPORT;
  String? mQTTUSER;
  String? mQTTPASSWORD;
  String? mQTTID;
  dynamic onEvent; //deveria ser um function()?
  late MqttClient client;


  MQTTConnection({this.mQTTHost, this.mQTTPORT, this.mQTTUSER, this.mQTTID, this.mQTTPASSWORD, this.onEvent});

  void connect() async {
  client = MqttClient(mQTTHost ?? "", mQTTID ?? "");
  client.port = mQTTPORT;

  client.onDisconnected = onEvent;
  client.onConnected = onEvent;
  client.onSubscribed = onEvent;

  final connMess = MqttConnectMessage()
      .withClientIdentifier('Mqtt_MyClientUniqueId')
      .withWillTopic('willtopic') // If you set this you must set a will message
      .withWillMessage('My Will message')
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
  



}

}