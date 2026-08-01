import 'package:expense_tracker_latest_version/Screens/Expense_Breakdown_Screen.dart';
import 'package:expense_tracker_latest_version/Widgets/Settings_SubHeading_Cards.dart';
import 'package:expense_tracker_latest_version/Widgets/settings_headings_cards.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../Provider/Expense_Provider.dart';
import '../Ultilities/App_Colors.dart';
import 'Home_Screen.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ExpenseProvider>().blockShowBreakDownCatgoryCards();
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
          body: provider.selctedBottomNavigationIndex == 3
              ? SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // AppBar for Settings Screen
                        Container(
                          padding: EdgeInsetsGeometry.all(15.0),
                          width: double.infinity,
                          decoration: BoxDecoration(color: provider.isDarkMode ? Colors.black : AppColors.primary),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    "Settings",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  FaIcon(
                                    FontAwesomeIcons.clockRotateLeft,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              //   Container for handling the user profile
                              Row(
                                spacing: 20,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.user,
                                    color: Colors.white,
                                    size: 70,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Saad Qadeer",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        "Track your expenses smarter",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        //   Container for displaying different options
                        //   Container for Showing Appearance Settings
                        SettingsHeadingsCard(HeadingTitle: "Preferences"),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SettingsSubheadingCards(
                                SubHeadingTitle: provider.isDarkMode
                                    ? "Dark Theme"
                                    : "Light Theme",
                                Icon: provider.isDarkMode
                                    ? FontAwesomeIcons.moon
                                    : FontAwesomeIcons.sun,
                              ),
                              SettingsSubheadingCards(
                                SubHeadingTitle: "Currency",
                                Icon: FontAwesomeIcons.moneyBill,
                              ),
                            ],
                          ),
                        ),
                        //   Container for Showing Data Settings
                        SettingsHeadingsCard(HeadingTitle: "Data"),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SettingsSubheadingCards(
                                SubHeadingTitle: "Export Data",
                                Icon: FontAwesomeIcons.arrowDown,
                              ),
                              SettingsSubheadingCards(
                                SubHeadingTitle: "Reset Data",
                                Icon: FontAwesomeIcons.trash,
                              ),
                            ],
                          ),
                        ),
                        //   Container for Showing Data Settings
                        SettingsHeadingsCard(HeadingTitle: "About"),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SettingsSubheadingCards(
                                SubHeadingTitle: "Version 1.0.0",
                                Icon: FontAwesomeIcons.info,
                              ),
                              SettingsSubheadingCards(
                                SubHeadingTitle: "Terms & Conditions",
                                Icon: FontAwesomeIcons.fileLines,
                              ),
                              SettingsSubheadingCards(
                                SubHeadingTitle: "Privacy Policy",
                                Icon: FontAwesomeIcons.shield,
                              ),
                              SettingsSubheadingCards(
                                SubHeadingTitle: "Contact Us",
                                Icon: FontAwesomeIcons.phone,
                              ),
                              SettingsSubheadingCards(
                                SubHeadingTitle: "Rate App",
                                Icon: FontAwesomeIcons.star,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : provider.selctedBottomNavigationIndex == 0
              ? HomeScreen()
              : provider.selctedBottomNavigationIndex == 1
              ? BreakDownScreen()
              : Container(),
        );
      },
    );
  }
}
