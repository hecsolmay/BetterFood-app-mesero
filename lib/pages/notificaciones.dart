import 'package:app_waiter/pages/perfil.dart';
import 'package:flutter/material.dart';

class Notifications_Screen extends StatefulWidget {
  const Notifications_Screen({super.key});

  @override
  State<Notifications_Screen> createState() => _Notifications_ScreenState();
}

class _Notifications_ScreenState extends State<Notifications_Screen> {
  int _selectedIndex = 0;

  final List<Widget> _notificationCards = [
    _buildNotificationCard(
      icon: Icons.notifications_active_rounded,
      text: 'La mesa número 15 necesita ayuda.',
    ),
    _buildNotificationCard(
      icon: Icons.check_circle,
      text: 'Orden de la mesa 15 terminada.',
    ),
    _buildNotificationCard(
      icon: Icons.notifications_active_rounded,
      text: 'La mesa número 7 necesita ayuda.',
    ),
    _buildNotificationCard(
      icon: Icons.check_circle,
      text: 'Orden de la mesa 7 terminada.',
    ),
    _buildNotificationCard(
      icon: Icons.notifications_active_rounded,
      text: 'La mesa número 2 necesita ayuda.',
    ),
    _buildNotificationCard(
      icon: Icons.check_circle,
      text: 'Orden de la mesa 2 terminada.',
    ),
    _buildNotificationCard(
      icon: Icons.check_circle,
      text: 'Orden de la mesa 2 terminada.',
    ),
    _buildNotificationCard(
      icon: Icons.notifications_active_rounded,
      text: 'La mesa número 2 necesita ayuda.',
    ),
    _buildNotificationCard(
      icon: Icons.notifications_active_rounded,
      text: 'La mesa número 2 necesita ayuda.',
    ),
    _buildNotificationCard(
      icon: Icons.notifications_active_rounded,
      text: 'La mesa número 2 necesita ayuda.',
    ),
    _buildNotificationCard(
      icon: Icons.check_circle,
      text: 'Orden de la mesa 2 terminada.',
    ),
  ];

  static Widget _buildNotificationCard(
      {required IconData icon, required String text}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            width: 350,
            height: 70,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius:
                  BorderRadius.circular(10), // define el radio de las esquinas
              ),
              child: ListTile(
                leading: Icon(
                  icon,
                   color: icon == Icons.notifications_active_rounded ? Colors.red : Colors.green, 
                   size: 35,
                ),
                title: Text(
                  text,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              color: const Color.fromRGBO(217, 217, 217, 1000),
            ),
          ),
        ),
        const SizedBox(
          height: 10.0,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificaciones'),
        backgroundColor: const Color.fromRGBO(185, 0, 0, 0.826),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: _notificationCards.length,
            itemBuilder: (context, index) {
              return _notificationCards[index];
            },
          ),
        ),
      ),
      
    );
  }
}
