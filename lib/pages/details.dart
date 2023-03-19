import 'package:app_waiter/dtos/mesero_response.dart';
import 'package:app_waiter/dtos/order_response.dart';

import 'package:app_waiter/pages/payment_screen.dart';
import 'package:app_waiter/providers/mesero_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Product {
  final String name;
  final String image;
  final double price;

  const Product({required this.name, required this.image, required this.price});
}

class ExtraProduct {
  final String name;
  final double price;

  const ExtraProduct({required this.name, required this.price});
}

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  WaiterResponseDto? _waiter;
  @override
  void initState() {
    super.initState();
    // Obtener la instancia del provider en el initState
    _waiter = Provider.of<WaiterProvider>(context, listen: false).waiter;
  }

  @override
  Widget build(BuildContext context) {
    final extraproducs = [
      const ExtraProduct(name: 'Alitas', price: 15.99),
      const ExtraProduct(name: 'Alitas', price: 15.99),
      const ExtraProduct(name: 'Alitas', price: 15.99),
      const ExtraProduct(name: 'Alitas', price: 15.99)
    ];
    final products = [
      const Product(
          name: 'Hamburguesa',
          image:
              'https://cdn.pixabay.com/photo/2019/01/29/18/05/burger-3962996_1280.jpg',
          price: 10.99),
      const Product(
          name: 'Pizza',
          image:
              'https://cdn.pixabay.com/photo/2017/12/09/08/18/pizza-3007395_1280.jpg',
          price: 18.99),
      const Product(
          name: 'Ensalada',
          image:
              'https://cdn.pixabay.com/photo/2017/05/11/19/44/fresh-fruits-2305192_1280.jpg',
          price: 12.99),
      const Product(
          name: 'Pasta',
          image:
              'https://cdn.pixabay.com/photo/2014/10/26/15/27/pasta-503952_1280.jpg',
          price: 12.99),
      const Product(
          name: 'Pan',
          image:
              'https://cdn.pixabay.com/photo/2016/03/27/21/59/bread-1284438_1280.jpg',
          price: 12.99),
      const Product(
          name: 'Pan',
          image:
              'https://cdn.pixabay.com/photo/2016/03/27/21/59/bread-1284438_1280.jpg',
          price: 12.99),
      // agregar más productos aquí
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del pedido'),
        backgroundColor: const Color.fromRGBO(185, 0, 0, 0.826),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: [
              const SizedBox(height: 20),
              SizedBox(
                height: 380, // define el alto de la Card
                child: Card(
                  color: const Color.fromRGBO(217, 217, 217, 1000),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10), // define el radio de las esquinas
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: products.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              leading: Image.network(
                                products[index].image,
                                height: 80,
                                width: 80,
                              ),
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    products[index].name,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.info,
                                      size: 25,
                                    ),
                                    color: Color.fromRGBO(185, 0, 0, 0.826),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Expanded(
                                              child: SingleChildScrollView(
                                                child: SizedBox(
                                                  height: 300,
                                                  child: ListView.builder(
                                                    itemCount: extraproducs.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return ListTile(
                                                        title: Text(
                                                          extraproducs[index].name,
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight.bold),
                                                        ),
                                                        subtitle: Row(
                                                          children: [
                                                            Text(
                                                              '\$${extraproducs[index].price.toStringAsFixed(2)}',
                                                              style: const TextStyle(
                                                                  fontSize: 16),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text('Cerrar'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  )
                                ],
                              ),
                              subtitle: Row(
                                children: [
                                  Text(
                                    '\$${products[index].price.toStringAsFixed(2)}',
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                  const SizedBox(width: 10,),
                                  const Text(
                                    'x1'
                                  ),
                                  const SizedBox(width: 10,),
                                  Text(
                                    '\$${products[index].price.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black
                                    ),
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
                children: const [
                  SizedBox(
                    width: 10,
                    height: 40,
                  ),
                  Text(
                    'Subtotal',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    width: 163,
                  ),
                  Text(
                    "\$1,040.00",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
                children: const [
                  SizedBox(
                    width: 10,
                    height: 40,
                  ),
                  Text(
                    'Total',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    width: 118,
                  ),
                  Text(
                    "\$1,040.00",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const PaymentScreen()));
                },
                style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(const Size(150, 40)),
                    backgroundColor: const MaterialStatePropertyAll(
                        Color.fromRGBO(185, 0, 0, 0.826))),
                child: const Text('Pagar'),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  onPressed: () {
                    _mostrarDialogoConfirmacionCancelacion(context);
                  },
                  icon: const Icon(
                    Icons.cancel_rounded,
                    size: 50,
                  ),
                  color: const Color.fromRGBO(185, 0, 0, 0.826),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              if (_waiter != null)
                Text(
                  'Mesa atendida por: ${_waiter?.name} ${_waiter?.lastName}',
                  style: const TextStyle(
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
    );
  }

  void _mostrarDialogoConfirmacionCancelacion(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmar cancelación"),
          content: const Text("¿Está seguro de que desea cancelar la orden?"),
          actions: <Widget>[
            TextButton(
              child: const Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Sí"),
              onPressed: () {
                // Aquí puede agregar la lógica para cancelar la orden
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
