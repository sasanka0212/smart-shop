import 'dart:convert';

import 'package:amazon/constraints/error_handling.dart';
import 'package:amazon/constraints/global_variables.dart';
import 'package:amazon/constraints/utils.dart';
import 'package:amazon/models/product.dart';
import 'package:amazon/models/user.dart';
import 'package:amazon/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProductDetailsServices {
  void rateProduct({
    required BuildContext context,
    required Product product,
    required double rating,
  }) async {
    final provider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/rate-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': provider.user.token,
        },
        body: jsonEncode({'id': product.id!, 'rating': rating}),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnakBar(context, 'Thank you for your rating!');
        },
      );
    } catch (e) {
      showSnakBar(context, e.toString());
    }
  }

  void addToCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/add-to-cart'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({'id': product.id!}),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user = userProvider.user.copyWith(
            cart: jsonDecode(res.body)['cart'],
          );
          userProvider.setUserFromModel(user);
          showSnakBar(context, 'Product added successfully');
        },
      );
    } catch (e) {
      showSnakBar(context, e.toString());
    }
  }
}
