import 'package:flutter/material.dart';
import 'package:saloon_go/core/theme.dart';
import 'package:saloon_go/data/mock_data.dart';

class RecentActivity extends StatelessWidget {
  const RecentActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
              color: AppColors.shadow, blurRadius: 24, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Recent Activity',
                  style: AppTextStyles.headlineMd.copyWith(fontSize: 15)),
              Text('View All',
                  style: AppTextStyles.bodyMd.copyWith(
                      color: AppColors.primary, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 16),
          ...MockData.recentActivity.map((item) => _activityItem(item)),
        ],
      ),
    );
  }

  Widget _activityItem(Map<String, dynamic> item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.surfaceContainer,
            child: Text(item['initials'],
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: '${item['name']} ',
                          style: AppTextStyles.bodyMd.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textDark)),
                      TextSpan(
                          text: item['action'],
                          style: AppTextStyles.bodyMd),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(item['time'], style: AppTextStyles.labelCaps),
                if (item['type'] == 'request') ...[
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      _acceptBtn('Accept'),
                      const SizedBox(width: 8),
                      _declineBtn('Decline'),
                    ],
                  ),
                ],
                if (item['amount'] != null) ...[
                  const SizedBox(height: 2),
                  Text(item['amount'],
                      style: AppTextStyles.labelCaps
                          .copyWith(color: AppColors.success)),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _acceptBtn(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(label,
          style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.white)),
    );
  }

  Widget _declineBtn(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(label,
          style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.primary)),
    );
  }
}