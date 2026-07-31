import 'package:expense_tracker_latest_version/Provider/Expense_Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      color: Theme.of(context).cardColor,
      child: Consumer<ExpenseProvider>(
        builder: (context, expenseProvider, child) {
          return Padding(
            padding: EdgeInsetsGeometry.all(15),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Balance",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "\$${expenseProvider.Balance.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Icon(Icons.monetization_on, size: 40),
              ],
            ),
          );
        },
      ),
    );
  }
}
