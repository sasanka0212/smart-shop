import 'package:amazon/constraints/global_variables.dart';
import 'package:amazon/features/home/screens/category_deals_screen.dart';
import 'package:flutter/material.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({super.key});

  void navigateToCategory(BuildContext context, String category) {
    Navigator.pushNamed(
      context,
      CategoryDealsScreen.routeName,
      arguments: category,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: GlobalVariables.categoryImages.length,
        itemExtent: 75,
        itemBuilder: (context, index) {
          final category = GlobalVariables.categoryImages[index];
          return GestureDetector(
            onTap: () => navigateToCategory(
              context,
              GlobalVariables.categoryImages[index]['title']!,
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      category['image']!,
                      fit: BoxFit.cover,
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
                Text(
                  category['title']!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
