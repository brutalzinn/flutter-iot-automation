import 'dart:convert';

import 'package:application/app/data/model/mqtt_client_config.dart';
//mudar nome dessa classe
List<Dispositive> dispositivoFromJson(String str) =>
    List<Dispositive>.from(json.decode(str).map((x) => Dispositive.fromJson(x)));

String dispositivoToJson(List<Dispositive> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Dispositive {
  Dispositive({
    this.id,
    required this.nome,
    required this.descricao,
    required this.mqttConfig
  });

  int? id;
  String nome;
  String descricao;
  MQTTConnection mqttConfig;

  factory Dispositive.fromJson(Map<String, dynamic> json) => Dispositive(
        id: json["id"],
        nome: json["nome"],
        descricao: json["descricao"], 
        mqttConfig: MQTTConnection.fromJson(json["mqttConfig"])
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "descricao": descricao,
        "mqttConfig": mqttConfig.toJson(),

      };

  Dispositive copy({
    int? id,
    String? nome,
    String? descricao,
    MQTTConnection? mqttConfig
  }) =>
      Dispositive(
        id: id ?? this.id,
        nome: nome ?? this.nome,
        descricao: descricao ?? this.descricao,
        mqttConfig: mqttConfig ?? this.mqttConfig,
      );
}