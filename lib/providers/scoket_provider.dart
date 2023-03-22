import 'dart:convert';
import 'package:app_waiter/globals/globals.dart';
import 'package:app_waiter/providers/waiter_provider.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketProvider extends ChangeNotifier {
  late IO.Socket socket;
  final logger = Logger();
  final waiterProvider = WaiterProvider();

  void connect({String id = '63f804a8757fa73689a81958'}) {
    socket = IO.io(Globals.apiURL, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();

    socket.on('connect', (data) {
      logger.d('Connected to server');
      socket.emit('join', id);
      logger.d('Join emitido');
    });

    socket.on('notification', (data) {
      print('se conecto');
      final response = jsonEncode(data);
      waiterProvider.newNotification(response);
    });
  }

  void disconnect() {
    socket.disconnect();
  }
}
