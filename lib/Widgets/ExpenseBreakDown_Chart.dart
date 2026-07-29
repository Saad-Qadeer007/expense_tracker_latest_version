import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/Expense_Provider.dart';
import '../Ultilities/App_Colors.dart';

class ExpenseBreakDownChart extends StatefulWidget {
  const ExpenseBreakDownChart({super.key});

  @override
  State<ExpenseBreakDownChart> createState() => _ExpenseBreakDownChartState();
}

class _ExpenseBreakDownChartState extends State<ExpenseBreakDownChart> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(
      builder: (context, provider, child) {
        // Build your chart based on the expense data
        return SizedBox(
          height: 250,
          child: PieChart(
            PieChartData(
              sections: provider.ExpenseCatagoryTitle.map((items) {
                return PieChartSectionData(
                  radius: 50,
                  color: items.toLowerCase() == "food"
                      ? AppColors.primary
                      : items.toLowerCase() == "shopping"
                      ? AppColors.secondary
                      : items.toLowerCase() == "travel"
                      ? Colors.pinkAccent
                      : items.toLowerCase() == "entertainment"
                      ? Colors.grey
                      : Colors.grey.shade300,
                  value: items.toLowerCase() == "food"
                      ? provider.FoodPercentage == 0.0
                            ? null
                            : provider.FoodPercentage
                      : items.toLowerCase() == "shopping"
                      ? provider.ShoppingPercentage == 0.0
                            ? null
                            : provider.ShoppingPercentage
                      : items.toLowerCase() == "travel"
                      ? provider.TravelPercentage == 0.0
                            ? null
                            : provider.TravelPercentage
                      : items.toLowerCase() == "entertainment"
                      ? provider.EntertainmentPercentage == 0.0
                            ? null
                            : provider.EntertainmentPercentage
                      : provider.OtherPercentage == 0.0
                      ? null
                      : provider.OtherPercentage,
                  title: items.toLowerCase() == "food"
                      ? provider.FoodPercentage.toStringAsFixed(2) == 0.00
                            ? null
                            : provider.FoodPercentage.toStringAsFixed(2)
                      : items.toLowerCase() == "shopping"
                      ? provider.ShoppingPercentage.toStringAsFixed(2) == 0.00
                            ? null
                            : provider.ShoppingPercentage.toStringAsFixed(2)
                      : items.toLowerCase() == "travel"
                      ? provider.TravelPercentage.toStringAsFixed(2) == 0.00
                            ? null
                            : provider.TravelPercentage.toStringAsFixed(2)
                      : items.toLowerCase() == "entertainment"
                      ? provider.EntertainmentPercentage.toStringAsFixed(2) ==
                                0.00
                            ? null
                            : provider.EntertainmentPercentage.toStringAsFixed(
                                2,
                              )
                      : provider.OtherPercentage.toStringAsFixed(2) == 0.00
                      ? null
                      : provider.OtherPercentage.toStringAsFixed(2),
                  titleStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
