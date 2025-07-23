import 'package:amazon/common/widgets/loader.dart';
import 'package:amazon/features/accounts/widgets/single_product.dart';
import 'package:amazon/features/admin/services/admin_services.dart';
import 'package:amazon/features/order_details/screens/order_details_screen.dart';
import 'package:amazon/models/order.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final AdminServices adminServices = AdminServices();
  List<Order>? orders;
  @override
  void initState() {
    super.initState();
    fetchAllOrders();
  }

  fetchAllOrders() async {
    orders = await adminServices.showAllOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? Loader()
        : GridView.builder(
            itemCount: orders!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              final order = orders![index];
              return GestureDetector(
                onTap: () => Navigator.pushNamed(context, OrderDetailsScreen.routeName, arguments: order),
                child: Container(
                  height: 180,
                  margin: EdgeInsets.all(8),
                  child: SingleProduct(image: order.products[0].images[0]),
                ),
              );
            },
          );
  }
}
