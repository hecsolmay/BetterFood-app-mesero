
import 'package:app_waiter/dtos/order_response.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import '../globals/globals.dart';

class OrderProvider extends ChangeNotifier {
  final logger = Logger();

  List<OrderResponseDto>? _orden;
  List<OrderResponseDto>? get orden => _orden;

  Future<void> getDetailsOrders(String id) async {
  try {
    final url = "${Globals.apiURL}/api/waiter/$id/sales";
    final response = await http.get(Uri.parse(url));
    logger.d(response.body);
 
    if (response.statusCode == 200) {
       final json = jsonDecode(response.body);
        final List<dynamic> results = json["results"];
       _orden = results.map((e) => OrderResponseDto.fromMap(e)).toList();
      notifyListeners();
      
    } else {
      throw Exception('Failed to load orders');
    }
  } catch (e) { 
    logger.d(e);
  }
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