import 'dart:convert';
import 'package:application/app/data/model/item_abstract.dart';
import 'package:application/app/data/model/mqtt_connection.dart';
//mudar nome dessa classe
List<Dispositive> dispositivoFromJson(String str) =>
    List<Dispositive>.from(json.decode(str).map((x) => Dispositive.fromJson(x)));

String dispositivoToJson(List<Dispositive> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Dispositive {

  int? id;
  String nome;
  int? tipoId;
  String descricao;
  int? roomId;
  bool? isFavorite;
  MQTTConnection mqttConfig;
  ItemAbstract? itemAbstract;

  Dispositive({
    this.id,
    this.roomId,
    this.itemAbstract,
    this.isFavorite,
    required this.tipoId,
    required this.nome,
    required this.descricao,
    required this.mqttConfig
  });

  factory Dispositive.fromJson(Map<String, dynamic> json) => Dispositive(
        id: json["id"],
        nome: json["nome"],
        descricao: json["descricao"],
        roomId: json["roomId"] ?? -1,
        isFavorite: json["is_favorite"] as int == 1 ? true : false,
        tipoId: json["tipo_id"] ?? 0,
        mqttConfig: MQTTConnection(
        mQTTHost: json["mqtt_host"],
        mQTTPASSWORD: json["mqtt_password"],
        mqTTtopic: json["mqtt_topic"], 
        mQTTID: json["mqtt_id"], 
        mQTTPORT: json["mqtt_port"],
        mQTTUSER: json["mqtt_user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "descricao": descricao,
        "is_favorite": isFavorite as int == 1 ? true : false,
        "tipo_id": tipoId,
        "roomId": roomId,
        "mqttConfig": mqttConfig.toJson(),
      };

  Dispositive copy({
    int? id,
    String? nome,
    bool? isFavorite,
    int? tipoId,
    String? descricao,
    int? roomId,
    MQTTConnection? mqttConfig
  }) =>
      Dispositive(
        id: id ?? this.id,
        nome: nome ?? this.nome,
        isFavorite: isFavorite ?? this.isFavorite,
        tipoId: tipoId ?? this.tipoId,
        descricao: descricao ?? this.descricao,
        roomId: roomId ?? this.roomId,
        mqttConfig: mqttConfig ?? this.mqttConfig,
      );
}