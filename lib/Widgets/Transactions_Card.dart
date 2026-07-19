import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Ultilities/App_Colors.dart';

class TransactionsCard extends StatefulWidget {
  String? expenseTitle;
  String? catagoryTitle;
  double? expenseAmount;
  DateTime? expenseDate;

  TransactionsCard({
    super.key,
    this.expenseTitle,
    this.catagoryTitle,
    this.expenseAmount,
    this.expenseDate,
  });

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
              backgroundColor: Color(0xFFD6A2E8),
              radius: 30,
              child: widget.catagoryTitle?.toLowerCase() == "food"
                  ? FaIcon(FontAwesomeIcons.burger, color: Colors.white)
                  : widget.catagoryTitle?.toLowerCase() == "shopping"
                  ? FaIcon(FontAwesomeIcons.shoppingBag, color: Colors.white)
                  : widget.catagoryTitle?.toLowerCase() == "travel"
                  ? FaIcon(FontAwesomeIcons.plane, color: Colors.white)
                  : widget.catagoryTitle?.toLowerCase() == "Entertainment"
                  ? FaIcon(FontAwesomeIcons.ticket, color: Colors.white)
                  : FaIcon(FontAwesomeIcons.mobileRetro, color: Colors.white),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.expenseTitle != null ?
                  "${widget.expenseTitle?[0].toUpperCase()}${widget.expenseTitle?.substring(1)}" : "Null",
                ),
                SizedBox(height: 5),
                Text(
                  "${widget.catagoryTitle}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                widget.expenseDate != null ?
                Text(
                  "${widget.expenseDate!.day} ${widget.expenseDate!.month}, ${widget.expenseDate!.year}",
                ) : Container(),
              ],
            ),
            Spacer(),
            Text(
              widget.expenseAmount != null ?
              "\$${widget.expenseAmount!.toStringAsFixed(2)}" : "Null",
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
