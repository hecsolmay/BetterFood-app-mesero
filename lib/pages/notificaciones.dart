import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<Widget> _notificationCards = [
    _buildNotificationCard(
      icon: Icons.help_outline,
      title: 'Ayuda',
      subtitle: 'La mesa número 15 necesita ayuda.',
    ),
    _buildNotificationCard(
      icon: Icons.check_circle,
      title: 'Orden lista',
      subtitle: 'Orden de la mesa 15 terminada.',
    ),
    _buildNotificationCard(
      icon: Icons.help_outline,
      title: 'Ayuda',
      subtitle: 'La mesa número 7 necesita ayuda.',
    ),
    _buildNotificationCard(
      icon: Icons.check_circle,
      title: 'Orden lista',
      subtitle: 'Orden de la mesa 7 terminada.',
    ),
    _buildNotificationCard(
      icon: Icons.help_outline,
      title: 'Ayuda',
      subtitle: 'La mesa número 2 necesita ayuda.',
    ),
    _buildNotificationCard(
      icon: Icons.check_circle,
      title: 'Orden lista',
      subtitle: 'Orden de la mesa 2 terminada.',
    ),
    _buildNotificationCard(
      icon: Icons.check_circle,
      title: 'Orden lista',
      subtitle: 'Orden de la mesa 2 terminada.',
    ),
    _buildNotificationCard(
      icon: Icons.help_outline,
      title: 'Ayuda',
      subtitle: 'La mesa número 2 necesita ayuda.',
    ),
    _buildNotificationCard(
      icon: Icons.help_outline,
      title: 'Ayuda',
      subtitle: 'La mesa número 2 necesita ayuda.',
    ),
    _buildNotificationCard(
      icon: Icons.help_outline,
      title: 'Ayuda',
      subtitle: 'La mesa número 2 necesita ayuda.',
    ),
    _buildNotificationCard(
      icon: Icons.check_circle,
      title: 'Orden lista',
      subtitle: 'Orden de la mesa 2 terminada.',
    ),
  ];

  static Widget _buildNotificationCard(
      {required IconData icon, required String title, required String subtitle}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            width: 350,
            height: 100,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    10), // define el radio de las esquinas
              ),
              color: Color.fromARGB(130, 217, 217, 217),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  contentPadding: EdgeInsets.only(top: 6),
                  leading: CircleAvatar(
                    backgroundColor: icon == Icons.help_outline
                        ? Colors.red
                        : Colors.green,
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: 30,
                      
                    ),
                  ),
                  title: Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  subtitle: Text(
                    subtitle,
                    style: const TextStyle(fontSize: 14),
                  ),
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
