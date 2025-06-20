import 'package:amazon/constraints/global_variables.dart';
import 'package:amazon/features/accounts/widgets/single_product.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List list = [
    "https://m.media-amazon.com/images/I/61l9ppRIiqL._AC_UF1000,1000_QL80_.jpg",
    "https://m.media-amazon.com/images/I/61l9ppRIiqL._AC_UF1000,1000_QL80_.jpg",
    "https://m.media-amazon.com/images/I/61l9ppRIiqL._AC_UF1000,1000_QL80_.jpg",
    "https://m.media-amazon.com/images/I/61l9ppRIiqL._AC_UF1000,1000_QL80_.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              child: const Text(
                "Your Orders",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 15),
              child: Text(
                "See all",
                style: TextStyle(
                  color: GlobalVariables.selectedNavBarColor,
                ),
              ),
            ),
          ],
        ),
        // orders to be purchased
        Container(
          height: 170,
          padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return SingleProduct(image: list[index]);
            },
          ),
        ),
      ],
    );
  }
}
