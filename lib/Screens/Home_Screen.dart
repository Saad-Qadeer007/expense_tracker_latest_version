import 'package:expense_tracker_latest_version/Widgets/Icome_Expense_Card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Ultilities/App_Colors.dart';
import '../Ultilities/App_Themes.dart';
import '../Widgets/Show_Balance_Card.dart';
import '../Widgets/Transactions_Card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
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
                      child: IncomeExpenseCard(title: "Income", amount: 1000),
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
                    TransactionsCard(),
                    SizedBox(height: 5),
                    TransactionsCard(),
                    SizedBox(height: 5),
                    TransactionsCard(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
