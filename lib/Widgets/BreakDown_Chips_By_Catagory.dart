import 'package:expense_tracker_latest_version/Provider/Expense_Provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../Ultilities/App_Colors.dart';

class BreakdownChipsByCatagory extends StatefulWidget {
  String CatagoryTitle;

  BreakdownChipsByCatagory({super.key, required this.CatagoryTitle});

  @override
  State<BreakdownChipsByCatagory> createState() =>
      _BreakdownChipsByCatagoryState();
}

class _BreakdownChipsByCatagoryState extends State<BreakdownChipsByCatagory> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(
      builder: (context, provider, child) {
        return Card(
          color: Theme.of(context).cardColor,
          child: Container(
            decoration: BoxDecoration(
              color: provider.isDarkMode ? Colors.grey.shade900 : AppColors.primary,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsetsGeometry.symmetric(horizontal: 0, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                widget.CatagoryTitle.toLowerCase() == "food"
                    ? CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 35,
                        child: FaIcon(
                          FontAwesomeIcons.burger,
                          color: AppColors.secondary,
                          size: 35,
                        ),
                      )
                    : widget.CatagoryTitle.toLowerCase() == "shopping"
                    ? CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 35,
                        child: FaIcon(
                          FontAwesomeIcons.bagShopping,
                          color: AppColors.secondary,
                          size: 35,
                        ),
                      )
                    : widget.CatagoryTitle.toLowerCase() == "travel"
                    ? CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 35,
                        child: FaIcon(
                          FontAwesomeIcons.plane,
                          color: AppColors.secondary,
                          size: 35,
                        ),
                      )
                    : widget.CatagoryTitle.toLowerCase() == "entertainment"
                    ? CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 35,
                        child: FaIcon(
                          FontAwesomeIcons.ticket,
                          color: AppColors.secondary,
                          size: 35,
                        ),
                      )
                    : CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 35,
                        child: FaIcon(
                          FontAwesomeIcons.mobileRetro,
                          color: AppColors.secondary,
                          size: 35,
                        ),
                      ),
                SizedBox(height: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.CatagoryTitle[0].toUpperCase() + widget.CatagoryTitle.substring(1),
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    SizedBox(width: 10),
                    Text(
                      widget.CatagoryTitle.toLowerCase() == "food"
                          ? "\$ ${provider.Food.toStringAsFixed(2)}"
                          : widget.CatagoryTitle.toLowerCase() == "shopping"
                          ? "\$ ${provider.Shopping.toStringAsFixed(2)}"
                          : widget.CatagoryTitle.toLowerCase() == "travel"
                          ? "\$ ${provider.Travel.toStringAsFixed(2)}"
                          : widget.CatagoryTitle.toLowerCase() ==
                                "entertainment"
                          ? "\$ ${provider.Entertainment.toStringAsFixed(2)}"
                          : "\$ ${provider.Other.toStringAsFixed(2)}",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
