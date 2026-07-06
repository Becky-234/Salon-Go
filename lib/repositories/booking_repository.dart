import 'package:flutter/material.dart';
import 'package:saloon_go/models/booking.dart';

class BookingRepository {
  // Mock data — swap the body of fetchBookings() for a real API call later.
  static final List<Map<String, dynamic>> _mockData = [
    {
      'id': '#SG-9281',
      'initials': 'ZN',
      'customer': 'Zahara Namutebu',
      'phone': '+256 701 234',
      'service': 'Box Braid (Medium)',
      'serviceColorValue': const Color(0xFF6B2DBF).value,
      'stylist': 'Aisha M.',
      'stylistInitials': 'AM',
      'date': 'Oct 24, 2023',
      'time': '10:30 AM',
      'status': 'CONFIRMED',
      'amount': 'UGX 120k',
    },
    {
      'id': '#SG-9280',
      'initials': 'JK',
      'customer': 'Joel Kato',
      'phone': '+256 750 087',
      'service': "Gent's Fade & Beard",
      'serviceColorValue': const Color(0xFF10B981).value,
      'stylist': 'David O.',
      'stylistInitials': 'DO',
      'date': 'Oct 24, 2023',
      'time': '11:00 AM',
      'status': 'PENDING',
      'amount': 'UGX 45k',
    },
    {
      'id': '#SG-9275',
      'initials': 'MA',
      'customer': 'Mercy Akello',
      'phone': '+256 788 110',
      'service': 'Bridal Styling Pkg',
      'serviceColorValue': const Color(0xFFF5A623).value,
      'stylist': 'Sarah K.',
      'stylistInitials': 'SK',
      'date': 'Oct 25, 2023',
      'time': '09:00 AM',
      'status': 'CONFIRMED',
      'amount': 'UGX 350k',
    },
    {
      'id': '#SG-9270',
      'initials': 'PO',
      'customer': 'Patrick Okello',
      'phone': '+256 750 100',
      'service': "Men's Manicure",
      'serviceColorValue': const Color(0xFF4A1A8C).value,
      'stylist': 'Unassigned',
      'stylistInitials': '?',
      'date': 'Oct 25, 2023',
      'time': '02:00 PM',
      'status': 'CANCELLED',
      'amount': 'UGX 30k',
    },
  ];

  /// Simulates a future API call (e.g. GET /bookings).
  Future<List<Booking>> fetchBookings() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _mockData.map((json) => Booking.fromJson(json)).toList();
  }

  /// Filter logic lives here, not in the screen. When the API lands, this
  /// can just as easily send query params instead of filtering in memory.
  Future<List<Booking>> fetchFilteredBookings({
    String searchQuery = '',
    String status = 'All Statuses',
    String stylist = 'All Stylists',
  }) async {
    final all = await fetchBookings();
    return all.where((b) {
      final q = searchQuery.toLowerCase();
      final matchesSearch = q.isEmpty ||
          b.customer.toLowerCase().contains(q) ||
          b.id.toLowerCase().contains(q) ||
          b.service.toLowerCase().contains(q) ||
          b.stylist.toLowerCase().contains(q);

      final matchesStatus =
          status == 'All Statuses' || b.status.toLowerCase() == status.toLowerCase();

      final matchesStylist = stylist == 'All Stylists' || b.stylist == stylist;

      return matchesSearch && matchesStatus && matchesStylist;
    }).toList();
  }
}