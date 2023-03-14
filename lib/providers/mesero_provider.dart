import 'package:app_waiter/dtos/mesero_response.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../globals/globals.dart';

class WaiterProvider extends ChangeNotifier {

  bool _found = false; 
  bool get found => _found;
  WaiterResponseDto? _waiter = null;

  WaiterResponseDto? get waiter => _waiter;

  Future<void> getByIdWaiter(String id) async {
    try {
      
      final url = "${Globals.apiURL}/api/m/waiter/$id";
      final response = await http.get(Uri.parse(url));
      print(response.body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        _waiter = WaiterResponseDto.fromJson(json["results"]);
        _found = true;
        notifyListeners();
      } else {
        
        throw Exception('Failed to load waiter');
      }
    } catch (e) {
      print(e);
    } 
  }
}

