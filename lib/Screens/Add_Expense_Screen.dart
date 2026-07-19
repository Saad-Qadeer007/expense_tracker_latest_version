import 'package:expense_tracker_latest_version/Widgets/Catagory_Chip.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../Model/Expense_Model.dart';
import '../Provider/Expense_Provider.dart';
import '../Ultilities/App_Colors.dart';

class AddExpenseScreen extends StatefulWidget {
  AddExpenseScreen({super.key});

  bool isShowCatagory = false;
  TextEditingController dateController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController catagoryController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  @override
  DateTime? pickedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        pickedDate = picked;
        widget.dateController.text =
            "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  String buttonTracker = "expense";

  void changeButtonTracker(String ButtonTracker) {
    setState(() {
      buttonTracker = ButtonTracker;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///////////////////////////////////////////////////////////  Appbar for add expense screen
              Container(
                decoration: BoxDecoration(color: AppColors.primary),
                padding: EdgeInsetsGeometry.all(15.0),
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
                          "Add Expense",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        FaIcon(FontAwesomeIcons.history, color: Colors.white),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              changeButtonTracker("expense");
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(10),
                              ),
                            ),
                            label: Text("Expense"),
                            icon: FaIcon(
                              FontAwesomeIcons.arrowDown,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              changeButtonTracker("income");
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(10),
                              ),
                            ),
                            label: Text("Income"),
                            icon: FaIcon(
                              FontAwesomeIcons.arrowUp,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              ////////////////////////////////////////////////////////////////// Form for getting add expense data
              buttonTracker.toLowerCase() == "expense"
                  ? Container(
                      padding: EdgeInsetsGeometry.all(15.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //// TextField for expense title
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Title :",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextField(
                                  controller: widget.titleController,
                                  decoration: InputDecoration(
                                    hintText: "e.g Burger",
                                    border: OutlineInputBorder(),
                                    suffixIcon: Icon(Icons.edit),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          //// TextField for expense amount
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Amount :",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextField(
                                  controller: widget.amountController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: "Rs 0.00",
                                    border: OutlineInputBorder(),
                                    suffixIcon: Icon(Icons.money),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          //// TextField for expense catagory
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Catagory :",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      widget.isShowCatagory =
                                          !widget.isShowCatagory;
                                    });
                                  },
                                  child: TextField(
                                    enabled: false,
                                    decoration: InputDecoration(
                                      hintText: "Select Catagory",
                                      border: OutlineInputBorder(),
                                      suffixIcon: Icon(
                                        Icons.arrow_drop_down,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),

                                widget.isShowCatagory
                                    ? Wrap(
                                        children: [
                                          CatagoryChip(CatagoryTitle: "food"),
                                          CatagoryChip(CatagoryTitle: "travel"),
                                          CatagoryChip(CatagoryTitle: "other"),
                                          CatagoryChip(
                                            CatagoryTitle: "shopping",
                                          ),
                                          CatagoryChip(
                                            CatagoryTitle: "Entertainment",
                                          ),
                                        ],
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          ////////////////////  TextField for expense date
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Date :",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                InkWell(
                                  onTap: () {
                                    _selectDate(context);
                                  },
                                  child: TextField(
                                    controller: widget.dateController,
                                    enabled: false,
                                    decoration: InputDecoration(
                                      hintText: "Select Date",
                                      border: OutlineInputBorder(),
                                      suffixIcon: Icon(Icons.calendar_month),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Note :",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  controller: widget.noteController,
                                  keyboardType: TextInputType.multiline,
                                  minLines: 3,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                    hintText: "Add a note...",
                                    border: OutlineInputBorder(),
                                  ),
                                ),

                                SizedBox(height: 20),

                                Container(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {
                                      print("pressed");
                                      print(widget.titleController.text);
                                      context
                                          .read<ExpenseProvider>()
                                          .addExpense(
                                            ExpenseModel(
                                              id: null,
                                              expenseTitle:
                                                  widget.titleController.text,
                                              expenseCategory: null,
                                              expenseAmount: double.parse(
                                                widget.amountController.text,
                                              ),
                                              expenseDate: pickedDate,
                                              expenseNote:
                                                  widget.noteController.text,
                                            ),
                                          );
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.green,
                                          duration: Duration(seconds: 2),
                                          content: Text("Expense Added"),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Save Expense",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        Container(
                          padding: EdgeInsetsGeometry.all(15.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Income :",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Rs 0.00",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    "Save Income",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
