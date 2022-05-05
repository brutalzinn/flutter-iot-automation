
import 'dart:convert';

  MQTTConnection mqttFromJson(String str) => MQTTConnection.fromJson(json.decode(str));

  String mqttToJson(MQTTConnection data) => json.encode(data.toJson());

class MQTTConnection
{

  String mqttToJson() => json.encode(this.toJson());


  String mQTTHost;
  int mQTTPORT;
  String mQTTUSER;
  String mQTTPASSWORD;
  String mQTTID;
  String mqTTtopic;

  MQTTConnection({required this.mQTTHost, required this.mQTTPORT, required this.mQTTUSER, required this.mQTTID, required this.mQTTPASSWORD, required this.mqTTtopic});
  
  factory MQTTConnection.fromJson(Map<String, dynamic> json) => MQTTConnection(
      mQTTHost: json["mqtt_host"],
      mQTTPORT: json["mqtt_port"],
      mQTTUSER: json["mqtt_user"],
      mQTTPASSWORD: json["mqtt_password"],
      mQTTID: json["mqtt_id"],
      mqTTtopic: json["mqtt_topic"]

  );

  Map<String, dynamic> toJson() => {
        "mqtt_host": mQTTHost,
        "mqtt_port": mQTTPORT,
        "mqtt_user": mQTTUSER,
        "mqtt_password": mQTTPASSWORD,
        "mqtt_id": mQTTID,
        "mqtt_topic": mqTTtopic,
      };

}