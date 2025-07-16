import 'dart:convert';

import 'package:amazon/constraints/error_handling.dart';
import 'package:amazon/constraints/global_variables.dart';
import 'package:amazon/constraints/utils.dart';
import 'package:amazon/models/product.dart';
import 'package:amazon/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomeServices {
  Future<List<Product>> getCategoryProducts({
    required BuildContext context,
    required String category,
  }) async {
    // get a provider to access the token
    final provider = Provider.of<UserProvider>(context, listen: false);
    List<Product> products = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/products?category=$category'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': provider.user.token,
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            // convert json docs to product class
            products.add(Product.fromJson(jsonEncode(jsonDecode(res.body)[i])));
          }
        },
      );
    } catch (e) {
      showSnakBar(context, e.toString());
    }
    return products;
  }

  Future<Product> getDealOfDay({required BuildContext context}) async {
    // get a provider to access the token
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Product product = Product(
      name: '', description: '', price: 0, quantity: 0, images: [], category: '');
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/deal-of-day'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          product = Product.fromJson(res.body);
        },
      );
    } catch (e) {
      showSnakBar(context, e.toString());
    }
    return product;
  }
}
