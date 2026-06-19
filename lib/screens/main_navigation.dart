import 'package:flutter/material.dart';
import 'package:saloon_go/core/theme.dart';
import 'package:saloon_go/screens/analytics/analytics_screen.dart';
import 'package:saloon_go/screens/bookings/bookings_screen.dart';
import 'package:saloon_go/screens/dashboard/dashboard_screen.dart';
import 'package:saloon_go/screens/stylists/stylists_screen.dart';
import 'package:saloon_go/widgets/sidebar.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const BookingsScreen(),
    const StylistsScreen(),
    const Center(child: Text('Customers')),
    const AnalyticsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          Sidebar(
            selectedIndex: _selectedIndex,
            onItemSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
          Expanded(
            child: _screens[_selectedIndex],
          ),
        ],
      ),
    );
  }
}