import 'package:app_waiter/dtos/response/order_response.dart';
import 'package:app_waiter/pages/payment_screen.dart';
import 'package:app_waiter/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final OrderResponseDto sale;
  const ProductDetails({Key? key, required this.sale}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  Order? order;
  @override
  void initState() {
    super.initState();
    order = widget.sale.order;
  }

  @override
  Widget build(BuildContext context) {
    final products = order!.products;
    Icon icon;
    FloatingActionButton button = FloatingActionButton(onPressed: () {});

    if (order!.status == "pendiente") {
      icon = const Icon(
        Icons.soup_kitchen_rounded,
        color: Colors.white,
      );

      button = FloatingActionButton(
        tooltip: 'Cambiar Status',
        backgroundColor: Colors.blue,
        onPressed: () {
          _showStatusChangeDialog(context, order!.id, 'Cocina', 'cocinando');
        },
        child: icon,
      );
    }

    if (order!.status == "cocinando") {
      icon = const Icon(
        Icons.restaurant_menu_rounded,
        color: Colors.white,
      );
      button = FloatingActionButton(
        tooltip: 'Cambiar Status',
        backgroundColor: Colors.green,
        onPressed: () {
          _showStatusChangeDialog(context, order!.id, 'Servido', 'servido');
        },
        child: icon,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del pedido'),
        backgroundColor: const Color.fromRGBO(185, 0, 0, 0.826),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Stack(children: [
            order!.status == 'pendiente'
                ? Positioned(
                    bottom: 30,
                    right: 20,
                    child: FloatingActionButton(
                      tooltip: 'Eliminar Orden',
                      onPressed: () {
                        _mostrarDialogoConfirmacionCancelacion(
                            context, order!.id);
                      },
                      child: const Icon(Icons.delete),
                    ),
                  )
                : const SizedBox.shrink(),
            order!.status != 'servido'
                ? Positioned(bottom: 30, left: 20, child: button)
                : const SizedBox.shrink(),
            Column(
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  height: 380,
                  child: Card(
                    color: const Color.fromRGBO(217, 217, 217, 1000),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: products.length,
                            itemBuilder: (BuildContext context, int index) {
                              final product = products[index].product;
                              final extras = products[index].extras;
                              final remove = products[index].remove;
                              int price = product.price;

                              if (extras!.isNotEmpty) {
                                for (var i = 0; i < extras.length; i++) {
                                  price += extras[i].extraPrice;
                                }
                              }
                              int total = price * products[index].quantity;

                              return ListTile(
                                leading: Image.network(
                                  product.imgUrl,
                                  height: 80,
                                  width: 80,
                                ),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      product.name,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    extras.isNotEmpty || remove!.isNotEmpty
                                        ? IconButton(
                                            icon: const Icon(
                                              Icons.info,
                                              size: 25,
                                            ),
                                            color: const Color.fromARGB(
                                                210, 219, 61, 61),
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return InfoDialog(
                                                      extras: extras,
                                                      remove: remove);
                                                },
                                              );
                                            },
                                          )
                                        : const SizedBox.shrink()
                                  ],
                                ),
                                subtitle: Row(
                                  children: [
                                    Text(
                                      '\$${price.toStringAsFixed(2)}',
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text('x${products[index].quantity}'),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '\$${total.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                      height: 40,
                    ),
                    const Text(
                      'Subtotal',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      width: 163,
                    ),
                    Text(
                      "\$${order!.total}",
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  color: Colors.black,
                  width: 310,
                  height: 2,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                      height: 40,
                    ),
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(
                      width: 118,
                    ),
                    Text(
                      "\$${order!.total}",
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                order!.status == 'servido'
                    ? ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PaymentScreen(
                                totalPrice: order!.total,
                                saleId: widget.sale.id,
                              ),
                            ),
                          );
                        },
                        style: ButtonStyle(
                            fixedSize:
                                MaterialStateProperty.all(const Size(150, 40)),
                            backgroundColor: const MaterialStatePropertyAll(
                                Color.fromRGBO(185, 0, 0, 0.826))),
                        child: const Text('Pagar'),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  void _mostrarDialogoConfirmacionCancelacion(
      BuildContext context, String orderId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final orderProvider = Provider.of<OrderProvider>(context);
        return AlertDialog(
          title: const Text("Confirmar cancelación"),
          content: const Text("¿Está seguro de que desea cancelar la orden?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Sí"),
              onPressed: () async {
                await orderProvider.updateStatus(orderId, 'cancelado');
                Navigator.of(context).pop();

                if (orderProvider.success) {
                  // ignore: use_build_context_synchronously
                  successDeletDialog(context);
                } else {
                  // ignore: use_build_context_synchronously
                  errorDialog(context);
                }
              },
            ),
            TextButton(
              child: const Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showStatusChangeDialog(BuildContext context, String orderId,
      String status, String statusRequest) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final orderProvider = Provider.of<OrderProvider>(context);
        return AlertDialog(
          title: Text("Cambiar a $status"),
          content: const Text(
              "¿Está seguro de que desea cambiar el estatus de la orden?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Sí"),
              onPressed: () async {
                await orderProvider.updateStatus(orderId, statusRequest);
                Navigator.of(context).pop();

                if (orderProvider.success) {
                  // ignore: use_build_context_synchronously
                  successDialog(context);
                } else {
                  // ignore: use_build_context_synchronously
                  errorDialog(context);
                }
              },
            ),
            TextButton(
              child: const Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> errorDialog(BuildContext context) {
    return showDialog(
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
                  'Ocurrio un error al hacer los cambios intentelo de nuevo',
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

  Future<dynamic> successDeletDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Cambio Correcto',
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            height: 210,
            child: Column(
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  size: 150,
                  color: Colors.green,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'La orden ${order!.orderNumber} se elimino con exito',
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
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> successDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Cambio Correcto',
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            height: 200,
            child: Column(
              children: const [
                Icon(
                  Icons.check_circle_outline,
                  size: 150,
                  color: Colors.green,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'El estado se cambio con exito',
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
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class InfoDialog extends StatelessWidget {
  const InfoDialog({
    super.key,
    required this.extras,
    required this.remove,
  });

  final List<Extra>? extras;
  final List<Remove>? remove;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text('Personalizacion'),
      content: SizedBox(
        height: 250,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              extras!.isNotEmpty
                  ? const Text(
                      "Ingredientes Extras",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )
                  : const SizedBox.shrink(),
              ...extras!.map(
                (e) => ListTile(
                  title: Text(
                    e.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Row(
                    children: [
                      Text(
                        '\$${e.extraPrice.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              remove!.isNotEmpty
                  ? const Text(
                      "Ingredientes Para quitar",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )
                  : const SizedBox.shrink(),
              ...remove!.map(
                (e) => ListTile(
                  title: Text(
                    '* ${e.name}',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cerrar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
