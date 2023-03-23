import 'package:app_waiter/dtos/response/mesero_response.dart';
import 'package:app_waiter/pages/home_screen.dart';
import 'package:app_waiter/pages/login.dart';
import 'package:app_waiter/pages/login_waiter.dart';
import 'package:app_waiter/pages/notificaciones.dart';
import 'package:app_waiter/pages/orden.dart';
import 'package:app_waiter/pages/perfil.dart';
import 'package:app_waiter/providers/order_provider.dart';
import 'package:app_waiter/providers/scoket_provider.dart';
import 'package:app_waiter/providers/waiter_provider.dart';
import 'package:app_waiter/utils/shared_cache.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedCache = SharedCache();

  final waiterCache = await sharedCache.getWaiterFromCache();
  runApp(MyApp(
    waiter: waiterCache,
  ));
}

class MyApp extends StatelessWidget {
  final WaiterResponseDto? waiter;
  const MyApp({super.key, this.waiter});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WaiterProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => SocketProvider()),
      ],
      builder: (context, child) {
        String initialRoute = '/login';

        if (waiter != null) {
          initialRoute = '/home';
          Provider.of<WaiterProvider>(context).waiterFromCache(waiter);
        }
        return MaterialApp(
          title: 'Material App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color.fromRGBO(185, 0, 0, 0.826),
            ),
          ),

          initialRoute: initialRoute, // Ruta inicial
          routes: {
            '/login': (context) => const Login(),
            '/loginmesero': (context) => const LoginMesero(),
            '/home': (context) => const HomeScreen(),
            '/order': (context) => const OrderScreen(),
            '/notifications': (context) => const NotificationsScreen(),
            '/profile': (context) => const ProfileScreen(),
          },
          home: const HomeScreen(),
        );
      },
    );
  }
}
