import 'package:app_waiter/pages/notificaciones.dart';
import 'package:app_waiter/pages/orden.dart';
import 'package:app_waiter/pages/perfil.dart';
import 'package:app_waiter/providers/waiter_provider.dart';
import 'package:app_waiter/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  final pages = const [
    OrderScreen(),
    NotificationsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      final waiterProvider = Provider.of<WaiterProvider>(context);
      Provider.of<OrderProvider>(context, listen: false)
          .getDetailsOrders(waiterProvider.waiter?.id ?? "");
    }
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) => setState(() => index = value),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Orden',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notificaciones',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          )
        ],
      ),
    );
  }
}
