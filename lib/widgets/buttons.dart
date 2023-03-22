import 'package:app_waiter/providers/scoket_provider.dart';
import 'package:app_waiter/providers/waiter_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15, right: 10),
              child: Icon(
                Icons.logout,
                size: 100,
                color: Colors.red.shade400,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  "Cerrar Sesion",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 15),
                Text(
                  "¿Estas seguro de cerra sesion despues no podras regresar a esta pantalla?",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<WaiterProvider>(context, listen: false)
                          .close();
                      Provider.of<SocketProvider>(context, listen: false)
                          .disconnect();

                      Navigator.pop(context);
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/login',
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(90, 45),
                    ),
                    child: const Text("SI"),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      minimumSize: const Size(90, 45),
                    ),
                    child: const Text("No"),
                  )
                ],
              ),
            ],
          ),
        );
        print("Cerrando Sesion");
      },
      icon: const Icon(Icons.logout),
    );
  }
}
