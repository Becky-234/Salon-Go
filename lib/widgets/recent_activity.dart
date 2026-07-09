import 'package:flutter/material.dart';
import 'package:saloon_go/core/theme.dart';
import 'package:saloon_go/data/mock_data.dart';

class RecentActivity extends StatelessWidget {
  const RecentActivity({super.key});

  @override
  Widget build(BuildContext context) {
    final activities = MockData.recentActivity;

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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: activities.asMap().entries.map(
                      (entry) => _activityItem(
                        entry.value,
                        index: entry.key,
                        isLast: entry.key == activities.length - 1,
                      ),
                    ).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _activityItem(Map<String, dynamic> item,
      {required int index, required bool isLast}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _activityAvatar(item, index: index, isLast: isLast),
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

  /// Builds the leading avatar for an activity row.
  ///
  /// - The second activity (index 1) is a payment confirmation, so it gets a
  ///   light-green circle with a verified icon instead of a person's initials.
  /// - The last activity is a review, so it gets a light-purple circle with a
  ///   purple star icon.
  /// - Everything else falls back to the normal initials avatar.
  /// Only the initials avatar gets the gold ring border — the payment and
  /// review icons do not.
  Widget _activityAvatar(Map<String, dynamic> item,
      {required int index, required bool isLast}) {
    const double size = 36;

    if (index == 1) {
      // Payment activity — no gold border, only initials avatars get that
      return Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: Color(0xFFDCFCE7), // light green
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.verified_rounded,
            color: AppColors.success, size: 16),
      );
    }

    if (isLast) {
      // Review activity — no gold border, purple star instead of gold
      return Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: AppColors.surfaceContainer, // light purple
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.star_rounded,
            color: AppColors.primary, size: 16),
      );
    }

    // Default: person avatar with initials
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.accent, width: 2),
      ),
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
          color: AppColors.surfaceContainer,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(item['initials'],
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary)),
        ),
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