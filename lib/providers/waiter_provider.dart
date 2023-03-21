import 'package:app_waiter/dtos/response/info_response.dart';
import 'package:app_waiter/dtos/response/mesero_response.dart';
import 'package:app_waiter/dtos/response/notification_reponse.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import '../globals/globals.dart';

class WaiterProvider extends ChangeNotifier {
  final logger = Logger();
  bool _found = false;
  bool get found => _found;
  bool _hasError = false;
  bool get hasError => _hasError;
  bool _loading = true;
  bool get isLoading => _loading;
  bool _loadingNext = true;
  bool get isLoadingNext => _loadingNext;
  WaiterResponseDto? _waiter;
  List<NotificationResonse>? _notifications = [];
  List<NotificationResonse>? get notifications => _notifications;
  InfoResponseDto? _info;
  InfoResponseDto? get info => _info;

  WaiterResponseDto? get waiter => _waiter;

  Future<void> getByIdWaiter(String id) async {
    try {
      final url = "${Globals.apiURL}/api/m/waiter/$id";
      final response = await http.get(Uri.parse(url));
      logger.d(response.body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        _waiter = WaiterResponseDto.fromJson(json["results"]);
        _found = true;
        notifyListeners();
      } else {
        throw Exception('Failed to load waiter');
      }
    } catch (e) {
      logger.d(e);
    }
  }

  Future<void> getNotifications() async {
    try {
      _loading = true;
      final url = '${Globals.apiURL}/api/waiter/${waiter!.id}/notification';
      logger.d(url);
      final response = await http.get(Uri.parse(url));
      logger.d(response.body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final List<dynamic> results = json['results'];
        final dynamic jsonInfo = json['info'];
        _info = InfoResponseDto.fromJson(jsonInfo);
        _notifications =
            results.map((e) => NotificationResonse.fromJson(e)).toList();
      } else {
        _hasError = true;
      }
    } catch (e) {
      _hasError = true;
      logger.e(e);
    }
    _loading = false;
    notifyListeners();
  }

  Future<void> refreshNotifications() async {
    try {
      _loading = true;
      notifyListeners();
      final url = '${Globals.apiURL}/api/waiter/${waiter!.id}/notification';
      logger.d(url);
      final response = await http.get(Uri.parse(url));
      logger.d(response.body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final List<dynamic> results = json['results'];
        final dynamic jsonInfo = json['info'];
        _info = InfoResponseDto.fromJson(jsonInfo);
        _notifications =
            results.map((e) => NotificationResonse.fromJson(e)).toList();
      } else {
        _hasError = true;
      }
    } catch (e) {
      _hasError = true;
      logger.e(e);
    }
    _loading = false;
    notifyListeners();
  }

  Future<void> notificationsPaginate(int page) async {
    try {
      _loadingNext = true;
      final url =
          '${Globals.apiURL}/api/waiter/${waiter!.id}/notification?page=$page';
      logger.d(url);
      final response = await http.get(Uri.parse(url));
      logger.d(response.body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final List<dynamic> results = json['results'];
        final dynamic jsonInfo = json['info'];
        _info = InfoResponseDto.fromJson(jsonInfo);
        final helper =
            results.map((e) => NotificationResonse.fromJson(e)).toList();
        _notifications!.addAll(helper);
      } else {
        _hasError = true;
      }
    } catch (e) {
      _hasError = true;
      logger.e(e);
    }
    _loadingNext = false;
    notifyListeners();
  }
}
