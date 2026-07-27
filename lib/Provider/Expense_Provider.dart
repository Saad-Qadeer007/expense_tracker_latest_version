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
  bool editMode = false;
  List<ExpenseModel> searchResults = [];
  bool searchedMode = false;
  bool ShowChipsForCatagoryFiltering = false;
  List<String> ExpenseCatagory = [
    "income",
    "food",
    "shopping",
    "travel",
    "entertainment",
    "other",
  ];

  // Setting Expense Catagory Controller

  void changeExpenseCatagory(String ExpenseCatagory) {
    getExpenseCatagory = ExpenseCatagory.toLowerCase();
    notifyListeners();
  }

  // Setting Edit Status Controller

  void changeEditStatus() {
    editMode = true;
    notifyListeners();
  }

  // Setting Balance Operation
  // void setBalance(String balance) {
  //   Income = double.parse(balance);
  //   Balance += Income;
  //   SaveExpense();
  //   notifyListeners();
  // }

  // Shared Prefereneces Operations

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

  Future<void> LoadSaveExpense() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Balance = pref.getDouble("Balance") ?? 0.0;
    Income = pref.getDouble("Income") ?? 0.0;
    Expense = pref.getDouble("Expense") ?? 0.0;
    final ExpensesString = pref.getString("Expenses") ?? "[]";
    List<dynamic> jsonList = jsonDecode(ExpensesString);
    expenses = jsonList.map((e) => ExpenseModel.fromJson(e)).toList();
    notifyListeners();
  }

  //  Crud Operations
  void addExpense(ExpenseModel expense) {
    expenses.add(expense);
    if (expense.expenseCategory?.toLowerCase() == "income") {
      Balance += expense.expenseAmount!;
      Income += expense.expenseAmount!;
    } else {
      Balance -= expense.expenseAmount!;
      Expense -= expense.expenseAmount!;
    }
    SaveExpense();
    notifyListeners();
  }

  void deleteExpense(int index) {
    print(index);
    expenses.removeAt(index);
    Balance += expenses[index].expenseAmount!;
    Expense -= expenses[index].expenseAmount!;
    SaveExpense();
    notifyListeners();
  }

  void editExpense(int index, ExpenseModel expense) {
    Expense -= expenses[index].expenseAmount!;
    Expense += expense.expenseAmount!;
    Balance += expenses[index].expenseAmount!;
    Balance -= expense.expenseAmount!;
    expenses[index].expenseTitle = expense.expenseTitle;
    expenses[index].expenseCategory = expense.expenseCategory;
    expenses[index].expenseAmount = expense.expenseAmount;
    expenses[index].expenseDate = expense.expenseDate;
    expenses[index].expenseNote = expense.expenseNote;
    notifyListeners();
    SaveExpense();
    editMode = false;
  }

  void resetApp() {
    expenses.clear();
    Balance = 0.0;
    Income = 0.0;
    Expense = 0.0;
    SaveExpense();
    notifyListeners();
  }

  //   Searching Operations

  void searchExpense(String query) {
    if (query == "") {
      searchedMode = !searchedMode;
    } else {
      searchedMode = true;
    }
    searchResults = expenses.where((items) {
      return items.expenseTitle!.toLowerCase().startsWith(query.toLowerCase());
    }).toList();
    print(searchResults);
    List<String?> items = searchResults.map((item) {
      return item.expenseTitle;
    }).toList();
    notifyListeners();
  }

  void filterByCatagory(String catagory) {
    if (catagory == "") {
      searchedMode = false;
    } else {
      searchedMode = true;
    }
    searchResults = expenses.where((items) {
      return items.expenseCategory == catagory;
    }).toList();
    notifyListeners();
  }
}
