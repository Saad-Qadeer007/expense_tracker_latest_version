import 'package:expense_tracker_latest_version/Ultilities/App_Colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IncomeExpenseCard extends StatefulWidget {
  final String title;
  final double amount;

  const IncomeExpenseCard({
    super.key,
    required this.title,
    required this.amount,
  });

  @override
  State<IncomeExpenseCard> createState() => _IncomeExpenseCardState();
}

class _IncomeExpenseCardState extends State<IncomeExpenseCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.card,
      child: Padding(
        padding: EdgeInsetsGeometry.all(15.0),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  "Rs ${widget.amount.toString()}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            SizedBox(width: 20),
            widget.title == "Income"
                ? FaIcon(FontAwesomeIcons.arrowUp, color: Colors.green)
                : FaIcon(FontAwesomeIcons.arrowDown, color: Colors.red),
          ],
        ),
      ),
    );
  }
}
