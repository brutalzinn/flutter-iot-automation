
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:application/app/data/model/database/dispositive_model.dart';
import 'package:application/app/data/model/mqtt_payload.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

//melhorar isso depois. Por agora vamos estudar testes.
class MQTTClient 
{
  late MqttServerClient client;
  final Dispositive dispositive;
  final Function(MessagePayload) onMessage;

  MQTTClient(this.dispositive, this.onMessage);

 MqttClientPayloadBuilder createPayload(MessagePayload mqttPayload){
  final builder = MqttClientPayloadBuilder();
  builder.addString(messagePayloadToJson(mqttPayload));
  return builder;
 }

Future<bool> connect() async
{

  client = MqttServerClient(dispositive.mqttConfig.mQTTHost, '');
  client.port = dispositive.mqttConfig.mQTTPORT;
  client.setProtocolV311();

  final connMess = MqttConnectMessage()
      .withClientIdentifier(dispositive.mqttConfig.mQTTID)
      .startClean()
      .withWillQos(MqttQos.atMostOnce);

  client.connectionMessage = connMess;

  print('EXAMPLE::Mosquitto client connecting....');

    try {
    await client.connect(dispositive.mqttConfig.mQTTUSER, dispositive.mqttConfig.mQTTPASSWORD);

    client.subscribe(dispositive.mqttConfig.mqTTtopic, MqttQos.exactlyOnce);
    client.updates?.listen(_onMessage);

    print("Conectado ao broker");
  } on NoConnectionException catch (e) {
    // Raised by the client when connection fails.
    print('EXAMPLE::client exception - $e');
 //   client.disconnect();
  } on SocketException catch (e) {
    // Raised by the socket layer
    print('EXAMPLE::socket exception - $e');
  //  client.disconnect();
  }
  if (client.connectionStatus!.state == MqttConnectionState.connected) {
    print('EXAMPLE::Mosquitto client connected');
  } else {
    /// Use status here rather than state if you also want the broker return code.
    print(
        'EXAMPLE::ERROR Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
    //client.disconnect();
   // exit(-1);
  }

  return false;

}

Future<bool> sendMessage(MessagePayload message) async {
  
  try{
    client.publishMessage(dispositive.mqttConfig.mqTTtopic, MqttQos.exactlyOnce, createPayload(message).payload!);
    return true;
  }
  catch(e){
    return false;
  }
}

Future<bool> disconnect() async {
  try{
    client.disconnect();
    return true;
  }
  catch(e){
    print('EXAMPLE::ERROR Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
   
    return false;
  }
}

void _onMessage(List<MqttReceivedMessage> event) {
 final MqttPublishMessage recMess =
 event[0].payload as MqttPublishMessage;
 final message = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
 final payload = messagePayloadFromJson(message);

 if(payload.event == 1){
   onMessage(payload);
 }
}
}