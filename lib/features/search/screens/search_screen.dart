import 'package:amazon/common/widgets/loader.dart';
import 'package:amazon/constraints/global_variables.dart';
import 'package:amazon/features/product_details/screens/product_details_screen.dart';
import 'package:amazon/features/search/services/search_services.dart';
import 'package:amazon/features/search/widget/search_product.dart';
import 'package:amazon/features/home/widgets/address_box.dart';
import 'package:amazon/models/product.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  final String searchQuery;
  const SearchScreen({super.key, required this.searchQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchServices searchServices = SearchServices();
  List<Product>? searchProducts;
  @override
  void initState() {
    super.initState();
    getSearchProducts();
  }

  getSearchProducts() async {
    searchProducts = await searchServices.getSearchProducts(
      context: context,
      searchQuery: widget.searchQuery,
    );
    setState(() {});
  }

  navigateToSearchScreen(String searchQuery) {
    Navigator.pushNamed(
      context,
      SearchScreen.routeName,
      arguments: searchQuery,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios),
          ),
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
      body: searchProducts == null
          ? const Loader()
          : searchProducts!.isEmpty
          ? Center(child: Text('No Results Found', style: TextStyle(color: Colors.black26, fontWeight: FontWeight.bold),),)
          : Column(
              children: [
                AddressBox(),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: searchProducts!.length,
                    itemBuilder: (context, index) {
                      Product product = searchProducts![index];
                      return GestureDetector(
                        onTap: () => Navigator.pushNamed(
                          context,
                          ProductDetailsScreen.routeName,
                          arguments: product,
                        ),
                        child: SearchProduct(product: product),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
