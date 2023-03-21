import 'package:app_waiter/pages/home_screen.dart';
import 'package:app_waiter/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatefulWidget {
  final int totalPrice;
  final String saleId;
  const PaymentScreen(
      {Key? key, required this.totalPrice, required this.saleId})
      : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _receivedController = TextEditingController();
  final TextEditingController _totalController = TextEditingController();
  final TextEditingController _changeController = TextEditingController();

  void _calculateChange() {
    final double received = double.tryParse(_receivedController.text) ?? 0;
    final double total = double.tryParse(widget.totalPrice.toString()) ?? 0;
    final double change = received - total;

    if (received < total) {
      _changeController.text = 'Cambio: \$0.00';
    } else {
      _changeController.text = 'Cambio: \$${change.toStringAsFixed(2)}';
    }
  }

  @override
  void initState() {
    super.initState();
    _totalController.text = "Total: \$${widget.totalPrice.toStringAsFixed(2)}";
    _changeController.text = "Cambio: \$0.00";
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
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
              readOnly: true,
              controller: _totalController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              readOnly: true,
              controller: _changeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Cambio',
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                final double received =
                    double.tryParse(_receivedController.text) ?? 0;
                final double total =
                    double.tryParse(widget.totalPrice.toString()) ?? 0;

                if (received < total) {
                  String message;
                  if (double.tryParse(_receivedController.text) == null) {
                    message =
                        'El formato del dinero recibido no es correcto solo se aceptan numeros';
                  } else {
                    message = 'El precio debe ser mayor o igual al total';
                  }
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text(
                          'Error de validacion',
                          textAlign: TextAlign.center,
                        ),
                        content: SizedBox(
                          height: 230,
                          child: Column(
                            children: [
                              const Icon(
                                Icons.error_outline_rounded,
                                size: 150,
                                color: Colors.red,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                message,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  await orderProvider.updateSale(widget.saleId, received);
                  if (orderProvider.success) {
                    // ignore: use_build_context_synchronously
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Pago Exitoso'),
                          content: SizedBox(
                            height: 230,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.check_circle_rounded,
                                  size: 150,
                                  color: Colors.green.shade400,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  'Gracias por su compra.',
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/home', (route) => false);
                              },
                              child: const Text('Cerrar'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    // ignore: use_build_context_synchronously
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text(
                            'Ocurrio un error',
                            textAlign: TextAlign.center,
                          ),
                          content: SizedBox(
                            height: 230,
                            child: Column(
                              children: const [
                                Icon(
                                  Icons.error_outline_outlined,
                                  size: 150,
                                  color: Colors.red,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Ocurrio un error al hacer el pago intentelo de nuevo',
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromRGBO(185, 0, 0, 0.826)),
              ),
              child: const Text('Realizar Pago'),
            ),
          ],
        ),
      ),
    );
  }
}
