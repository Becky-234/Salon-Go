import 'package:flutter/material.dart';
import 'package:saloon_go/core/theme.dart';
import 'package:saloon_go/screens/dashboard/dashboard_screen.dart';

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
      home: const DashboardScreen(),
    );
  }
}