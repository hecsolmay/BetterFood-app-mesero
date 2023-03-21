// To parse this JSON data, do
//
//     final notificationResonse = notificationResonseFromJson(jsonString);

import 'dart:convert';

NotificationResonse notificationResonseFromJson(String str) =>
    NotificationResonse.fromJson(json.decode(str));

String notificationResonseToJson(NotificationResonse data) =>
    json.encode(data.toJson());

class NotificationResonse {
  NotificationResonse({
    this.table,
    this.waiter,
    this.title,
    this.text,
    this.type,
    this.createdAt,
    this.id,
    this.sale,
  });

  String? table;
  String? waiter;
  String? title;
  String? text;
  String? type;
  DateTime? createdAt;
  String? id;
  String? sale;

  factory NotificationResonse.fromJson(Map<String, dynamic> json) =>
      NotificationResonse(
        table: json["table"],
        waiter: json["waiter"],
        title: json["title"],
        text: json["text"],
        type: json["type"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        id: json["id"],
        sale: json["sale"],
      );

  Map<String, dynamic> toJson() => {
        "table": table,
        "waiter": waiter,
        "title": title,
        "text": text,
        "type": type,
        "createdAt": createdAt?.toIso8601String(),
        "id": id,
        "sale": sale,
      };
}
