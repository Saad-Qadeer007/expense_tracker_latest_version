import 'dart:math';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/Expense_Model.dart';

class ExpenseProvider extends ChangeNotifier {
  List<ExpenseModel> expenses = [];
  String getExpenseCatagory = "food";
  double Balance = 0.0;
  double Income = 0.0;
  double Expense = 0.0;

  void changeExpenseCatagory(String ExpenseCatagory) {
    getExpenseCatagory = ExpenseCatagory.toLowerCase();
    notifyListeners();
  }

  void setBalance(String balance) {
    Income = double.parse(balance);
    Balance += Income;
    SaveExpense();
    notifyListeners();
  }


  Future<void> SaveExpense() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setDouble("Balance", Balance);
    pref.setDouble("Income", Income);
    pref.setDouble("Expense", Expense);
    final Expenses = expenses.map((e) => e.toJson()).toList();
    final data = jsonEncode(Expenses);
    pref.setString("Expenses", data);
    notifyListeners();
  }

  Future<void> LoadSaveExpense() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    Balance = pref.getDouble("Balance") ?? 0.0;
    Income = pref.getDouble("Income") ?? 0.0;
    Expense = pref.getDouble("Expense") ?? 0.0;
    final ExpensesString = pref.getString("Expenses") ?? "[]";
    List<dynamic> jsonList = jsonDecode(ExpensesString);
    expenses = jsonList.map((e) => ExpenseModel.fromJson(e)).toList();
    notifyListeners();
  }


  void addExpense(ExpenseModel expense) {
    print(expense.expenseCategory);
    expenses.add(expense);
    Expense += expense.expenseAmount!;
    Balance -= expense.expenseAmount!;
    SaveExpense();
    notifyListeners();
  }


  void deleteExpense(int index) {
    expenses.removeAt(index);
    notifyListeners();
  }
}

