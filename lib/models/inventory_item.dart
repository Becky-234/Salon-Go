class InventoryItem {
  final String name;
  final int units;

  InventoryItem({required this.name, required this.units});

  factory InventoryItem.fromJson(Map<String, dynamic> json) {
    return InventoryItem(
      name: json['name'],
      units: json['units'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'units': units,
      };
}