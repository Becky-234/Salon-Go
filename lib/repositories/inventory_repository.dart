import 'package:saloon_go/models/inventory_item.dart';

class InventoryRepository {
  // Mock data — swap the body of fetchInventory() for a real API call later.
  static final List<Map<String, dynamic>> _mockData = [
    {'name': 'Shea Moisture Shampoo', 'units': 3},
    {'name': 'Eco Style Olive Oil Gel', 'units': 0},
    {'name': 'Argan Oil Leave-In Conditioner', 'units': 2},
  ];

  /// Simulates a future API call (e.g. GET /inventory/low-stock).
  Future<List<InventoryItem>> fetchLowStockItems() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockData.map((json) => InventoryItem.fromJson(json)).toList();
  }
}