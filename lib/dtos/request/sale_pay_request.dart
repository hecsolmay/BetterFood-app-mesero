// To parse this JSON data, do
//
//     final salePay = salePayFromJson(jsonString);

import 'dart:convert';

SalePay salePayFromJson(String str) => SalePay.fromJson(json.decode(str));

String salePayToJson(SalePay data) => json.encode(data.toJson());

class SalePay {
  SalePay({
    required this.moneyReceived,
  });

  double moneyReceived;

  factory SalePay.fromJson(Map<String, dynamic> json) => SalePay(
        moneyReceived: json["moneyReceived"],
      );

  Map<String, dynamic> toJson() => {
        "moneyReceived": moneyReceived,
      };
}
