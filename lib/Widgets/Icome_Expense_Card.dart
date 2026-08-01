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
      color: Theme.of(context).cardColor,
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
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 400),
                  child: Text(
                    "\$${widget.amount.toStringAsFixed(2)}",
                    key: ValueKey(widget.amount),
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Spacer(),
            widget.title == "Income"
                ? FaIcon(FontAwesomeIcons.arrowUp, color: Colors.green)
                : widget.title.toLowerCase() == "expense"
                ? FaIcon(FontAwesomeIcons.arrowDown, color: Colors.red)
                : FaIcon(FontAwesomeIcons.wallet, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}
