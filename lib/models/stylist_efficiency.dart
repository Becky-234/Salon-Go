class StylistEfficiency {
  final String name;
  final double utilization;

  StylistEfficiency({required this.name, required this.utilization});

  factory StylistEfficiency.fromJson(Map<String, dynamic> json) {
    return StylistEfficiency(
      name: json['name'],
      utilization: (json['utilization'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'utilization': utilization,
      };
}