import 'package:app_waiter/pages/details.dart';
import 'package:app_waiter/providers/order_provider.dart';
import 'package:app_waiter/providers/waiter_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<WaiterProvider>(context, listen: false).getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    final waiterProvider = Provider.of<WaiterProvider>(context);
    final notifications = waiterProvider.notifications;
    final info = waiterProvider.info;
    int lastDay = 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificaciones'),
        automaticallyImplyLeading: false,
      ),
      body: waiterProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => waiterProvider.refreshNotifications(),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: notifications!.length + 1,
                    itemBuilder: (context, index) {
                      if (index == notifications.length) {
                        final hasNext = info?.next ?? false;
                        if (hasNext) {
                          waiterProvider
                              .notificationsPaginate(info!.currentPage! + 1);
                          return const Padding(
                            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      } else {
                        final notification = notifications[index];
                        String title = notification.title ?? '';
                        String subtitle = notification.text ?? '';
                        IconData icon = notification.type == 'help'
                            ? Icons.help_outline
                            : Icons.restaurant_rounded;

                        DateTime time = notification.createdAt?.toLocal() ??
                            DateTime.parse('2023-03-20T21:16:29.435Z');

                        String month = time.month < 10
                            ? '0${time.month}'
                            : '${time.month}';
                        String day =
                            time.day < 10 ? '0${time.day}' : '${time.day}';

                        String saleId = notification.sale ?? '';

                        if (index == 0) {
                          lastDay = time.day;
                          return Column(
                            children: [
                              const SizedBox(height: 15),
                              Text(
                                "$month-$day-${time.year}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              const SizedBox(height: 15),
                              _buildNotificationCard(
                                icon: icon,
                                title: title,
                                subtitle: subtitle,
                                dateTime: time,
                                saleId: saleId,
                                context: context,
                              )
                            ],
                          );
                        }

                        if (time.day != lastDay) {
                          lastDay = time.day;

                          return Column(
                            children: [
                              const SizedBox(height: 15),
                              Text(
                                "$month-$day-${time.year}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              const SizedBox(height: 15),
                              _buildNotificationCard(
                                icon: icon,
                                title: title,
                                subtitle: subtitle,
                                dateTime: time,
                                saleId: saleId,
                                context: context,
                              )
                            ],
                          );
                        }

                        return _buildNotificationCard(
                          icon: icon,
                          title: title,
                          subtitle: subtitle,
                          dateTime: time,
                          saleId: saleId,
                          context: context,
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
    );
  }

  static Widget _buildNotificationCard(
      {required IconData icon,
      required String title,
      required String subtitle,
      required DateTime dateTime,
      required String saleId,
      required BuildContext context}) {
    final orderProvider = Provider.of<OrderProvider>(context);
    String minute = dateTime.minute.toString().length == 2
        ? '${dateTime.minute}'
        : '0${dateTime.minute}';
    String hour = dateTime.hour < 12
        ? '${dateTime.hour}:$minute am'
        : dateTime.hour == 12
            ? '${dateTime.hour}:$minute pm'
            : '${dateTime.hour - 12}:$minute pm';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: SizedBox(
        width: 350,
        height: 100,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(10), // define el radio de las esquinas
          ),
          color: const Color.fromARGB(248, 247, 247, 247),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              contentPadding: const EdgeInsets.only(top: 6),
              leading: CircleAvatar(
                backgroundColor: icon == Icons.help_outline
                    ? Colors.blueAccent
                    : Colors.green,
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              title: Text(
                title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  subtitle,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              trailing: Text("$hour ", style: const TextStyle(fontSize: 10)),
              dense: false,
              onTap: () async {
                if (icon != Icons.help_outline) {
                  await orderProvider.getOrderById(saleId);

                  if (!orderProvider.hasError) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetails(sale: orderProvider.order),
                        ));
                  }
                } else {
                  print("Esta es la ayuda");
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
