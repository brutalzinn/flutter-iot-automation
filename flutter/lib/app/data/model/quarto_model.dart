import 'dart:convert';
//mudar nome dessa classe
List<Bedroom> bedroomFromJson(String str) =>
    List<Bedroom>.from(json.decode(str).map((x) => Bedroom.fromJson(x)));

String bedroomToJson(List<Bedroom> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Bedroom {
  Bedroom({
    this.id,
    required this.nome,
    required this.descricao,
  });

  int? id;
  String nome;
  String descricao;

  factory Bedroom.fromJson(Map<String, dynamic> json) => Bedroom(
        id: json["id"],
        nome: json["nome"],
        descricao: json["descricao"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "descricao": descricao,
      };

  Bedroom copy({
    int? id,
    String? nome,
    String? descricao,
  }) =>
      Bedroom(
        id: id ?? this.id,
        nome: nome ?? this.nome,
        descricao: descricao ?? this.descricao,
      );
}