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
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WaiterProvider()),
      ],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromRGBO(185, 0, 0, 0.826),
          ),
        ),

        initialRoute: '/home', // Ruta inicial
        routes: {
          // '/login': (context) => const Login(),
          // '/loginmesero': (context) => const LoginMesero(),
          '/home': (context) => const HomeScreen(),
          '/order': (context) => const OrderScreen(),
          '/notifications': (context) => const NotificationsScreen(),
          '/profile': (context) => const ProfileScreen(),
        },
        home: const HomeScreen(),
      ),
    );
  }
}
