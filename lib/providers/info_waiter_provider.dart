import 'package:app_waiter/dtos/info_waiter_response.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import '../globals/globals.dart';

class InfoWaiterProvider extends ChangeNotifier {
  final logger = Logger();
  bool _found = false;
  bool get found => _found;
  WaiterinfoResponseDto? _waiterinfo;

  WaiterinfoResponseDto? get waiterinfo => _waiterinfo;

  Future<void> getByIdWaiterInfo(String id) async {
    try {
      final url = "${Globals.apiURL}/api/waiter/$id";
      final response = await http.get(Uri.parse(url));
      logger.d(response.body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        _waiterinfo = WaiterinfoResponseDto.fromJson(json["results"]);
        _found = true;
        notifyListeners();
      } else {
        throw Exception('Failed to load waiter');
      }
    } catch (e) {
      logger.d(e);
    }
  }



}
