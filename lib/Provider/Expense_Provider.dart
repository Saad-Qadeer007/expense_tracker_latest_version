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
  late List<String> ExpenseCatagoryTitle = [
    "food",
    "shopping",
    "travel",
    "entertainment",
    "other",
  ];
  List<String> DateChips = ["All", "Today", "Week", "Month", "Year"];
  late String selectedDateChip = DateChips[0];
  String searchingQuery = "";
  String selectedCategory = "";

  // Handling the Bottom Navigation Bar
  int selctedBottomNavigationIndex = 0;
  String selectedDateChipForBreakDown = "All";

  // Vaibles for Handling each Catagory Final Calculation
  double Food = 0.0;
  double Shopping = 0.0;
  double Travel = 0.0;
  double Entertainment = 0.0;
  double Other = 0.0;
  double TotalExpense = 0.0;

  // Varibles for handling each Catagory Percentage
  double FoodPercentage = 0.0;
  double ShoppingPercentage = 0.0;
  double TravelPercentage = 0.0;
  double EntertainmentPercentage = 0.0;
  double OtherPercentage = 0.0;

  List<ExpenseModel> ExpenseBreakDown = [];
  String selectedDateFilterForBreakDown = "All";
  late List<ExpenseModel> ExpenseDatefilteredForBreakDown = List.of(expenses);

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
    searchResults = List.from(expenses);
    notifyListeners();
  }

  //  Crud Operations
  void addExpense(ExpenseModel expense) {
    expenses.add(expense);
    searchResults = List.from(expenses);
    if (expense.expenseCategory?.toLowerCase() == "income") {
      Balance += expense.expenseAmount!;
      Income += expense.expenseAmount!;
    } else {
      Balance -= expense.expenseAmount!;
      Expense += expense.expenseAmount!;
    }
    SaveExpense();
    notifyListeners();
  }

  void deleteExpense(int index) {
    ExpenseModel deletedExpense = expenses[index];
    expenses.removeAt(index);
    Balance += deletedExpense.expenseAmount!;
    Expense -= deletedExpense.expenseAmount!;
    searchResults = List.from(expenses);
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
    FoodPercentage = 0.0;
    ShoppingPercentage = 0.0;
    TravelPercentage = 0.0;
    EntertainmentPercentage = 0.0;
    OtherPercentage = 0.0;
    editMode = false;
    searchResults = [];
    searchedMode = false;
    ShowChipsForCatagoryFiltering = false;
    SaveExpense();
    notifyListeners();
  }

  //   Searching Operations and Filtering Operations

  void searchExpense(String query) {
    searchingQuery = query;
    applyFilters();
  }

  void filterByCategory(String category) {
    selectedCategory = category;
    applyFilters();
  }

  void selectedDateFilter(String chip) {
    selectedDateChip = chip;
    applyFilters();
  }

  void applyFilters() {
    List<ExpenseModel> filtered = List.from(expenses);

    // Search Filter
    if (searchingQuery.isNotEmpty) {
      filtered = filtered.where((expense) {
        return expense.expenseTitle!.toLowerCase().startsWith(
          searchingQuery.toLowerCase(),
        );
      }).toList();
    }

    // Category Filter
    if (selectedCategory.isNotEmpty) {
      filtered = filtered.where((expense) {
        return expense.expenseCategory == selectedCategory;
      }).toList();
    }

    // Date Filter
    DateTime now = DateTime.now();

    if (selectedDateChip == "Today") {
      filtered = filtered.where((expense) {
        return expense.expenseDate!.day == now.day &&
            expense.expenseDate!.month == now.month &&
            expense.expenseDate!.year == now.year;
      }).toList();
    } else if (selectedDateChip == "Week") {
      DateTime today = DateTime(now.year, now.month, now.day);

      DateTime startOfWeek = today.subtract(Duration(days: today.weekday - 1));

      DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

      filtered = filtered.where((expense) {
        return expense.expenseDate!.compareTo(startOfWeek) >= 0 &&
            expense.expenseDate!.compareTo(endOfWeek) <= 0;
      }).toList();
    } else if (selectedDateChip == "Month") {
      filtered = filtered.where((expense) {
        return expense.expenseDate!.month == now.month &&
            expense.expenseDate!.year == now.year;
      }).toList();
    } else if (selectedDateChip == "Year") {
      filtered = filtered.where((expense) {
        return expense.expenseDate!.year == now.year;
      }).toList();
    }

    searchResults = filtered;

    searchedMode =
        searchingQuery.isNotEmpty ||
        selectedCategory.isNotEmpty ||
        selectedDateChip != "All";

    notifyListeners();
  }

  //   BreakDown Screen

  void selctedDateChipForBreakDown(String chip) {
    selectedDateChipForBreakDown = chip;
    notifyListeners();
  }

  //   Calculating the Total of Each Catagoty
  void calculateTotal() {
    Food = 0.0;
    Shopping = 0.0;
    Travel = 0.0;
    Entertainment = 0.0;
    Other = 0.0;
    expenses.map((item) {
      item.expenseCategory?.toLowerCase() == "food"
          ? Food += item.expenseAmount!
          : null;
      item.expenseCategory?.toLowerCase() == "shopping"
          ? Shopping += item.expenseAmount!
          : null;
      item.expenseCategory?.toLowerCase() == "travel"
          ? Travel += item.expenseAmount!
          : null;
      item.expenseCategory?.toLowerCase() == "entertainment"
          ? Entertainment += item.expenseAmount!
          : null;
      item.expenseCategory?.toLowerCase() == "other"
          ? Other += item.expenseAmount!
          : null;
    }).toList();
    calculatePercentage();
    notifyListeners();
  }

  void calculatePercentage() {
    double total = Food + Shopping + Travel + Entertainment + Other;
    TotalExpense = total;
    if (total == 0) {
      FoodPercentage = 0.0;
      ShoppingPercentage = 0.0;
      TravelPercentage = 0.0;
      EntertainmentPercentage = 0.0;
      OtherPercentage = 0.0;
      notifyListeners();
    } else {
      FoodPercentage = (Food / total) * 100;
      ShoppingPercentage = (Shopping / total) * 100;
      TravelPercentage = (Travel / total) * 100;
      EntertainmentPercentage = (Entertainment / total) * 100;
      OtherPercentage = (Other / total) * 100;
      notifyListeners();
    }
  }

  void selctedCatagoryForBreakDown(String catagory) {
    ExpenseBreakDown = expenses.where((item) {
      return item.expenseCategory?.toLowerCase() == catagory.toLowerCase();
    }).toList();
    notifyListeners();
  }

  void DateFilterForBreakDown(String chip) {
    selectedDateFilterForBreakDown = chip;
    DateTime now = DateTime.now();

    if (selectedDateFilterForBreakDown == "Today") {
      ExpenseDatefilteredForBreakDown = expenses.where((expense) {
        return expense.expenseDate!.day == now.day &&
            expense.expenseDate!.month == now.month &&
            expense.expenseDate!.year == now.year;
      }).toList();
    } else if (selectedDateFilterForBreakDown == "Week") {
      DateTime today = DateTime(now.year, now.month, now.day);

      DateTime startOfWeek = today.subtract(Duration(days: today.weekday - 1));

      DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

      ExpenseDatefilteredForBreakDown = expenses.where((expense) {
        return expense.expenseDate!.compareTo(startOfWeek) >= 0 &&
            expense.expenseDate!.compareTo(endOfWeek) <= 0;
      }).toList();
    } else if (selectedDateFilterForBreakDown == "Month") {
      ExpenseDatefilteredForBreakDown = expenses.where((expense) {
        return expense.expenseDate!.month == now.month &&
            expense.expenseDate!.year == now.year;
      }).toList();
    } else if (selectedDateFilterForBreakDown == "Year") {
      ExpenseDatefilteredForBreakDown = expenses.where((expense) {
        return expense.expenseDate!.year == now.year;
      }).toList();
    } else {
      ExpenseDatefilteredForBreakDown = expenses;
    }
    notifyListeners();
  }

  void calculateTotalForBreakDownAfterFiltering() {
    Food = 0.0;
    Shopping = 0.0;
    Travel = 0.0;
    Entertainment = 0.0;
    Other = 0.0;
    ExpenseDatefilteredForBreakDown.map((item) {
      item.expenseCategory?.toLowerCase() == "food"
          ? Food += item.expenseAmount!
          : null;
      item.expenseCategory?.toLowerCase() == "shopping"
          ? Shopping += item.expenseAmount!
          : null;
      item.expenseCategory?.toLowerCase() == "travel"
          ? Travel += item.expenseAmount!
          : null;
      item.expenseCategory?.toLowerCase() == "entertainment"
          ? Entertainment += item.expenseAmount!
          : null;
      item.expenseCategory?.toLowerCase() == "other"
          ? Other += item.expenseAmount!
          : null;
    }).toList();
    calculatePercentage();
    notifyListeners();
  }
}
