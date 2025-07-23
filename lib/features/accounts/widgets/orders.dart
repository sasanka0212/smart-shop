import 'package:amazon/common/widgets/loader.dart';
import 'package:amazon/constraints/global_variables.dart';
import 'package:amazon/features/accounts/services/account_services.dart';
import 'package:amazon/features/accounts/widgets/single_product.dart';
import 'package:amazon/features/order_details/screens/order_details_screen.dart';
import 'package:amazon/models/order.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orders;
  final AccountServices accountServices = AccountServices();

  @override
  void initState() {
    super.initState();
    fetchAllOrders();
  }

  fetchAllOrders() async {
    orders = await accountServices.fetchMyOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null 
      ? const Loader()
      : Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              child: const Text(
                "Your Orders",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 15),
              child: Text(
                "See all",
                style: TextStyle(color: GlobalVariables.selectedNavBarColor),
              ),
            ),
          ],
        ),
        // orders to be purchased
        Container(
          height: 170,
          padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: orders!.length,
            itemBuilder: (context, index) {
              final order = orders![index];
              return InkWell(
                onTap: () => Navigator.pushNamed(context, OrderDetailsScreen.routeName, arguments: order),
                child: SingleProduct(image: order.products[0].images[0]),
              );
            },
          ),
        ),
      ],
    );
  }
}
