import 'package:flutter/material.dart';
import 'package:saloon_go/core/theme.dart';
import 'package:saloon_go/data/mock_data.dart';

class TopStylists extends StatelessWidget {
  const TopStylists({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: AppColors.shadow, blurRadius: 24, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Top Performance Stylists',
              style: AppTextStyles.headlineMd.copyWith(fontSize: 15)),
          const SizedBox(height: 16),
          ...MockData.topStylists.map((s) => _stylistRow(s)),
        ],
      ),
    );
  }

  Widget _stylistRow(Map<String, dynamic> s) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.accent, width: 2),
            ),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.surfaceContainer,
              child: Text(s['initials'],
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(s['name'],
                    style: AppTextStyles.bodyMd.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark)),
                Text(s['role'], style: AppTextStyles.labelCaps),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(s['revenue'],
                  style: AppTextStyles.bodyMd.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark)),
              Text('${s['score']}% score',
                  style: AppTextStyles.labelCaps.copyWith(
                      color: AppColors.success)),
            ],
          ),
        ],
      ),
    );
  }
}