// To parse this JSON data, do
//
//     final egaoDatabaseDetail = egaoDatabaseDetailFromJson(jsonString);

import 'dart:convert';

EgaoDatabaseDetail egaoDatabaseDetailFromJson(String str) =>
    EgaoDatabaseDetail.fromJson(json.decode(str));

String egaoDatabaseDetailToJson(EgaoDatabaseDetail data) =>
    json.encode(data.toJson());

class EgaoDatabaseDetail {
  EgaoDatabaseDetail({
    required this.id,
    required this.logo,
    required this.name,
    required this.desc,
    required this.data,
  });

  String id;
  String logo;
  String name;
  String desc;
  List<Datum> data;

  factory EgaoDatabaseDetail.fromJson(Map<String, dynamic> json) =>
      EgaoDatabaseDetail(
        id: json["id"],
        logo: json["logo"],
        name: json["name"],
        desc: json["desc"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "logo": logo,
        "name": name,
        "desc": desc,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.title,
    required this.sound,
  });

  String title;
  String sound;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["title"],
        sound: json["sound"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "sound": sound,
      };
}
