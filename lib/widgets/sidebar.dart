import 'package:flutter/material.dart';
import 'package:saloon_go/core/theme.dart';

class Sidebar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const Sidebar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      color: AppColors.sidebar,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),

          // Logo + Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [

          // Gold filled square logo
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.spa_outlined,
                color: AppColors.sidebar, size: 22),
          ),
                const SizedBox(width: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SalonGo',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Admin',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: AppColors.outlineVariant,
                      ),
                    ),
                    Text(
                      'MODERN HERITAGE',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 8,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                        color: AppColors.outlineVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 36),

          // Nav items
          _navItem(0, Icons.grid_view_rounded, 'Dashboard'),
          _navItem(1, Icons.calendar_month_rounded, 'Bookings'),
          _navItem(2, Icons.people_alt_rounded, 'Stylists'),
          _navItem(3, Icons.person_outline_rounded, 'Customers'),
          _navItem(4, Icons.insert_chart_outlined_rounded, 'Analytics'),
          _navItem(5, Icons.settings_outlined, 'Settings'),

          const Spacer(),

          // Book New Service button
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            child: Container(
              width: double.infinity,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.sidebar,
                        width: 1.5,
                      ),
                    ),
                    child: const Icon(Icons.add,
                        color: AppColors.sidebar, size: 14),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Book New Service',
                    style: AppTextStyles.bodyMd.copyWith(
                      color: AppColors.accentDark,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

 Widget _navItem(int index, IconData icon, String label) {
  final bool isActive = selectedIndex == index;
  return GestureDetector(
    onTap: () => onItemSelected(index),
    child: Container(
      margin: const EdgeInsets.only(left: 12, top: 2, bottom: 2),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: isActive ? AppColors.background : Colors.transparent,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: isActive ? AppColors.primary : AppColors.outlineVariant,
            size: 18,
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              color: isActive ? AppColors.primary : AppColors.outlineVariant,
            ),
          ),
        ],
      ),
    ),
  );
}
}