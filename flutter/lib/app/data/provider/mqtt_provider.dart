
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:application/app/data/model/dispositive_model.dart';
import 'package:application/app/data/model/mqtt_payload.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MQTTClient 
{

final Dispositive dispositive;
final dynamic onMessage;

MQTTClient(this.dispositive, this.onMessage);

 MqttClientPayloadBuilder createPayload(MessagePayload mqttPayload){
  final builder = MqttClientPayloadBuilder();
  builder.addString(messagePayloadToJson(mqttPayload));
  return builder;
 }

Future<bool> sendMessage(MessagePayload message) async {
  
  MqttServerClient client = MqttServerClient(dispositive.mqttConfig.mQTTHost, '');
  client.port = dispositive.mqttConfig.mQTTPORT;
  client.setProtocolV31();

  // client.onDisconnected = dispositive.mqttConfig.onEvent;
  // client.onConnected = dispositive.mqttConfig.onEvent;
  // client.onSubscribed = dispositive.mqttConfig.onEvent;
 
  final connMess = MqttConnectMessage()
      .withClientIdentifier(dispositive.mqttConfig.mQTTID)
      .startClean()
      .withWillQos(MqttQos.atMostOnce);

  print('EXAMPLE::Mosquitto client connecting....');
  client.connectionMessage = connMess;
    try {
    await client.connect(dispositive.mqttConfig.mQTTUSER, dispositive.mqttConfig.mQTTPASSWORD);
    
    client.publishMessage(dispositive.mqttConfig.mqTTtopic, MqttQos.exactlyOnce, createPayload(message).payload!);

    client.subscribe(dispositive.mqttConfig.mqTTtopic, MqttQos.exactlyOnce);
    client.updates?.listen(_onMessage);
    print("Conectado ao broker");
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

void _onMessage(List<MqttReceivedMessage> event) {
 final MqttPublishMessage recMess =
 event[0].payload as MqttPublishMessage;
 final String message =
 MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
 onMessage(message);
}
  //method to handle homeassistant message here
}