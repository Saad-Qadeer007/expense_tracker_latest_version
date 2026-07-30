import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../Provider/Expense_Provider.dart';

class SettingsSubheadingCards extends StatefulWidget {
  String SubHeadingTitle;
  FaIconData Icon;

  SettingsSubheadingCards({
    super.key,
    required this.SubHeadingTitle,
    required this.Icon,
  });

  @override
  State<SettingsSubheadingCards> createState() =>
      _SettingsSubheadingCardsState();
}

class _SettingsSubheadingCardsState extends State<SettingsSubheadingCards> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 10.0, vertical: 15),
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.grey.shade200),
        child: Row(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FaIcon(widget.Icon),
            Text(
              widget.SubHeadingTitle,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight(600)),
            ),
          ],
        ),
      ),
      onTap: () {
        widget.SubHeadingTitle.toLowerCase() == "reset data"
            ? showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Reset App"),
                  content: Text("Are you sure you want to reset the app?"),
                  actions: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(8),
                        ),
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text("Cancel"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(8),
                        ),
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () => {
                        context.read<ExpenseProvider>().resetApp(),
                        Navigator.of(context).pop(),
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            duration: Duration(seconds: 1),
                            backgroundColor: Colors.red,
                            content: Text(
                              "App Reset Successfully",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      },
                      child: Text("Reset"),
                    ),
                  ],
                ),
              )
            : null;
        print("Ended");
      },
    );
  }
}
