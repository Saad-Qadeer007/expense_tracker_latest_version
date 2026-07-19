import 'package:expense_tracker_latest_version/Provider/Expense_Provider.dart';
import 'package:expense_tracker_latest_version/Widgets/Icome_Expense_Card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../Ultilities/App_Colors.dart';
import '../Ultilities/App_Themes.dart';
import '../Widgets/Show_Balance_Card.dart';
import '../Widgets/Transactions_Card.dart';
import 'Add_Expense_Screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return
      Consumer<ExpenseProvider>(builder: (context, provider, child) {
        return Scaffold(
          bottomNavigationBar: SafeArea(
            child: BottomNavigationBar(
              currentIndex: 0,
              onTap: (index) {},
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                  icon: Icon(Icons.pie_chart),
                  label: "Breakdown",
                ),
                BottomNavigationBarItem(icon: Icon(Icons.report), label: "Report"),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: "Settings",
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddExpenseScreen()),
              );
            },
            label: Text("Add Expense"),
            icon: Icon(Icons.add),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsetsGeometry.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(130),
                        bottomRight: Radius.circular(130),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.menu, size: 28, color: Colors.white),
                            FaIcon(
                              FontAwesomeIcons.bell,
                              size: 28,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              "Welcome, User!",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.darkText,
                              ),
                            ),
                            SizedBox(width: 10),
                            FaIcon(
                              FontAwesomeIcons.user,
                              size: 20,
                              color: AppColors.darkText,
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Expense Tracker",
                          style: TextStyle(fontSize: 18, color: AppColors.darkText),
                        ),
                        SizedBox(height: 20),
                        ShowBalanceCard(),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsetsGeometry.all(15),
                    child: Row(
                      children: [
                        Expanded(
                          child: IncomeExpenseCard(title: "Income", amount: provider.Income),
                        ),
                        Expanded(
                          child: IncomeExpenseCard(title: "Expense", amount: 500),
                        ),
                      ],
                    ),
                  ),
                  /////////////////////////////////////////////////////////////////////////////////////////////////////// Search bar
                  Container(
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: 15.0,
                      vertical: 5,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              labelText: "Enter description",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.filter_alt_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  /////////////////////////////////////////////////////////////////////////////////////////////////////// Filter Chips
                  Container(
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: 15.0,
                      vertical: 5,
                    ),
                    child: Wrap(
                      children: [
                        Chip(
                          backgroundColor: AppColors.primary,
                          label: Text("All", style: TextStyle(color: Colors.white)),
                        ),
                        SizedBox(width: 10),
                        Chip(label: Text("Today")),
                        SizedBox(width: 10),
                        Chip(label: Text("Week")),
                        SizedBox(width: 10),
                        Chip(label: Text("Month")),
                        SizedBox(width: 10),
                        Chip(label: Text("Year")),
                      ],
                    ),
                  ),

                  /////////////////////////////////////////////////////////////////////////////////////////////////////// Recent Transactions
                  Container(
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: 15.0,
                      vertical: 5,
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Recent Transactions",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 10),
                        Consumer<ExpenseProvider>(
                          builder: (context, provider, child) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: provider.expenses.length,
                              itemBuilder: (context, index) {
                                return TransactionsCard(
                                  expenseTitle:
                                  provider.expenses[index].expenseTitle,
                                  catagoryTitle:
                                  provider.expenses[index].expenseCategory,
                                  expenseAmount:
                                  provider.expenses[index].expenseAmount,
                                  expenseDate: provider.expenses[index].expenseDate,
                                );
                              },
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
        );
      });

  }
}
