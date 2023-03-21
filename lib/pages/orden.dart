import 'package:app_waiter/dtos/response/mesero_response.dart';
import 'package:app_waiter/dtos/response/order_response.dart';
import 'package:app_waiter/pages/details.dart';
import 'package:app_waiter/providers/waiter_provider.dart';
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
  final status = ['all', 'pending', 'kitchen', 'served'];
  late TabController _tabController;

  void _handleTabChange() {
    if (!_tabController.indexIsChanging) {
      final selectedTab = _tabController.index;
      if (selectedTab != 0) {
        Provider.of<OrderProvider>(context, listen: false).cleanOrdersStatus();
        Provider.of<OrderProvider>(context, listen: false)
            .getOrdersByStatus(_waiter!.id, status[selectedTab]);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _waiter = Provider.of<WaiterProvider>(context, listen: false).waiter;
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
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
                    _builOrderListStatus('pending', context),
                    _builOrderListStatus('kitchen', context),
                    _builOrderListStatus('served', context),
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
    final info = orderProvider.info;

    if (orderProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (orderProvider.hasError) {
      return RefreshIndicator(
        onRefresh: () => orderProvider.refreshOrders(_waiter!.id),
        child: const Expanded(
          child: Center(
            child: Text('Ocurrio un error al traer los datos'),
          ),
        ),
      );
    }
    if (orders.isEmpty) {
      return RefreshIndicator(
        onRefresh: () => orderProvider.refreshOrders(_waiter!.id),
        child: const Expanded(
          child: Center(
            child: Text('No hay órdenes disponibles'),
          ),
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: () => orderProvider.refreshOrders(_waiter!.id),
      child: ListView.builder(
        itemCount: orders.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == orders.length) {
            final hasNext = info?.next ?? false;
            if (hasNext) {
              orderProvider.getOrdersPaginate(
                  _waiter!.id, info!.currentPage! + 1);
              return const Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: Center(child: CircularProgressIndicator()),
              );
            } else {
              return const SizedBox.shrink();
            }
          } else {
            final orden = orders[index].order;
            return OrderCard(orders: orders[index], orden: orden);
          }
        },
      ),
    );
  }

  Widget _builOrderListStatus(String type, BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    final orders = orderProvider.ordersFiltered;
    final info = orderProvider.infoFiltered;

    if (orders.isEmpty && orderProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (orderProvider.hasError) {
      return RefreshIndicator(
        onRefresh: () => orderProvider.getOrdersByStatus(_waiter!.id, type),
        child: const Expanded(
          child: Center(
            child: Text('Ocurrio un error al traer los datos'),
          ),
        ),
      );
    }
    if (orders.isEmpty) {
      return RefreshIndicator(
        onRefresh: () => orderProvider.getOrdersByStatus(_waiter!.id, type),
        child: const Expanded(
          child: Center(
            child: Text('No hay órdenes disponibles'),
          ),
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: () => orderProvider.getOrdersByStatus(_waiter!.id, type),
      child: ListView.builder(
        itemCount: orders.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == orders.length) {
            final hasNext = info?.next ?? false;
            if (hasNext) {
              orderProvider.getOrdersByStatusPaginate(
                  _waiter!.id, type, info!.currentPage! + 1);
              return const Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: Center(child: CircularProgressIndicator()),
              );
            } else {
              return const SizedBox.shrink();
            }
          } else {
            final orden = orders[index].order;
            return OrderCard(orders: orders[index], orden: orden);
          }
        },
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.orders,
    required this.orden,
  });

  final OrderResponseDto orders;
  final Order orden;

  @override
  Widget build(BuildContext context) {
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
                  builder: (context) => ProductDetails(sale: orders),
                ),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Mesa ${orden.tableId.numMesa}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              orden.status == "pendiente"
                                  ? const PendingStatus()
                                  : orden.status == "cocinando"
                                      ? const KitchenStatus()
                                      : const ServeStatus()
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
      ],
    );
  }
}

class PendingStatus extends StatelessWidget {
  const PendingStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Text(
          'Pendiente: ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 10),
        Icon(
          Icons.schedule_rounded,
          color: Colors.amber,
        ),
      ],
    );
  }
}

class KitchenStatus extends StatelessWidget {
  const KitchenStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Text(
          'Cocina: ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 10),
        Icon(
          Icons.soup_kitchen_rounded,
          color: Colors.blueAccent,
        ),
      ],
    );
  }
}

class ServeStatus extends StatelessWidget {
  const ServeStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Text(
          'Servido: ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 10),
        Icon(
          Icons.restaurant_menu_rounded,
          color: Colors.green,
        ),
      ],
    );
  }
}
