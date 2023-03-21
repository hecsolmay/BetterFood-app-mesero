import 'package:app_waiter/dtos/mesero_response.dart';
import 'package:app_waiter/pages/details.dart';
import 'package:app_waiter/providers/mesero_provider.dart';
import 'package:app_waiter/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  WaiterResponseDto? _waiter;
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _waiter = Provider.of<WaiterProvider>(context, listen: false).waiter;
    
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ordenes'),
        automaticallyImplyLeading: false,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Todos'),
            Tab(text: 'Pendientes'),
            Tab(text: 'En Cocina'),
            Tab(text: 'Servidos'),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _builOrderList('todos', context),
                    _builOrderList('pendientes', context),
                    _builOrderList('cocina', context),
                    _builOrderList('servidos', context),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _builOrderList(String type, BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    final orders = orderProvider.orders;

    if (orderProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (orderProvider.hasError) {
      return const Center(child: Text('Ocurrio un error al traer los datos'));
    }
    if (orders.isEmpty) {
      return const Center(child: Text('No hay órdenes disponibles'));
    }
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (BuildContext context, int index) {
        final orden = orders[index].order;
        return Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: InkWell(
                onTap: () {
                  // Agregue aquí la acción que desea realizar cuando se toca una tarjeta
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProductDetails()),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/images/order.jpg',
                        width: 302,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        width: 302,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.50),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Mesa ${orden.tableId.numMesa}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Estatus: ',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      const Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Text(
                                'Orden:  ${orden.orderNumber}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Icon(
                                Icons.info_rounded,
                                color: Color.fromRGBO(185, 0, 0, 0.826),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
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
        );
      },
    );
  }
}
