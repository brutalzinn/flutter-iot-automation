import 'dart:convert';
import 'package:application/app/model/custom_data.dart';
import 'package:application/app/mqtt/item_abstract.dart';
import 'package:application/app/mqtt/mqtt_connection.dart';

//mudar nome dessa classe
List<Dispositivo> dispositivoFromJson(String str) =>
    List<Dispositivo>.from(json.decode(str).map((x) => Dispositivo.fromJson(x)));


String dispositivoToJson(List<Dispositivo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Dispositivo {

  int? id;
  String? nome;
  int? tipoId;
  String? descricao;
  int? roomId;
  bool? isFavorite;
  MQTTConnection? mqttConfig;
  List<CustomData>? customData;
  ItemAbstract? itemAbstract;

  Dispositivo( 
  {   
  this.id,
    this.roomId,
    this.itemAbstract,
    this.isFavorite,
    this.customData,
    this.tipoId,
    this.nome,
    this.descricao,
    this.mqttConfig
    }
    
  );

  factory Dispositivo.fromJson(Map<String, dynamic> json) => Dispositivo(
        id: json["id"],
        nome: json["nome"],
        descricao: json["descricao"],
        roomId: json["room_id"] ?? -1,
        isFavorite: json["is_favorite"] as int == 1 ? true : false,
        tipoId: json["tipo_id"] ?? 0,
        mqttConfig:  mqttFromJson(json["mqtt_config"]),
        customData: customDataFromJson(json["custom_data"]),

      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "descricao": descricao,
        "is_favorite": isFavorite as int == 1 ? true : false,
        "tipo_id": tipoId,
        "room_id": roomId,
        "mqtt_config": mqttToJson(mqttConfig),
        "custom_data": customDataListToJson(customData!)
      };

  Dispositivo copy({
    int? id,
    String? nome,
    bool? isFavorite,
    int? tipoId,
    String? descricao,
    int? roomId,
    List<CustomData>? customData,
    MQTTConnection? mqttConfig
  }) =>
      Dispositivo(
        id: id ?? this.id,
        nome: nome ?? this.nome,
        isFavorite: isFavorite ?? this.isFavorite,
        tipoId: tipoId ?? this.tipoId,
        descricao: descricao ?? this.descricao,
        roomId: roomId ?? this.roomId,
        customData: customData ?? this.customData,
        mqttConfig: mqttConfig ?? this.mqttConfig,
      );
}