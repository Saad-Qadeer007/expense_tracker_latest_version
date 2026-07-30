import 'package:expense_tracker_latest_version/Provider/Expense_Provider.dart';
import 'package:expense_tracker_latest_version/Screens/Home_Screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../Ultilities/App_Colors.dart';
import '../Widgets/BreakDown_Chips_By_Catagory.dart';
import '../Widgets/ExpenseBreakDown_Chart.dart';

class BreakDownScreen extends StatefulWidget {
  const BreakDownScreen({super.key});

  @override
  State<BreakDownScreen> createState() => _BreakDownScreenState();
}

class _BreakDownScreenState extends State<BreakDownScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(
      builder: (context, provider, child) {
        return provider.selctedBottomNavigationIndex == 1
            ? Scaffold(
                bottomNavigationBar: SafeArea(
                  child: BottomNavigationBar(
                    currentIndex: provider.selctedBottomNavigationIndex,
                    onTap: (index) {
                      context.read<ExpenseProvider>().calculateTotal();
                      setState(() {
                        print(index);
                        provider.selctedBottomNavigationIndex = index;
                      });
                    },
                    type: BottomNavigationBarType.fixed,
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: "Home",
                      ),
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
                        // AppBar for BreakDown Screen
                        Container(
                          padding: EdgeInsetsGeometry.all(15.0),
                          width: double.infinity,
                          decoration: BoxDecoration(color: AppColors.primary),
                          child: Row(
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
                                "Expense BreakDown",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                              FaIcon(
                                FontAwesomeIcons.history,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        // Container For Hanlding The Date Chips
                        Container(
                          padding: EdgeInsetsGeometry.all(15.0),
                          child: Wrap(
                            spacing: 8,
                            children: provider.DateChips.map((items) {
                              return ActionChip(
                                backgroundColor:
                                    provider.selectedDateFilterForBreakDown ==
                                        items
                                    ? AppColors.primary
                                    : Colors.white,
                                label: Text(
                                  items,
                                  style: TextStyle(
                                    color:
                                        provider.selectedDateFilterForBreakDown ==
                                            items
                                        ? Colors.white
                                        : AppColors.primary,
                                  ),
                                ),
                                onPressed: () {
                                  provider.DateFilterForBreakDown(items);
                                  provider
                                      .calculateTotalForBreakDownAfterFiltering();
                                },
                              );
                            }).toList(),
                          ),
                        ),
                        // Container For Showing The Expense BreakDown using pie chart
                        provider.ExpenseDatefilteredForBreakDown.isEmpty
                            ? Padding(
                                padding: EdgeInsetsGeometry.all(15.0),
                                child: Text("No Expenses Yet"),
                              )
                            : provider.ExpenseDatefilteredForBreakDown.every((
                                item,
                              ) {
                                return item.expenseTitle?.toLowerCase() ==
                                    "income";
                              })
                            ? Padding(
                                padding: EdgeInsetsGeometry.all(15.0),
                                child: Text("No Expense Found"),
                              )
                            : Container(
                                padding: EdgeInsetsGeometry.all(15.0),
                                child: ExpenseBreakDownChart(),
                              ),

                        // Showing Catagories by Percentage
                        Container(
                          padding: EdgeInsetsGeometry.all(15.0),
                          child: Column(
                            children: [
                              Text(
                                "Total Expense : \$${provider.TotalExpense.toStringAsFixed(2)}",
                                style: TextStyle(fontSize: 18),
                              ),
                              Divider(),
                              SizedBox(height: 10),
                              Column(
                                children: provider.ExpenseCatagoryTitle.map((
                                  items,
                                ) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color: items.toLowerCase() == "food"
                                            ? AppColors.primary
                                            : items.toLowerCase() == "shopping"
                                            ? AppColors.secondary
                                            : items.toLowerCase() == "travel"
                                            ? Colors.pinkAccent
                                            : items.toLowerCase() ==
                                                  "entertainment"
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
                                            ? "${provider.FoodPercentage.toStringAsFixed(2)} %"
                                            : items.toLowerCase() == "shopping"
                                            ? "${provider.ShoppingPercentage.toStringAsFixed(2)} %"
                                            : items.toLowerCase() == "travel"
                                            ? "${provider.TravelPercentage.toStringAsFixed(2)} %"
                                            : items.toLowerCase() ==
                                                  "entertainment"
                                            ? "${provider.EntertainmentPercentage.toStringAsFixed(2)} %"
                                            : "${provider.OtherPercentage.toStringAsFixed(2)} %",
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
                        // Container For Showing The Catagory BreakDown
                        Container(
                          padding: EdgeInsetsGeometry.all(15.0),
                          child: GridView.count(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1,
                            children: provider.ExpenseCatagoryTitle.map((item) {
                              return InkWell(
                                onTap: () {
                                  provider.selctedCatagoryForBreakDown(item);
                                },
                                child: BreakdownChipsByCatagory(
                                  CatagoryTitle: item,
                                ),
                              );
                            }).toList(),
                          ),
                        ),

                        //   Tranactions
                        Container(
                          padding: EdgeInsetsGeometry.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Transactions",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Divider(),
                              SizedBox(height: 10),
                              provider.ExpenseBreakDown.isEmpty
                                  ? SizedBox(
                                      height: 200,
                                      child: Center(
                                        child: Text("No Expenses Yet"),
                                      ),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount:
                                          provider.ExpenseBreakDown.length,
                                      itemBuilder: (context, index) {
                                        var expense =
                                            provider.ExpenseBreakDown[index];
                                        return ListTile(
                                          leading: Icon(
                                            Icons.circle,
                                            color:
                                                expense.expenseCategory
                                                        ?.toLowerCase() ==
                                                    "food"
                                                ? AppColors.primary
                                                : expense.expenseCategory
                                                          ?.toLowerCase() ==
                                                      "shopping"
                                                ? AppColors.secondary
                                                : expense.expenseCategory
                                                          ?.toLowerCase() ==
                                                      "travel"
                                                ? Colors.pinkAccent
                                                : expense.expenseCategory
                                                          ?.toLowerCase() ==
                                                      "entertainment"
                                                ? Colors.grey
                                                : Colors.grey.shade300,
                                          ),
                                          title: Text(
                                            expense.expenseTitle![0]
                                                        .toUpperCase() +
                                                    expense.expenseTitle!
                                                        .substring(1) ??
                                                "",
                                          ),
                                          subtitle: Text(
                                            "${expense.expenseDate?.year}/${expense.expenseDate?.month}/${expense.expenseDate?.day}" ??
                                                "",
                                          ),
                                          trailing: Text(
                                            "\$${expense.expenseAmount?.toStringAsFixed(2) ?? ""}",
                                            style: TextStyle(
                                              color:
                                                  expense.expenseCategory
                                                          ?.toLowerCase() ==
                                                      "income"
                                                  ? Colors.green
                                                  : Colors.red,
                                              fontSize: 18,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : HomeScreen();
      },
    );
  }
}
