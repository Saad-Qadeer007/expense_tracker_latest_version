import 'package:expense_tracker_latest_version/Widgets/Catagory_Chip.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Model/Expense_Model.dart';
import '../Provider/Expense_Provider.dart';
import '../Ultilities/App_Colors.dart';

class AddExpenseScreen extends StatefulWidget {
  String gettedExpenseTitleFromEditScreen;
  String gettedExpenseCatagoryFromEditScreen;
  String? gettedExpenseAmountFromEditScreen;
  DateTime? gettedExpenseDateFromEditScreen;
  int index;

  AddExpenseScreen({
    super.key,
    required this.gettedExpenseTitleFromEditScreen,
    required this.gettedExpenseCatagoryFromEditScreen,
    required this.gettedExpenseAmountFromEditScreen,
    required this.gettedExpenseDateFromEditScreen,
    required this.index,
  });

  bool isShowCatagory = false;
  TextEditingController dateController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController catagoryController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController incomeController = TextEditingController();

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  @override
  DateTime? pickedDate;

  void passingValuesToFields() {
    widget.dateController.text =
        "${widget.gettedExpenseDateFromEditScreen?.day}/${widget.gettedExpenseDateFromEditScreen?.month}/${widget.gettedExpenseDateFromEditScreen?.year}";
    widget.titleController.text = widget.gettedExpenseTitleFromEditScreen;
    widget.amountController.text = widget.gettedExpenseAmountFromEditScreen
        .toString();
    widget.catagoryController.text = widget.gettedExpenseCatagoryFromEditScreen;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passingValuesToFields();
  }

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
    return Consumer<ExpenseProvider>(
      builder: (context, provider, child) {
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
                                    borderRadius: BorderRadiusGeometry.circular(
                                      10,
                                    ),
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
                                    borderRadius: BorderRadiusGeometry.circular(
                                      10,
                                    ),
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
                                        controller: widget.catagoryController,
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
                                              InkWell(
                                                onTap: () {
                                                  context
                                                      .read<ExpenseProvider>()
                                                      .changeExpenseCatagory(
                                                        "food",
                                                      );
                                                  setState(() {
                                                    widget.isShowCatagory =
                                                        false;
                                                    widget
                                                            .catagoryController
                                                            .text =
                                                        "Food";
                                                  });
                                                },
                                                child: CatagoryChip(
                                                  CatagoryTitle: "food",
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  context
                                                      .read<ExpenseProvider>()
                                                      .changeExpenseCatagory(
                                                        "travel",
                                                      );
                                                  setState(() {
                                                    widget.isShowCatagory =
                                                        false;
                                                    widget
                                                            .catagoryController
                                                            .text =
                                                        "Travel";
                                                  });
                                                },
                                                child: CatagoryChip(
                                                  CatagoryTitle: "travel",
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  context
                                                      .read<ExpenseProvider>()
                                                      .changeExpenseCatagory(
                                                        "other",
                                                      );
                                                  setState(() {
                                                    widget.isShowCatagory =
                                                        false;
                                                    widget
                                                            .catagoryController
                                                            .text =
                                                        "Other";
                                                  });
                                                },
                                                child: CatagoryChip(
                                                  CatagoryTitle: "other",
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  context
                                                      .read<ExpenseProvider>()
                                                      .changeExpenseCatagory(
                                                        "shopping",
                                                      );
                                                  setState(() {
                                                    widget.isShowCatagory =
                                                        false;
                                                    widget
                                                            .catagoryController
                                                            .text =
                                                        "Shopping";
                                                  });
                                                },
                                                child: CatagoryChip(
                                                  CatagoryTitle: "shopping",
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  context
                                                      .read<ExpenseProvider>()
                                                      .changeExpenseCatagory(
                                                        "Entertainment",
                                                      );
                                                  setState(() {
                                                    widget.isShowCatagory =
                                                        false;
                                                    widget
                                                            .catagoryController
                                                            .text =
                                                        "Entertainment";
                                                  });
                                                },
                                                child: CatagoryChip(
                                                  CatagoryTitle:
                                                      "Entertainment",
                                                ),
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
                                          suffixIcon: Icon(
                                            Icons.calendar_month,
                                          ),
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
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          if (widget
                                                  .titleController
                                                  .text
                                                  .isEmpty ||
                                              widget
                                                  .amountController
                                                  .text
                                                  .isEmpty ||
                                              double.tryParse(
                                                    widget
                                                        .amountController
                                                        .text,
                                                  )! <=
                                                  0 ||
                                              widget
                                                  .catagoryController
                                                  .text
                                                  .isEmpty ||
                                              widget
                                                  .dateController
                                                  .text
                                                  .isEmpty ||
                                              widget
                                                  .catagoryController
                                                  .text
                                                  .isEmpty) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                backgroundColor: Colors.red,
                                                duration: Duration(seconds: 2),
                                                content: Text(
                                                  "Please Fill all the fields",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            );
                                          } else if (provider.Balance <
                                              double.parse(
                                                widget.amountController.text,
                                              )) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                backgroundColor: Colors.red,
                                                duration: Duration(seconds: 2),
                                                content: Text(
                                                  "Insufficient Balance",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            );
                                          } else if (provider.editMode ==
                                              true) {
                                            print(pickedDate);
                                            context
                                                .read<ExpenseProvider>()
                                                .editExpense(
                                                  widget.index,
                                                  ExpenseModel(
                                                    id: null,
                                                    expenseTitle: widget
                                                        .titleController
                                                        .text,
                                                    expenseCategory: widget
                                                        .catagoryController
                                                        .text,
                                                    expenseAmount: double.parse(
                                                      widget
                                                          .amountController
                                                          .text,
                                                    ),
                                                    expenseDate:
                                                        DateFormat(
                                                          'dd/MM/yyyy',
                                                        ).parse(
                                                          widget
                                                              .dateController
                                                              .text,
                                                        ),
                                                    expenseNote: widget
                                                        .noteController
                                                        .text,
                                                    createdAt: DateTime.now(),
                                                  ),
                                                );
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                backgroundColor: Colors.green,
                                                duration: Duration(seconds: 2),
                                                content: Text(
                                                  "Expense Updated",
                                                ),
                                              ),
                                            );
                                            widget.titleController.clear();
                                            widget.amountController.clear();
                                            widget.catagoryController.clear();
                                            widget.noteController.clear();
                                            widget.dateController.clear();
                                            Navigator.pop(context);
                                          } else {
                                            context
                                                .read<ExpenseProvider>()
                                                .addExpense(
                                                  ExpenseModel(
                                                    id: null,
                                                    expenseTitle: widget
                                                        .titleController
                                                        .text,
                                                    expenseCategory: widget
                                                        .catagoryController
                                                        .text,
                                                    expenseAmount: double.parse(
                                                      widget
                                                          .amountController
                                                          .text,
                                                    ),
                                                    expenseDate: pickedDate,
                                                    expenseNote: widget
                                                        .noteController
                                                        .text,
                                                    createdAt: DateTime.now(),
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
                                            widget.titleController.clear();
                                            widget.amountController.clear();
                                            widget.catagoryController.clear();
                                            widget.noteController.clear();
                                            widget.dateController.clear();
                                          }
                                        },
                                        child: provider.editMode == false
                                            ? Text(
                                                "Save Expense",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              )
                                            : Text(
                                                "Update Expense",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
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
                                    controller: widget.incomeController,
                                    keyboardType: TextInputType.number,
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
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        if (widget
                                                .incomeController
                                                .text
                                                .isEmpty ||
                                            widget.incomeController.text ==
                                                "0") {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              backgroundColor: Colors.red,
                                              duration: Duration(seconds: 2),
                                              content: Text(
                                                "Please Fill Income Field",
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ),
                                          );
                                        } else if (double.tryParse(
                                              widget.incomeController.text,
                                            )! <
                                            0) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              backgroundColor: Colors.red,
                                              duration: Duration(seconds: 2),
                                              content: Text(
                                                "Please enter a valid income amount",
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ),
                                          );
                                        } else {
                                          context
                                              .read<ExpenseProvider>()
                                              .setBalance(
                                                widget.incomeController.text,
                                              );
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              backgroundColor: Colors.green,
                                              duration: Duration(seconds: 2),
                                              content: Text(
                                                "Income Added",
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ),
                                          );
                                          widget.incomeController.clear();
                                          Navigator.pop(context);
                                        }
                                      },
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
      },
    );
  }
}
