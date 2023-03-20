import 'package:app_waiter/dtos/order_response.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import '../globals/globals.dart';

class OrderProvider extends ChangeNotifier {
  final logger = Logger();

  bool isLoading = true;
  bool hasError = false;

  List<OrderResponseDto> _orders = [];
  List<OrderResponseDto> get orders => _orders;

  Future<void> getDetailsOrders(String id) async {
    try {
      isLoading = true;
      hasError = false;
      notifyListeners();
      final url = "${Globals.apiURL}/api/waiter/$id/sales";
      final response = await http.get(Uri.parse(url));
      logger.d(response.body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final List<dynamic> results = json["results"];
        _orders = results.map((e) => OrderResponseDto.fromJson(e)).toList();
        notifyListeners();
      } else {
        hasError = true;
        logger.e('There is an error');
      }
    } catch (e) {
      hasError = true;
      logger.d(e);
    }

    isLoading = false;
    logger.d("Termino");
    notifyListeners();
  }
}

 // Future<void> getListOrder(String id) async {
  //   try {
  //     final url = "${Globals.apiURL}/api/waiter/$id/sales";
  //     final response = await http.get(Uri.parse(url));
  //     logger.d(response.body);
  //     print(response);

  //     if (response.statusCode == 200) {
  //       final json = jsonDecode(response.body);
  //       final List<dynamic> results = json["order"];
  //       _orden = results.map((e) => Order.fromMap(e)).toList();
  //       notifyListeners();
  //     } else {
  //       throw Exception('Failed to load orders');
  //     }
  //   } catch (e) {
  //     logger.d(e);
  //   }
  // }