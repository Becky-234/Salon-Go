import 'package:flutter/material.dart';
import 'package:saloon_go/core/theme.dart';
import 'package:saloon_go/screens/bookings/bookings_screen.dart';
import 'package:saloon_go/screens/dashboard/dashboard_screen.dart';
import 'package:saloon_go/widgets/sidebar.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  // List of screens - add more as you create them
  final List<Widget> _screens = [
    const DashboardScreen(),
    const BookingsScreen(),
    // Add other screens here when created
    // const StylistsScreen(),
    // const CustomersScreen(),
    // const AnalyticsScreen(),
    // const SettingsScreen(),
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