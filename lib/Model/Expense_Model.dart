class ExpenseModel {
  int? id;
  String? expenseTitle;
  String? expenseCategory;
  double? expenseAmount;
  DateTime? expenseDate;
  String? expenseNote;
  DateTime createdAt = DateTime.now();

  ExpenseModel({
    required this.id,
    this.expenseTitle,
    this.expenseCategory,
    this.expenseAmount,
    this.expenseDate,
    this.expenseNote,
  });
}
