// To parse this JSON data, do
//
//     final infoResponseData = infoResponseDataFromJson(jsonString);

import 'dart:convert';

InfoResponseDto infoResponseDataFromJson(String str) =>
    InfoResponseDto.fromJson(json.decode(str));

String infoResponseDataToJson(InfoResponseDto data) =>
    json.encode(data.toJson());

class InfoResponseDto {
  InfoResponseDto({
    this.limit,
    this.currentPage,
    this.nextPage,
    this.prevPage,
    this.next,
    this.prev,
    this.totalPages,
    this.items,
  });

  int? limit;
  int? currentPage;
  dynamic nextPage;
  dynamic prevPage;
  bool? next;
  bool? prev;
  int? totalPages;
  int? items;

  factory InfoResponseDto.fromJson(Map<String, dynamic> json) =>
      InfoResponseDto(
        limit: json["limit"],
        currentPage: json["currentPage"],
        nextPage: json["nextPage"],
        prevPage: json["prevPage"],
        next: json["next"],
        prev: json["prev"],
        totalPages: json["totalPages"],
        items: json["items"],
      );

  Map<String, dynamic> toJson() => {
        "limit": limit,
        "currentPage": currentPage,
        "nextPage": nextPage,
        "prevPage": prevPage,
        "next": next,
        "prev": prev,
        "totalPages": totalPages,
        "items": items,
      };
}
