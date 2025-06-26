import 'package:flutter/material.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 10, top: 15),
          child: const Text("Deal of the day",
            style: TextStyle(fontSize: 20),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Image.network("https://imgs.search.brave.com/lpM7ccqb2CwmljqU1_CtZvDOpeA0H1LixJAdk_n05o8/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/YXBwbGUuY29tL25l/d3Nyb29tL2ltYWdl/cy8yMDI1LzAzL2Fw/cGxlLWludHJvZHVj/ZXMtdGhlLW5ldy1t/YWNib29rLWFpci13/aXRoLXRoZS1tNC1j/aGlwLWFuZC1hLXNr/eS1ibHVlLWNvbG9y/L2FydGljbGUvQXBw/bGUtTWFjQm9vay1B/aXItaGVyby0yNTAz/MDVfYmlnLmpwZy5s/YXJnZS5qcGc",
            height: 235,
            fit: BoxFit.fitHeight,
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(top: 5, left: 10),
          child: Text("Rs 83,999",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(top: 5, left: 10, bottom: 5),
          child: Text("MacBook Air M3 2024 Edition",
            style: TextStyle(
              fontSize: 14,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network('https://www.apple.com/newsroom/images/product/mac/standard/Apple_MacBook-Pro_14-16-inch_10182021_big.jpg.large.jpg', fit: BoxFit.fitWidth, width: 100, height: 100,),
              Image.network('https://www.apple.com/newsroom/images/product/mac/standard/Apple_MacBook-Pro_14-16-inch_10182021_big.jpg.large.jpg', fit: BoxFit.fitWidth, width: 100, height: 100,),
              Image.network('https://www.apple.com/newsroom/images/product/mac/standard/Apple_MacBook-Pro_14-16-inch_10182021_big.jpg.large.jpg', fit: BoxFit.fitWidth, width: 100, height: 100,),
              Image.network('https://www.apple.com/newsroom/images/product/mac/standard/Apple_MacBook-Pro_14-16-inch_10182021_big.jpg.large.jpg', fit: BoxFit.fitWidth, width: 100, height: 100,),
            ],
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.symmetric(vertical: 15).copyWith(left: 15),
          child: Text("See All Deals",
            style: TextStyle(
              color: Colors.cyan[800],
            ),
          ),
        ),
      ],
    );
  }
}