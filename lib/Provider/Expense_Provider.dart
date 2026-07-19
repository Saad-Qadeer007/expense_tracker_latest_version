import 'dart:math';

import 'package:flutter/material.dart';
import '../Model/Expense_Model.dart';

class ExpenseProvider extends ChangeNotifier {
  List<ExpenseModel> expenses = [];
  String getExpenseCatagory = "food";
  double Balance = 0.0;
  double Income = 0.0;

  void changeExpenseCatagory(String ExpenseCatagory) {
    getExpenseCatagory = ExpenseCatagory.toLowerCase();
    notifyListeners();
  }

  void setBalance(String balance) {
    Income = double.parse(balance);
    Balance += Income;
    notifyListeners();
  }

  void addExpense(ExpenseModel expense) {
    print(expense.expenseCategory);
    expenses.add(expense);
    notifyListeners();
  }
}
