import 'package:amazon/features/accounts/widgets/account_button.dart';
import 'package:amazon/features/auth/services/auth_services.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(text: "Your Orders", onPressed: () {}),
            AccountButton(text: "Turn Seller", onPressed: () {}),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            AccountButton(
              text: "Log Out", 
              onPressed: () => AuthServices().logOut(context),
            ),
            AccountButton(text: "Your Wish List", onPressed: () {}),
          ],
        ),
      ],
    );
  }
}
