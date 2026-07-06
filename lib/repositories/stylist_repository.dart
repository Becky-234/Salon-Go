import 'package:saloon_go/models/stylist.dart';

class StylistRepository {
  // Mock data — swap the body of fetchStylists() for a real API call later.
  static final List<Map<String, dynamic>> _mockData = [
    {
      'name': 'Zahara Namono',
      'specialty': 'Artist: Briston',
      'initials': 'ZN',
      'earnings': 'UGX 2.1M',
      'services': 142,
      'rating': 4.9,
    },
    {
      'name': 'Brian Okello',
      'specialty': 'Skin & Make Specialist',
      'initials': 'BO',
      'earnings': 'UGX 1.8M',
      'services': 89,
      'rating': 4.8,
    },
    {
      'name': 'Grace Akello',
      'specialty': 'Booth MAJA',
      'initials': 'GA',
      'earnings': 'UGX 3.4M',
      'services': 215,
      'rating': 5.0,
    },
    {
      'name': 'Sanyu Mukasa',
      'specialty': 'Neutral New Specialist',
      'initials': 'SM',
      'earnings': 'UGX 1.2M',
      'services': 56,
      'rating': 4.7,
    },
  ];

  /// Simulates a future API call (e.g. GET /stylists).
  Future<List<Stylist>> fetchStylists() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockData.map((json) => Stylist.fromJson(json)).toList();
  }

  /// Filter logic lives here, not in the screen.
  Future<List<Stylist>> fetchFilteredStylists({String query = ''}) async {
    final all = await fetchStylists();
    if (query.isEmpty) return all;
    final q = query.toLowerCase();
    return all
        .where((s) =>
            s.name.toLowerCase().contains(q) ||
            s.specialty.toLowerCase().contains(q))
        .toList();
  }
}