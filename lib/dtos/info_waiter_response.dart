// To parse this JSON data, do
//
//     final waiterinfoResponseDto = waiterinfoResponseDtoFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

WaiterinfoResponseDto waiterinfoResponseDtoFromJson(String str) => WaiterinfoResponseDto.fromJson(json.decode(str));

String waiterinfoResponseDtoToJson(WaiterinfoResponseDto data) => json.encode(data.toJson());

class WaiterinfoResponseDto {
    WaiterinfoResponseDto({
        required this.name,
        required this.lastName,
        required this.birthdate,
        required this.active,
        required this.createdAt,
        required this.updatedAt,
        required this.age,
        required this.id,
    });

    final String name;
    final String lastName;
    final DateTime birthdate;
    final int active;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int age;
    final String id;

    factory WaiterinfoResponseDto.fromJson(Map<String, dynamic> json) => WaiterinfoResponseDto(
        name: json["name"],
        lastName: json["lastName"],
        birthdate: DateTime.parse(json["birthdate"]),
        active: json["active"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        age: json["age"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "lastName": lastName,
        "birthdate": birthdate.toIso8601String(),
        "active": active,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "age": age,
        "id": id,
    };
}
