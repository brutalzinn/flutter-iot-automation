import 'dart:convert';
//mudar nome dessa classe
List<Ambiente> ambienteFromJson(String str) =>
    List<Ambiente>.from(json.decode(str).map((x) => Ambiente.fromJson(x)));

String ambienteToJson(List<Ambiente> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ambiente {
  Ambiente({
    this.id,
    required this.nome,
    required this.descricao,
  });

  int? id;
  String nome;
  String descricao;

  factory Ambiente.fromJson(Map<String, dynamic> json) => Ambiente(
        id: json["id"],
        nome: json["nome"],
        descricao: json["descricao"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "descricao": descricao,
      };

  Ambiente copy({
    int? id,
    String? nome,
    String? descricao,
  }) =>
      Ambiente(
        id: id ?? this.id,
        nome: nome ?? this.nome,
        descricao: descricao ?? this.descricao,
      );
}