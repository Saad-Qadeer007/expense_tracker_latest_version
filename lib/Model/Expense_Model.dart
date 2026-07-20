class ExpenseModel {
  int? id;
  String? expenseTitle;
  String? expenseCategory;
  double? expenseAmount;
  DateTime? expenseDate;
  String? expenseNote;
  DateTime createdAt;

  ExpenseModel({
    this.id,
    this.expenseTitle,
    this.expenseCategory,
    this.expenseAmount,
    this.expenseDate,
    this.expenseNote,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "expenseTitle": expenseTitle,
      "expenseCategory": expenseCategory,
      "expenseAmount": expenseAmount,
      "expenseDate": expenseDate,
      "expenseDate": expenseDate?.toIso8601String(),
      "createdAt": createdAt.toIso8601String(),
    };
  }

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json["id"],
      expenseTitle: json["expenseTitle"],
      expenseCategory: json["expenseCategory"],
      expenseAmount: (json["expenseAmount"] as num?)?.toDouble(),
      expenseDate: json["expenseDate"] != null
          ? DateTime.parse(json["expenseDate"])
          : null,
      expenseNote: json["expenseNote"],
      createdAt: DateTime.parse(json["createdAt"]),
    );
  }
}
