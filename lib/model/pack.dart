// To parse this JSON data, do
//
//     final egaoDatabasePack = egaoDatabasePackFromJson(jsonString);

import 'dart:convert';

List<EgaoDatabasePack> egaoDatabasePackFromJson(String str) =>
    List<EgaoDatabasePack>.from(
        json.decode(str).map((x) => EgaoDatabasePack.fromJson(x)));

String egaoDatabasePackToJson(List<EgaoDatabasePack> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EgaoDatabasePack {
  EgaoDatabasePack({
    required this.id,
    required this.name,
    required this.logo,
  });

  String id;
  String name;
  String logo;

  factory EgaoDatabasePack.fromJson(Map<String, dynamic> json) =>
      EgaoDatabasePack(
        id: json["id"],
        name: json["name"],
        logo: json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo": logo,
      };
}
