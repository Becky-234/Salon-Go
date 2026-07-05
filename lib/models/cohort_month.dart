class CohortMonth {
  final String month;
  final int newCustomers;
  final List<int?> values;

  CohortMonth({
    required this.month,
    required this.newCustomers,
    required this.values,
  });

  factory CohortMonth.fromJson(Map<String, dynamic> json) {
    return CohortMonth(
      month: json['month'],
      newCustomers: json['newCustomers'],
      values: (json['values'] as List).map((v) => v as int?).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'month': month,
        'newCustomers': newCustomers,
        'values': values,
      };
}