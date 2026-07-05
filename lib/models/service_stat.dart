class ServiceStat {
  final String name;
  final int percent;

  ServiceStat({required this.name, required this.percent});

  factory ServiceStat.fromJson(Map<String, dynamic> json) {
    return ServiceStat(
      name: json['name'],
      percent: json['percent'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'percent': percent,
      };
}