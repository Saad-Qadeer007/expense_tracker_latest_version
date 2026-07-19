import 'dart:math';

import 'package:flutter/material.dart';
import '../Model/Expense_Model.dart';

class ExpenseProvider extends ChangeNotifier {
  List<ExpenseModel> expenses = [];

  void addExpense(ExpenseModel expense) {
    expenses.add(expense);
    notifyListeners();
  }
}
