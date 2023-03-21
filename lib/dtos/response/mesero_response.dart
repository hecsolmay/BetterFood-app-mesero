// To parse this JSON data, do
//
//     final waiterResponseDto = waiterResponseDtoFromJson(jsonString);

import 'dart:convert';

WaiterResponseDto waiterResponseDtoFromJson(String str) =>
    WaiterResponseDto.fromJson(json.decode(str));

String waiterResponseDtoToJson(WaiterResponseDto data) =>
    json.encode(data.toJson());

class WaiterResponseDto {
  WaiterResponseDto({
    required this.name,
    required this.lastName,
    required this.birthdate,
    required this.createdAt,
    required this.age,
    required this.id,
  });

  String name;
  String lastName;
  DateTime birthdate;
  DateTime createdAt;
  int age;
  String id;

  factory WaiterResponseDto.fromJson(Map<String, dynamic> json) =>
      WaiterResponseDto(
        name: json["name"],
        lastName: json["lastName"],
        birthdate: DateTime.parse(json["birthdate"]),
        createdAt: DateTime.parse(json["createdAt"]),
        age: json["age"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "lastName": lastName,
        "birthdate": birthdate.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "age": age,
        "id": id,
      };
}
