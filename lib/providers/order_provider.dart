import 'package:app_waiter/dtos/request/order_status_request.dart';
import 'package:app_waiter/dtos/request/sale_pay_request.dart';
import 'package:app_waiter/dtos/response/info_response.dart';
import 'package:app_waiter/dtos/response/order_response.dart';
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
  bool success = false;

  InfoResponseDto? _info;
  InfoResponseDto? _infoFiltered;

  InfoResponseDto? get info => _info;
  InfoResponseDto? get infoFiltered => _infoFiltered;
  List<OrderResponseDto> _orders = [];
  List<OrderResponseDto> _ordersFiltered = [];
  List<OrderResponseDto> get orders => _orders;
  List<OrderResponseDto> get ordersFiltered => _ordersFiltered;

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
        final dynamic paginate = json["info"];
        _info = InfoResponseDto.fromJson(paginate);
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

  void cleanOrdersStatus() {
    _ordersFiltered = [];
  }

  Future<void> getOrdersByStatus(String id, String params) async {
    try {
      isLoading = true;
      hasError = false;
      notifyListeners();
      final url = "${Globals.apiURL}/api/waiter/$id/sales?status=$params";
      final response = await http.get(Uri.parse(url));
      logger.d(response.body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final List<dynamic> results = json["results"];
        final dynamic paginate = json["info"];
        _infoFiltered = InfoResponseDto.fromJson(paginate);
        _ordersFiltered =
            results.map((e) => OrderResponseDto.fromJson(e)).toList();
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

  Future<void> getOrdersByStatusPaginate(
      String id, String params, int page) async {
    try {
      isLoading = true;
      hasError = false;
      notifyListeners();
      final url =
          "${Globals.apiURL}/api/waiter/$id/sales?status=$params&page=$page";
      final response = await http.get(Uri.parse(url));
      logger.d(response.body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final List<dynamic> results = json["results"];
        final dynamic paginate = json["info"];
        _infoFiltered = InfoResponseDto.fromJson(paginate);
        _ordersFiltered =
            results.map((e) => OrderResponseDto.fromJson(e)).toList();
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

  Future<void> getOrdersPaginate(String id, int page) async {
    try {
      hasError = false;
      notifyListeners();
      final url = "${Globals.apiURL}/api/waiter/$id/sales?page=$page";
      final response = await http.get(Uri.parse(url));
      logger.d(response.body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final List<dynamic> results = json["results"];
        final dynamic paginate = json["info"];
        _info = InfoResponseDto.fromJson(paginate);
        final helper =
            results.map((e) => OrderResponseDto.fromJson(e)).toList();
        _orders.addAll(helper);
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

  Future<void> updateStatus(String id, String status) async {
    try {
      hasError = false;
      success = false;
      notifyListeners();
      final orderRequest = OrderStatus(status: status);
      final jsonBody = orderStatusToJson(orderRequest);
      final url = "${Globals.apiURL}/api/order/$id/";
      final response = await http.put(Uri.parse(url),
          body: jsonBody, headers: {"Content-Type": "application/json"});
      logger.d(response.body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final dynamic result = json["results"];
        logger.d(result);
        success = true;
      } else {
        hasError = true;
        success = false;
        logger.e('There is an error');
      }
    } catch (e) {
      hasError = true;
      success = false;
      logger.d(e);
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> updateSale(String id, double status) async {
    try {
      hasError = false;
      success = false;
      notifyListeners();
      final orderRequest = SalePay(moneyReceived: status);
      final jsonBody = salePayToJson(orderRequest);
      final url = "${Globals.apiURL}/api/sale/$id/";
      final response = await http.put(Uri.parse(url),
          body: jsonBody, headers: {"Content-Type": "application/json"});
      logger.d(response.body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final dynamic result = json["results"];
        logger.d(result);
        success = true;
      } else {
        hasError = true;
        success = false;
        logger.e('There is an error');
      }
    } catch (e) {
      hasError = true;
      success = false;
      logger.d(e);
    }

    isLoading = false;
    notifyListeners();
  }
}
