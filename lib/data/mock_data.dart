class MockData {
  static const double totalRevenue = 4200000;
  static const int activeStylists = 24;
  static const int completedBookings = 158;
  static const double customerRating = 4.9;

  static const List<Map<String, dynamic>> earningsData = [
    {'week': 'WK 01', 'revenue': 800000.0,  'orders': 20.0},
    {'week': 'WK 02', 'revenue': 950000.0,  'orders': 28.0},
    {'week': 'WK 03', 'revenue': 1200000.0, 'orders': 35.0},
    {'week': 'WK 04', 'revenue': 780000.0,  'orders': 18.0},
  ];

  static const List<Map<String, dynamic>> recentActivity = [
    {
      'name': 'Aisha K.',
      'action': 'requested a new Bridal Weave appointment.',
      'time': '2 mins ago',
      'type': 'request',
      'initials': 'AK',
    },
    {
      'name': 'John M.',
      'action': 'Payment received for "Gents Fade & Wash".',
      'time': '16 mins ago',
      'type': 'payment',
      'amount': '+UGX 45,000',
      'initials': 'JM',
    },
    {
      'name': 'Sarah T.',
      'action': 'Stylist marked "Silk Press" as completed.',
      'time': '42 mins ago',
      'type': 'completed',
      'initials': 'ST',
    },
    {
      'name': 'Maria G.',
      'action': '"The best braids I\'ve ever had in Kampala!"',
      'time': '1 hour ago',
      'type': 'review',
      'rating': 5,
      'initials': 'MG',
    },
  ];

  static const List<Map<String, dynamic>> topStylists = [
    {
      'name': 'Grace Namutebu',
      'role': 'Master Barber',
      'revenue': 'UGX 1.2M',
      'score': 90,
      'initials': 'GN',
    },
    {
      'name': 'David Kiiza',
      'role': 'Senior Barber',
      'revenue': 'UGX 500k',
      'score': 88,
      'initials': 'DK',
    },
  ];

  static const List<Map<String, dynamic>> inventoryAlerts = [
    {'name': 'Shea Moisture Shampoo', 'units': 3},
    {'name': 'Eco Style Olive Oil Gel', 'units': 0},
  ];
}