import 'package:amazon/common/widgets/loader.dart';
import 'package:amazon/features/home/services/home_services.dart';
import 'package:amazon/features/product_details/screens/product_details_screen.dart';
import 'package:amazon/models/product.dart';
import 'package:flutter/material.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  Product? product;
  final homeServices = HomeServices();
  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }

  void fetchDealOfDay() async {
    product = await homeServices.getDealOfDay(context: context);
    setState(() {});
  }

  void navigateToProduct() {
    Navigator.pushNamed(context, ProductDetailsScreen.routeName, arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return product == null 
      ? const Loader() 
      : product!.name.isEmpty  
        ? const SizedBox() 
        : GestureDetector(
          onTap: navigateToProduct,
          child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(color: Colors.blueAccent),
              child: Center(child: const Text("Deal of the day", 
                style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Image.network(
                product!.images[0],
                height: 235,
                fit: BoxFit.fitHeight,
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(top: 5, left: 10),
              child: Text(
                "Rs ${product!.price}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(top: 5, left: 10, bottom: 5),
              child: Text(
                product!.name,
                style: TextStyle(fontSize: 14),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: product!.images.map((image) => 
                  Image.network(
                    image,
                    fit: BoxFit.fitWidth,
                    width: 100,
                    height: 100,
                  ),
                ).toList(),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.symmetric(vertical: 15).copyWith(left: 15),
              child: Text(
                "See All Deals",
                style: TextStyle(color: Colors.cyan[800]),
              ),
            ),
          ],
                ),
        );
  }
}
