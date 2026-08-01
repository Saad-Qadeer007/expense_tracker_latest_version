import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/Expense_Model.dart';

class ExpenseProvider extends ChangeNotifier {
  // Theme Controller
  bool isDarkMode = false;
  List<ExpenseModel> expenses = [];
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

  // Monthly report
  DateTime? MonthGetter;
  double ExpenseByMonth = 0.00;
  double IncomeByMonth = 0.00;
  double SavingByMonth = 0.00;
  double FoodByMonth = 0.00;
  double ShoppingByMonth = 0.00;
  double TravelByMonth = 0.00;
  double EntertainmentByMonth = 0.00;
  double OtherByMonth = 0.00;
  double FoodPercentageByMonth = 0.00;
  double ShoppingPercentageByMonth = 0.00;
  double TravelPercentageByMonth = 0.00;
  double EntertainmentPercentageByMonth = 0.00;
  double OtherPercentageByMonth = 0.00;
  String TopSpendingCatagory = "No Spending Yet";
  int TotalNumbersOfTransactionsByMonth = 0;
  String LowestSpendingCatagory = "No Spending Yet";
  double LowestSpendingAmount = 0.00;
  double AverageExpenseByMonth = 0.00;

  // Setting Edit Status Controller

  void changeEditStatus() {
    editMode = true;
    notifyListeners();
  }

  // Setting Dark Mode Controller
  void changeTheme() {
    isDarkMode = !isDarkMode;
    SaveExpense();
    notifyListeners();
  }

  // Shared Prefereneces Operations

  Future<void> SaveExpense() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setDouble("Balance", Balance);
    pref.setDouble("Income", Income);
    pref.setDouble("Expense", Expense);
    pref.setBool("isDarkMode", isDarkMode);
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
    isDarkMode = pref.getBool("isDarkMode") ?? false;
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

  //   Handling the Monthly Report Screen
  void GetExpenseByMonthAndYear(String month, String year) {
    TotalNumbersOfTransactionsByMonth = 0;
    LowestSpendingAmount = 0.0;
    TopSpendingCatagory = "No Spending Yet";
    LowestSpendingCatagory = "No Spending Yet";
    AverageExpenseByMonth = 0.0;
    IncomeByMonth = 0.0;
    ExpenseByMonth = 0.0;
    SavingByMonth = 0.0;
    FoodByMonth = 0.0;
    ShoppingByMonth = 0.0;
    TravelByMonth = 0.0;
    EntertainmentByMonth = 0.0;
    OtherByMonth = 0.0;
    FoodPercentageByMonth = 0.0;
    ShoppingPercentageByMonth = 0.0;
    TravelPercentageByMonth = 0.0;
    EntertainmentPercentageByMonth = 0.0;
    OtherPercentageByMonth = 0.0;
    expenses.map((item) {
      if (item.expenseDate?.month == int.parse(month) &&
          item.expenseDate?.year == int.parse(year)) {
        if (item.expenseCategory?.toLowerCase() == "income") {
          IncomeByMonth += item.expenseAmount!;
        } else {
          TotalNumbersOfTransactionsByMonth++;
          if (item.expenseCategory?.toLowerCase() == "food") {
            FoodByMonth += item.expenseAmount!;
          } else if (item.expenseCategory?.toLowerCase() == "shopping") {
            ShoppingByMonth += item.expenseAmount!;
          } else if (item.expenseCategory?.toLowerCase() == "travel") {
            TravelByMonth += item.expenseAmount!;
          } else if (item.expenseCategory?.toLowerCase() == "entertainment") {
            EntertainmentByMonth += item.expenseAmount!;
          } else {
            OtherByMonth += item.expenseAmount!;
          }
          ExpenseByMonth += item.expenseAmount!;
        }
      }
    }).toList();
    SavingByMonth = IncomeByMonth - ExpenseByMonth;
    double total =
        FoodByMonth +
        ShoppingByMonth +
        TravelByMonth +
        EntertainmentByMonth +
        OtherByMonth;

    AverageExpenseByMonth = total / TotalNumbersOfTransactionsByMonth;

    FoodPercentageByMonth = (FoodByMonth / total) * 100;
    ShoppingPercentageByMonth = (ShoppingByMonth / total) * 100;
    TravelPercentageByMonth = (TravelByMonth / total) * 100;
    EntertainmentPercentageByMonth = (EntertainmentByMonth / total) * 100;
    OtherPercentageByMonth = (OtherByMonth / total) * 100;
    if (FoodByMonth > ShoppingByMonth &&
        FoodByMonth > TravelByMonth &&
        FoodByMonth > EntertainmentByMonth &&
        FoodByMonth > OtherByMonth) {
      TopSpendingCatagory = "Food";
    } else if (ShoppingByMonth > FoodByMonth &&
        ShoppingByMonth > TravelByMonth &&
        ShoppingByMonth > EntertainmentByMonth &&
        ShoppingByMonth > OtherByMonth) {
      TopSpendingCatagory = "Shopping";
    } else if (TravelByMonth > FoodByMonth &&
        TravelByMonth > ShoppingByMonth &&
        TravelByMonth > EntertainmentByMonth &&
        TravelByMonth > OtherByMonth) {
      TopSpendingCatagory = "Travel";
    } else if (EntertainmentByMonth > FoodByMonth &&
        EntertainmentByMonth > ShoppingByMonth &&
        EntertainmentByMonth > TravelByMonth &&
        EntertainmentByMonth > OtherByMonth) {
      TopSpendingCatagory = "Entertainment";
    } else {
      TopSpendingCatagory = "Other";
    }

    if (FoodByMonth < ShoppingByMonth &&
        FoodByMonth < TravelByMonth &&
        FoodByMonth < EntertainmentByMonth &&
        FoodByMonth < OtherByMonth) {
      LowestSpendingCatagory = "Shopping";
      LowestSpendingAmount = ShoppingByMonth;
    } else if (ShoppingByMonth < FoodByMonth &&
        ShoppingByMonth < TravelByMonth &&
        ShoppingByMonth < EntertainmentByMonth &&
        ShoppingByMonth < OtherByMonth) {
      LowestSpendingAmount = ShoppingByMonth;
      LowestSpendingCatagory = "Shopping";
    } else if (TravelByMonth < FoodByMonth &&
        TravelByMonth < ShoppingByMonth &&
        TravelByMonth < EntertainmentByMonth &&
        TravelByMonth < OtherByMonth) {
      LowestSpendingAmount = TravelByMonth;
      LowestSpendingCatagory = "Travel";
    } else if (ShoppingByMonth < FoodByMonth &&
        ShoppingByMonth < TravelByMonth &&
        ShoppingByMonth < EntertainmentByMonth &&
        ShoppingByMonth < OtherByMonth) {
      LowestSpendingAmount = ShoppingByMonth;
      LowestSpendingCatagory = "Shopping";
    } else {
      LowestSpendingAmount = OtherByMonth;
      LowestSpendingCatagory = "Other";
    }

    notifyListeners();
  }
}
