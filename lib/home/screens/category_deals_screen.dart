import 'package:amazon/common/widgets/loader.dart';
import 'package:amazon/constraints/global_variables.dart';
import 'package:amazon/home/services/home_services.dart';
import 'package:amazon/models/product.dart';
import 'package:flutter/material.dart';

class CategoryDealsScreen extends StatefulWidget {
  final String category;
  const CategoryDealsScreen({super.key, required this.category});
  static const String routeName = '/category-deals';

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Product>? products;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async {
    products = await homeServices.getCategoryProducts(
      context: context,
      category: widget.category,
    );
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          // I use flexible space to add liner-gradient color to appbar
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Text(widget.category, style: TextStyle(color: Colors.black)),
        ),
      ),
      body: products == null
          ? const Loader()
          : Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Keep shoping for ${widget.category}',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 170,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 1.4,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: products!.length,
                    padding: EdgeInsets.only(left: 15),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final product = products![index];
                      return Column(
                        children: [
                          SizedBox(
                            height: 130,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black12,
                                  width: 0.5,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Image.network(product.images[0]),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 5, left: 0, right: 15),
                            alignment: Alignment.topLeft,
                            child: Text(product.name, maxLines: 1, overflow: TextOverflow.ellipsis,),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
