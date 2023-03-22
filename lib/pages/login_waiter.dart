import 'package:app_waiter/providers/scoket_provider.dart';
import 'package:app_waiter/providers/waiter_provider.dart';
import 'package:app_waiter/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class LoginMesero extends StatefulWidget {
  const LoginMesero({super.key});

  @override
  State<LoginMesero> createState() => _LoginMeseroState();
}

class _LoginMeseroState extends State<LoginMesero> {
  String qrMesero = " ";
  late SocketProvider socketState;

  void scanQr() async {
    String? cameraScanResult = await scanner.scan();
    setState(() {
      qrMesero = cameraScanResult!;
    });
  }

  @override
  void initState() {
    super.initState();
    socketState = Provider.of<SocketProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final waiterprovider = Provider.of<WaiterProvider>(
      context,
    );
    final orderprovider = Provider.of<OrderProvider>(
      context,
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 800, // Set a fixed height for the container
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/Fondo.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0.1 * MediaQuery.of(context).size.height,
                left: 0.3 * MediaQuery.of(context).size.width,
                child: Container(
                  width: 0.4 * MediaQuery.of(context).size.width,
                  height: 0.4 * MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/logo.png',
                      ),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(
                      top: 0.5 * MediaQuery.of(context).size.height),
                  width: 0.9 * MediaQuery.of(context).size.width,
                  height: 300,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        children: [
                          const Text(
                            'Bienvenido a BetterFood - MESERO',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Flexible(
                            child: IconButton(
                              onPressed: () async {
                                String? cameraScanResult = await scanner.scan();
                                setState(() {
                                  qrMesero = cameraScanResult!;
                                });
                                //
                                await waiterprovider.getByIdWaiter(qrMesero);
                                // await orderprovider.getListOrder(qrMesero);
                                // await orderprovider.fetchOrders(qrMesero);

                                if (waiterprovider.found) {
                                  orderprovider.getDetailsOrders(qrMesero);
                                  socketState.connect(id: qrMesero);
                                  Navigator.pushNamed(context, '/home');
                                } else {
                                  alertNotFound(context);
                                }
                              },
                              icon: const Icon(
                                Icons.camera,
                                color: Colors.black,
                              ),
                              iconSize: 50.0,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(
                            'Oprima el icono para scanear su codigo QR',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> alertNotFound(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error en econtrar mesero'),
        content: Column(mainAxisSize: MainAxisSize.min, children: const [
          SizedBox(
            height: 20,
          ),
          Icon(
            Icons.cancel,
            size: 64,
            color: Colors.red,
          ),
          SizedBox(
            height: 20,
          )
        ]),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          )
        ],
      ),
    );
  }
}
