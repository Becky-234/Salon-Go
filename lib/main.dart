import 'package:flutter/material.dart';
import 'package:saloon_go/core/theme.dart';
import 'package:saloon_go/screens/main_navigation.dart';

void main() {
  runApp(const SalonGoApp());
}

class SalonGoApp extends StatelessWidget {
  const SalonGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SalonGo Admin',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const MainNavigation(), // Changed from DashboardScreen to MainNavigation
    );
  }
}