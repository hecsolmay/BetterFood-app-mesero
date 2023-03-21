import 'package:app_waiter/pages/login.dart';
import 'package:app_waiter/providers/info_waiter_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final infowaiter =  Provider.of<InfoWaiterProvider>(context);
    final info = infowaiter.waiterinfo;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              onPressed: () async {
                bool? logout = await _showLogoutDialog(context);
                if (logout == true) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                }
              },
              icon: const Icon(Icons.cancel_presentation_outlined),
              iconSize: 30,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    // color: Colors.red,
                    image: DecorationImage(
                      image: AssetImage('assets/images/user.jpg'),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Mesero',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                  )
                ],
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Container(
                  height: 200,
                  width: 270,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.amber,
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              const Text(
                                'Nombre: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${info?.name} ${info?.lastName}',
                                style: const TextStyle(),
                              )
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children:  [
                              const Text(
                                'Fecha de nacimiento: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                             Text(
                                DateFormat('dd/MM/yyyy').format(info!.birthdate),
                                style: const TextStyle(),
                              )



                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children:  [
                              const Text(
                                'Edad:  ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                               Text(
                                '${info.age}',
                                style: const TextStyle(),
                              )
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: const [
                              Text(
                                'Numero de telefono: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '99-95-07-66-18',
                                style: TextStyle(),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool?> _showLogoutDialog(BuildContext context) async {
  return await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Cerrar sesión'),
        content: const Text('¿Está seguro que desea cerrar sesión?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: const Text('Aceptar'),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );
}
