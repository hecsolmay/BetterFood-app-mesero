import 'package:app_waiter/dtos/mesero_response.dart';
import 'package:app_waiter/pages/details.dart';
import 'package:app_waiter/providers/mesero_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> with SingleTickerProviderStateMixin {
  WaiterResponseDto? _waiter;
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    // Obtener la instancia del provider en el initState
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
                    _builOrderList('todos'),
                    _builOrderList('pendientes'),
                    _builOrderList('cocina'),
                    _builOrderList('servidos'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _builOrderList(String type) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
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
                      Image.network(
                        'https://images.unsplash.com/photo-1509315703195-529879416a7d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
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
                                  const Text(
                                    'Mesa 1',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Row(
                                    children: const [
                                      Text(
                                        'Estatus',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              const Text(
                                'Orden: 1\nPlatillos : 2\nTiempo: 40 minutos',
                                style: TextStyle(
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
