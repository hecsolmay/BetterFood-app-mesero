import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
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
                borderRadius: BorderRadius.circular(
                    10), // define el radio de las esquinas
              ),
              color: const Color.fromRGBO(217, 217, 217, 1000),
              child: ListTile(
                leading: Icon(
                  icon,
                  color: icon == Icons.notifications_active_rounded
                      ? Colors.red
                      : Colors.green,
                  size: 35,
                ),
                title: Text(
                  text,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
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
        automaticallyImplyLeading: false,
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
