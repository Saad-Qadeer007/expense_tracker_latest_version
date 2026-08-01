import "package:expense_tracker_latest_version/Provider/Expense_Provider.dart";
import "package:expense_tracker_latest_version/Widgets/Icome_Expense_Card.dart";
import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:provider/provider.dart";
import 'package:intl/intl.dart';
import "../Ultilities/App_Colors.dart";

class MonthlyReportAnalysisScreen extends StatefulWidget {
  const MonthlyReportAnalysisScreen({super.key});

  @override
  State<MonthlyReportAnalysisScreen> createState() =>
      _MonthlyReportAnalysisScreenState();
}

class _MonthlyReportAnalysisScreenState
    extends State<MonthlyReportAnalysisScreen> {
  String selectedMonthNumber = DateFormat('MM').format(DateTime.now());
  String selectedMonth = DateFormat('MMMM').format(DateTime.now());
  String selectedYear = DateFormat('yyyy').format(DateTime.now());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ExpenseProvider>().GetExpenseByMonthAndYear(
        selectedMonthNumber,
        selectedYear,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          bottomNavigationBar: SafeArea(
            child: BottomNavigationBar(
              currentIndex: provider.selctedBottomNavigationIndex,
              onTap: (index) {
                context.read<ExpenseProvider>().calculateTotal();
                setState(() {
                  provider.selctedBottomNavigationIndex = index;
                });
              },
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                  icon: Icon(Icons.pie_chart),
                  label: "Breakdown",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.report),
                  label: "Report",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: "Settings",
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // AppBar for Monthly Report Screen
                  Container(
                    padding: EdgeInsetsGeometry.all(15.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: provider.isDarkMode
                          ? Colors.black
                          : AppColors.primary,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: FaIcon(
                                FontAwesomeIcons.arrowLeft,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Monthly Report",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                provider.MonthGetter = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2030),
                                );

                                if (provider.MonthGetter != null) {
                                  setState(() {
                                    selectedMonth = DateFormat(
                                      'MMMM',
                                    ).format(provider.MonthGetter!);
                                    selectedYear = DateFormat(
                                      'yyyy',
                                    ).format(provider.MonthGetter!);
                                    selectedMonthNumber = DateFormat(
                                      'MM',
                                    ).format(provider.MonthGetter!);
                                  });
                                  provider.GetExpenseByMonthAndYear(
                                    selectedMonthNumber,
                                    selectedYear,
                                  );
                                }
                              },
                              child: FaIcon(
                                FontAwesomeIcons.calendar,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Text(
                            "$selectedMonth $selectedYear",
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight(500),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //   Container for Showing this month break down
                  Container(
                    padding: EdgeInsetsGeometry.all(15.0),
                    child: Wrap(
                      children: [
                        IncomeExpenseCard(
                          title: "Income",
                          amount: provider.IncomeByMonth,
                        ),
                        SizedBox(width: 10),
                        IncomeExpenseCard(
                          title: "Expenses",
                          amount: provider.ExpenseByMonth,
                        ),
                        SizedBox(width: 10),
                        IncomeExpenseCard(
                          title: "Saving",
                          amount: provider.SavingByMonth,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  //   Container for Transactions Catagory with percentage
                  Container(
                    padding: EdgeInsetsGeometry.all(15.0),
                    child: Column(
                      children: [
                        Text(
                          "Total Expense : \$${provider.ExpenseByMonth.toStringAsFixed(2)}",
                          style: TextStyle(fontSize: 18),
                        ),
                        Divider(),
                        SizedBox(height: 10),
                        Column(
                          children: provider.ExpenseCatagoryTitle.map((items) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: items.toLowerCase() == "food"
                                      ? AppColors.primary
                                      : items.toLowerCase() == "shopping"
                                      ? AppColors.secondary
                                      : items.toLowerCase() == "travel"
                                      ? Colors.pinkAccent
                                      : items.toLowerCase() == "entertainment"
                                      ? Colors.grey
                                      : Colors.grey.shade300,
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    "${items[0].toUpperCase()}${items.substring(1)}",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  items.toLowerCase() == "food"
                                      ? "${provider.FoodPercentageByMonth.toStringAsFixed(2)} %"
                                      : items.toLowerCase() == "shopping"
                                      ? "${provider.ShoppingPercentageByMonth.toStringAsFixed(2)} %"
                                      : items.toLowerCase() == "travel"
                                      ? "${provider.TravelPercentageByMonth.toStringAsFixed(2)} %"
                                      : items.toLowerCase() == "entertainment"
                                      ? "${provider.EntertainmentPercentageByMonth.toStringAsFixed(2)} %"
                                      : "${provider.OtherPercentageByMonth.toStringAsFixed(2)} %",
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(width: 5),
                              ],
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
