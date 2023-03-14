
import 'package:app_waiter/pages/home_screen.dart';
import 'package:app_waiter/pages/notificaciones.dart';
import 'package:app_waiter/pages/orden.dart';
import 'package:app_waiter/pages/perfil.dart';
import 'package:app_waiter/providers/mesero_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    OrderScreen(),
    Notifications_Screen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WaiterProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red)),
        initialRoute: '/home',
        routes: {
          // '/login': (context) => const Login(),
          // '/loginmesero': (context) => const LoginMesero(),
          '/home': (context) => const HomeScreen(),
          '/order': (context) => const OrderScreen(),
          '/notifications': (context) => const Notifications_Screen(),
          '/profile': (context) => const ProfileScreen(),

          
         
        },
      ),
    );
  }
}

