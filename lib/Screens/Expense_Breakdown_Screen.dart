import 'package:expense_tracker_latest_version/Provider/Expense_Provider.dart';
import 'package:expense_tracker_latest_version/Screens/Home_Screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../Ultilities/App_Colors.dart';
import '../Widgets/BreakDown_Chips_By_Catagory.dart';

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
                            children: provider.DateChips.map((item) {
                              return ActionChip(
                                backgroundColor:
                                    provider.selectedDateChipForBreakDown ==
                                        item
                                    ? AppColors.primary
                                    : Colors.white,
                                label: Text(
                                  item,
                                  style: TextStyle(
                                    color:
                                        provider.selectedDateChipForBreakDown ==
                                            item
                                        ? Colors.white
                                        : AppColors.primary,
                                  ),
                                ),
                                onPressed: () {
                                  provider.selctedDateChipForBreakDown(item);
                                },
                              );
                            }).toList(),
                          ),
                        ),
                        // Container For Showing The Expense BreakDown
                        Container(),
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
                              return BreakdownChipsByCatagory(
                                CatagoryTitle: item,
                              );
                            }).toList(),
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
