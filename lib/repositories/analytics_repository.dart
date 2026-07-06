import 'package:saloon_go/models/cohort_month.dart';
import 'package:saloon_go/models/service_stat.dart';
import 'package:saloon_go/models/stylist_efficiency.dart';

class AnalyticsRepository {
  // Mock data — swap the body of each fetch method for a real API call later.
  static final List<Map<String, dynamic>> _serviceData = [
    {'name': 'Braids & Twists', 'percent': 48},
    {'name': 'Nails & Pedicure', 'percent': 24},
    {'name': 'Bridal Makeup', 'percent': 18},
    {'name': 'Facials & Spa', 'percent': 10},
  ];

  static final List<Map<String, dynamic>> _cohortData = [
    {
      'month': 'January 2024',
      'newCustomers': 420,
      'values': [100, 78, 65, 52, 28, 41],
    },
    {
      'month': 'February 2024',
      'newCustomers': 512,
      'values': [100, 82, 68, 55, 48, null],
    },
    {
      'month': 'March 2024',
      'newCustomers': 488,
      'values': [100, 75, 60, null, null, null],
    },
  ];

  static final List<Map<String, dynamic>> _stylistData = [
    {'name': 'Nakato Sarah', 'utilization': 0.95},
    {'name': 'Mukisa David', 'utilization': 0.88},
  ];

  /// Simulates a future API call (e.g. GET /analytics/popular-services).
  Future<List<ServiceStat>> fetchPopularServices() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _serviceData.map((json) => ServiceStat.fromJson(json)).toList();
  }

  /// Filter logic lives here, not in the screen.
  Future<List<ServiceStat>> fetchFilteredServices({String query = ''}) async {
    final all = await fetchPopularServices();
    if (query.isEmpty) return all;
    final q = query.toLowerCase();
    return all.where((s) => s.name.toLowerCase().contains(q)).toList();
  }

  /// Simulates a future API call (e.g. GET /analytics/retention-cohorts).
  Future<List<CohortMonth>> fetchCohorts() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _cohortData.map((json) => CohortMonth.fromJson(json)).toList();
  }

  /// Simulates a future API call (e.g. GET /analytics/stylist-efficiency).
  Future<List<StylistEfficiency>> fetchStylistEfficiency() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _stylistData.map((json) => StylistEfficiency.fromJson(json)).toList();
  }

  /// Filter logic lives here, not in the screen.
  Future<List<StylistEfficiency>> fetchFilteredStylistEfficiency(
      {String query = ''}) async {
    final all = await fetchStylistEfficiency();
    if (query.isEmpty) return all;
    final q = query.toLowerCase();
    return all.where((s) => s.name.toLowerCase().contains(q)).toList();
  }
}