import 'package:flutter/material.dart';
import 'package:saloon_go/core/theme.dart';

enum StatCardBadgeType { pill, stars, text }

class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final StatCardBadgeType badgeType;
  final String? badgeText;
  final Color? badgeColor;

  const StatCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.badgeType = StatCardBadgeType.pill,
    this.badgeText,
    this.badgeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 24,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainer,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: AppColors.primary, size: 22),
              ),
              _buildBadge(),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            label.toUpperCase(),
            style: AppTextStyles.labelCaps.copyWith(
              color: AppColors.textDark,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: AppTextStyles.headlineMd.copyWith(
              fontSize: 22,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge() {
    switch (badgeType) {
  case StatCardBadgeType.pill:
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: (badgeColor ?? AppColors.primary).withOpacity(0.12),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: badgeColor ?? AppColors.primary,
        width: 1.2,
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (badgeColor == AppColors.success)
          const Icon(Icons.trending_up_rounded,
              color: AppColors.success, size: 13),
        if (badgeColor == AppColors.success)
          const SizedBox(width: 3),
        Text(
          badgeText ?? '',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w900,
            color: badgeColor ?? AppColors.primary,
          ),
        ),
      ],
    ),
  );

      case StatCardBadgeType.text:
        return Text(
          badgeText ?? '',
          style: AppTextStyles.bodyMd.copyWith(
            color: AppColors.textGrey,
            fontSize: 12,
          ),
        );

      case StatCardBadgeType.stars:
        return Row(
          children: List.generate(
            3,
            (i) => const Padding(
              padding: EdgeInsets.only(left: 2),
              child: Icon(Icons.star_outline_rounded,
                  color: AppColors.accent, size: 18),
            ),
          ),
        );
    }
  }
}