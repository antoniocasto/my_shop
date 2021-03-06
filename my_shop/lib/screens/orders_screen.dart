import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Orders',
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: orderData.orders.length,
          itemBuilder: (ctx, index) => OrderItem(
            order: orderData.orders[index],
          ),
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
