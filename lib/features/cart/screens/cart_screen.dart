import 'package:amazon/common/widgets/custom_button.dart';
import 'package:amazon/constraints/global_variables.dart';
import 'package:amazon/features/address/screens/address_screen.dart';
import 'package:amazon/features/cart/widgets/cart_product.dart';
import 'package:amazon/features/cart/widgets/cart_subtotal.dart';
import 'package:amazon/features/home/widgets/address_box.dart';
import 'package:amazon/features/search/screens/search_screen.dart';
import 'package:amazon/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  navigateToAddress(int total) {
    Navigator.pushNamed(
      context,
      AddressScreen.routeName,
      arguments: total.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          // I use flexible space to add liner-gradient color to appbar
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    elevation: 1,
                    borderRadius: BorderRadius.circular(7),
                    child: TextFormField(
                      onFieldSubmitted: (query) =>
                          navigateToSearchScreen(query),
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(
                              Icons.search,
                              size: 23,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                        ),
                        hintText: "Search SmartShop.in",
                        hintStyle: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(Icons.mic, size: 25, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          AddressBox(),
          CartSubtotal(),
          Padding(
            padding: EdgeInsets.all(10),
            child: CustomButton(
              text: 'Proceed to Buy (${user.cart.length} items)',
              color: Colors.yellow[700],
              textColor: Colors.black,
              onTap: () => navigateToAddress(sum),
            ),
          ),
          SizedBox(height: 15),
          Container(color: Colors.black12.withAlpha(15), height: 1),
          SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: user.cart.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: CartProduct(index: index, context: context),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
