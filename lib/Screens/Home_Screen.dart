import 'package:expense_tracker_latest_version/Provider/Expense_Provider.dart';
import 'package:expense_tracker_latest_version/Screens/Expense_Breakdown_Screen.dart';
import 'package:expense_tracker_latest_version/Screens/Monthly_Report_Analysis_Screen.dart';
import 'package:expense_tracker_latest_version/Screens/Settings.dart';
import 'package:expense_tracker_latest_version/Widgets/Icome_Expense_Card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../Ultilities/App_Colors.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ExpenseProvider>().LoadSaveExpense();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ExpenseProvider>().calculateTotal();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(
      builder: (context, provider, child) {
        return provider.selctedBottomNavigationIndex == 0
            ? GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Scaffold(
                  bottomNavigationBar: SafeArea(
                    child: BottomNavigationBar(
                      currentIndex: provider.selctedBottomNavigationIndex,
                      onTap: (index) {
                        context.read<ExpenseProvider>().calculateTotal();
                        context.read<ExpenseProvider>().changeBottomNavigation(
                          index,
                        );
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
                  floatingActionButton: FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddExpenseScreen(
                            gettedExpenseAmountFromEditScreen: 0.00,
                            gettedExpenseTitleFromEditScreen: '',
                            gettedExpenseCatagoryFromEditScreen: '',
                            gettedExpenseDateFromEditScreen: null,
                            index: 0,
                          ),
                        ),
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
                              color: provider.isDarkMode
                                  ? Colors.black
                                  : AppColors.primary,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(130),
                                bottomRight: Radius.circular(130),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.menu,
                                      size: 28,
                                      color: Colors.white,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        context
                                            .read<ExpenseProvider>()
                                            .resetApp();
                                      },
                                      child: FaIcon(
                                        FontAwesomeIcons.bell,
                                        size: 28,
                                        color: Colors.white,
                                      ),
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
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: AppColors.darkText,
                                  ),
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
                                  child: IncomeExpenseCard(
                                    title: "Income",
                                    amount: provider.Income,
                                  ),
                                ),
                                Expanded(
                                  child: IncomeExpenseCard(
                                    title: "Expense",
                                    amount: provider.Expense,
                                  ),
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
                                    textInputAction: TextInputAction.done,
                                    onChanged: (value) {
                                      provider.searchExpense(value);
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.search),
                                      labelText: "Seach Expense",
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
                                  child: Tooltip(
                                    message: "Filter By Catagory",
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: Text("Filter By Catagory"),
                                            content: Wrap(
                                              spacing: 8,
                                              runSpacing: 8,
                                              children:
                                                  provider.ExpenseCatagory.map((
                                                    category,
                                                  ) {
                                                    return ActionChip(
                                                      label: Text(category),
                                                      onPressed: () {
                                                        provider
                                                            .filterByCategory(
                                                              category,
                                                            );
                                                        Navigator.pop(context);
                                                      },
                                                    );
                                                  }).toList(),
                                            ),
                                          ),
                                        );
                                      },
                                      child: Icon(
                                        Icons.filter_alt_outlined,
                                        color: Colors.white,
                                      ),
                                    ),
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
                              spacing: 6,
                              children: provider.DateChips.map((chips) {
                                return ActionChip(
                                  backgroundColor:
                                      provider.selectedDateChip == chips
                                      ? AppColors.primary
                                      : Colors.white,
                                  label: Text(
                                    chips,
                                    style: TextStyle(
                                      color: provider.selectedDateChip == chips
                                          ? Colors.white
                                          : AppColors.primary,
                                    ),
                                  ),
                                  onPressed: () {
                                    provider.selectedDateFilter(chips);
                                  },
                                );
                              }).toList(),
                            ),
                          ),

                          /////////////////////////////////////////////////////////////////////////////////////////////////////// Recent Transactions
                          Container(
                            padding: EdgeInsetsGeometry.symmetric(
                              horizontal: 15.0,
                              vertical: 5,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                    final transactions = provider.searchResults;

                                    if (transactions.isEmpty) {
                                      return Padding(
                                        padding: EdgeInsetsGeometry.symmetric(
                                          vertical: 20,
                                          horizontal: 0,
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          child: Center(
                                            child: Text(
                                              provider.expenses.isEmpty
                                                  ? "No Transactions Yet"
                                                  : "No Transactions Found",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey.shade600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    return ListView.builder(
                                      padding: EdgeInsets.only(bottom: 50),
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: transactions.length,
                                      itemBuilder: (context, index) {
                                        final expense = transactions[index];
                                        return TransactionsCard(
                                              Index: index,
                                              expenseTitle:
                                                  expense.expenseTitle,
                                              catagoryTitle:
                                                  expense.expenseCategory,
                                              expenseAmount:
                                                  expense.expenseAmount,
                                              expenseDate: expense.expenseDate,
                                            )
                                            .animate(delay: (index * 50).ms)
                                            .fadeIn(duration: 400.ms)
                                            .slideY(begin: 0.2, end: 0);
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
                ),
              )
            : provider.selctedBottomNavigationIndex == 1
            ? BreakDownScreen()
            : provider.selctedBottomNavigationIndex == 3
            ? Settings()
            : MonthlyReportAnalysisScreen();
      },
    );
  }
}
