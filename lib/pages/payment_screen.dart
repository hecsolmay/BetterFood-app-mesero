import 'package:app_waiter/pages/home_screen.dart';
import 'package:app_waiter/pages/orden.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _receivedController = TextEditingController();
  final TextEditingController _totalController = TextEditingController();
  final TextEditingController _changeController = TextEditingController();

  void _calculateChange() {
    final double received = double.tryParse(_receivedController.text) ?? 0;
    final double total = double.tryParse(_totalController.text) ?? 0;
    final double change = received - total;

    _changeController.text = change.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Realizar Pago'),
        backgroundColor: const Color.fromRGBO(185, 0, 0, 0.826),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _receivedController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Dinero Recibido',
              ),
              onChanged: (value) {
                setState(() {
                  _calculateChange();
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _totalController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Total',
              ),
              onChanged: (value) {
                setState(() {
                  _calculateChange();
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _changeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Cambio',
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Pago Exitoso'),
                      content: const Text('Gracias por su compra.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen ()),
                            );
                          },
                          child: const Text('Cerrar'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Realizar Pago'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromRGBO(185, 0, 0, 0.826)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
