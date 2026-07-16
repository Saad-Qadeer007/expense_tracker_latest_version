import 'package:flutter/material.dart';

import '../Ultilities/App_Colors.dart';
import '../Ultilities/App_Themes.dart';

class ShowBalanceCard extends StatefulWidget {
  const ShowBalanceCard({super.key});

  @override
  State<ShowBalanceCard> createState() => _ShowBalanceCardState();
}

class _ShowBalanceCardState extends State<ShowBalanceCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppThemes().lightTheme.cardColor,
      child: Padding(
        padding: EdgeInsetsGeometry.all(15),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total Balance",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  "\$1000",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            Spacer(),
            Icon(Icons.monetization_on, size: 40),
          ],
        ),
      ),
    );
  }
}
