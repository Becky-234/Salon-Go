import 'package:flutter/material.dart';
import 'package:saloon_go/core/theme.dart';

class StylistsScreen extends StatefulWidget {
  const StylistsScreen({super.key});

  @override
  State<StylistsScreen> createState() => _StylistsScreenState();
}

class _StylistsScreenState extends State<StylistsScreen> {
  final List<Map<String, dynamic>> _stylists = [
    {
      'name': 'Zahara Namono',
      'specialty': 'Artist: Briston',
      'initials': 'ZN',
      'earnings': 'UGX 2.1M',
      'services': 142,
      'rating': 4.9,
    },
    {
      'name': 'Brian Okello',
      'specialty': 'Skin & Make Specialist',
      'initials': 'BO',
      'earnings': 'UGX 1.8M',
      'services': 89,
      'rating': 4.8,
    },
    {
      'name': 'Grace Akello',
      'specialty': 'Booth MAJA',
      'initials': 'GA',
      'earnings': 'UGX 3.4M',
      'services': 215,
      'rating': 5.0,
    },
    {
      'name': 'Sanyu Mukasa',
      'specialty': 'Neutral New Specialist',
      'initials': 'SM',
      'earnings': 'UGX 1.2M',
      'services': 56,
      'rating': 4.7,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _topBar(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Stylist Fleet',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textDark,
                              )),
                          SizedBox(height: 4),
                          Text(
                              'Manage your elite team of beauticians and stylists.',
                              style: TextStyle(
                                  fontSize: 13, color: AppColors.textGrey)),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceContainerLow,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: AppColors.primary, width: 1.5),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.verified_outlined,
                                    color: AppColors.primary, size: 18),
                                SizedBox(width: 8),
                                Text('Verify Pending',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primary)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.add, color: Colors.white, size: 18),
                                SizedBox(width: 8),
                                Text('Add New Stylist',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(flex: 2, child: _totalRevenueCard()),
                      const SizedBox(width: 16),
                      Expanded(flex: 1, child: _activeNowCard()),
                      const SizedBox(width: 16),
                      Expanded(flex: 1, child: _fleetSatisfactionCard()),
                    ],
                  ),
                  const SizedBox(height: 24),
            LayoutBuilder(
                  builder: (context, constraints) {
                    final cardWidth = (constraints.maxWidth - 32) / 3;
                    return Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        ..._stylists.map(
                            (s) => SizedBox(width: cardWidth, child: _stylistCard(s))),
                        SizedBox(width: cardWidth, child: _onboardSlotCard()),
                      ],
                    );
                  },
                ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _totalRevenueCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.2),
            blurRadius: 24,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('TOTAL REVENUE GENERATED',
              style: AppTextStyles.labelCaps.copyWith(
                  fontSize: 11,
                  color: AppColors.textGrey.withOpacity(0.9),
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Text('UGX 12.4M',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  )),
              const SizedBox(width: 8),
              Text('+4% this month',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.accent,
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _activeNowCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.06),
            blurRadius: 24,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ACTIVE NOW',
              style: AppTextStyles.labelCaps.copyWith(
                  fontSize: 11,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text('24 / 32',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              )),
        ],
      ),
    );
  }

  Widget _fleetSatisfactionCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.accent,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.06),
            blurRadius: 24,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('FLEET SATISFACTION',
              style: AppTextStyles.labelCaps.copyWith(
                  fontSize: 11,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Row(
            children: [
              Text('4.9',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  )),
              const SizedBox(width: 4),
              Icon(Icons.star_rounded, color: AppColors.primary, size: 20),
            ],
          ),
        ],
      ),
    );
  }

  Widget _stylistCard(Map<String, dynamic> stylist) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.06),
            blurRadius: 24,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 130,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primaryContainer.withOpacity(0.6),
                      AppColors.primary.withOpacity(0.8),
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Center(
                  child: Text(stylist['initials'],
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: Colors.white.withOpacity(0.5))),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: AppColors.success,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text('ONLINE',
                          style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textDark)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(stylist['name'],
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textDark),
                          overflow: TextOverflow.ellipsis),
                    ),
                    Row(
                      children: [
                        Text(stylist['rating'].toString(),
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textMid)),
                        const SizedBox(width: 2),
                        const Icon(Icons.star_outline_rounded,
                            color: AppColors.accent, size: 14),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(stylist['specialty'],
                    style: const TextStyle(
                        fontSize: 11,
                        fontStyle: FontStyle.italic,
                        color: AppColors.textGrey)),
                const SizedBox(height: 10),
                Container(height: 0.5, color: AppColors.outlineVariant),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('LIFETIME EARNINGS',
                              style: AppTextStyles.labelCaps.copyWith(
                                  fontSize: 8, color: AppColors.textGrey)),
                          const SizedBox(height: 2),
                          Text(stylist['earnings'],
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textDark)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('TOTAL SERVICES',
                              style: AppTextStyles.labelCaps.copyWith(
                                  fontSize: 8, color: AppColors.textGrey)),
                          const SizedBox(height: 2),
                          Text('${stylist['services']}',
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textDark)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(height: 0.5, color: AppColors.outlineVariant),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Manage Profile',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary)),
                        const SizedBox(width: 4),
                        Icon(Icons.arrow_forward_rounded,
                            size: 13, color: AppColors.primary),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _onboardSlotCard() {
    return CustomPaint(
      painter: _DashedBorderPainter(
        color: AppColors.outlineVariant,
        radius: 16,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: AppColors.surfaceContainer,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person_add_alt_outlined,
                    color: AppColors.primary, size: 26),
              ),
              const SizedBox(height: 12),
              const Text('Onboard New\nTalent',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark)),
              const SizedBox(height: 8),
              Text('Grow your fleet by adding\ncertified professionals.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMd.copyWith(fontSize: 15)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topBar() {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      color: AppColors.surface,
      child: Row(
        children: [
          Container(
            width: 260,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                SizedBox(width: 12),
                Icon(Icons.search, color: AppColors.textGrey, size: 18),
                SizedBox(width: 8),
                Text('Search stylists or specialties...',
                    style: TextStyle(fontSize: 13, color: AppColors.textGrey)),
              ],
            ),
          ),
          const Spacer(),
          const Icon(Icons.notifications_none_rounded,
              color: AppColors.textMid),
          const SizedBox(width: 16),
          const Icon(Icons.access_time_rounded, color: AppColors.textMid),
          const SizedBox(width: 16),
          Container(width: 1, height: 28, color: AppColors.outlineVariant),
          const SizedBox(width: 16),
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.surfaceContainer,
                child: const Icon(Icons.person,
                    color: AppColors.primary, size: 18),
              ),
              const SizedBox(width: 8),
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Admin Profile',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark)),
                  Text('Salon Manager',
                      style:
                          TextStyle(fontSize: 11, color: AppColors.textGrey)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double radius;

  _DashedBorderPainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );

    final path = Path()..addRRect(rrect);
    final dashPath = Path();
    const dashWidth = 6.0;
    const dashSpace = 4.0;

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        dashPath.addPath(
          metric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth + dashSpace;
      }
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}