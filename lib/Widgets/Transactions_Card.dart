import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Ultilities/App_Colors.dart';

class TransactionsCard extends StatefulWidget {
  const TransactionsCard({super.key});

  @override
  State<TransactionsCard> createState() => _TransactionsCardState();
}

class _TransactionsCardState extends State<TransactionsCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.card,
      child: Padding(
        padding: EdgeInsetsGeometry.all(15.0),
        child: Row(
          children: [
            // Logo
            CircleAvatar(
              radius: 30,
              child: FaIcon(FontAwesomeIcons.burger, size: 40),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Burger"),
                SizedBox(height: 5),
                Text(
                  "Food",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text("14 July, 2023"),
              ],
            ),
            Spacer(),
            Text(
              "\$100",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
