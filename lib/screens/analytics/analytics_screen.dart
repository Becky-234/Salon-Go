import 'package:flutter/material.dart';
import 'package:saloon_go/core/theme.dart';
import 'dart:math' as math;
import 'package:saloon_go/models/cohort_month.dart';
import 'package:saloon_go/models/service_stat.dart';
import 'package:saloon_go/models/stylist_efficiency.dart';
import 'package:saloon_go/repositories/analytics_repository.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AnalyticsRepository _repository = AnalyticsRepository();

  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  late Future<List<ServiceStat>> _servicesFuture;
  late Future<List<StylistEfficiency>> _stylistsFuture;
  late Future<List<CohortMonth>> _cohortsFuture;

  @override
  void initState() {
    super.initState();
    _loadFiltered();
    // Cohorts aren't affected by the search box, so load them once.
    _cohortsFuture = _repository.fetchCohorts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadFiltered() {
    setState(() {
      _servicesFuture = _repository.fetchFilteredServices(query: _searchQuery);
      _stylistsFuture =
          _repository.fetchFilteredStylistEfficiency(query: _searchQuery);
    });
  }

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
                          Text('Booking Insights',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textDark,
                              )),
                          SizedBox(height: 4),
                          Text(
                              'Strategic overview of SalonGo\'s Kampala performance.',
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
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.outlineVariant),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.calendar_today_outlined,
                                    size: 14, color: AppColors.textGrey),
                                SizedBox(width: 8),
                                Text('Last 30 Days',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textDark)),
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
                                Icon(Icons.download_outlined,
                                    color: Colors.white, size: 16),
                                SizedBox(width: 8),
                                Text('Export Report',
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
                      Expanded(
                        child: _statCard(
                          'TOTAL BOOKINGS',
                          '2,845',
                          '+14%',
                          AppColors.accent,
                          Icons.calendar_today_outlined,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _statCard(
                          'REVENUE (UGX)',
                          '84.2M',
                          '+13%',
                          AppColors.accent,
                          Icons.payments_outlined,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _statCard(
                          'ACTIVE STYLISTS',
                          '142',
                          '-21%',
                          AppColors.error,
                          Icons.content_cut_outlined,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _statCard(
                          'AVG. RATING',
                          '98.2%',
                          null,
                          null,
                          Icons.star_outline_rounded,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 7, child: _bookingDensityCard()),
                      const SizedBox(width: 16),
                      Expanded(flex: 3, child: _popularServicesCard()),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _cohortsCard(),
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 1, child: _topStylistEfficiencyCard()),
                      const SizedBox(width: 16),
                      Expanded(flex: 1, child: _peakBookingTimesCard()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard(
      String label, String value, String? badge, Color? badgeColor, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(18),
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
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: AppColors.primary, size: 20),
              ),
              if (badge != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: (badgeColor ?? AppColors.accent).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: badgeColor ?? AppColors.accent,
                      width: 1.2,
                    ),
                  ),
                  child: Text(badge,
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: badgeColor ?? AppColors.accent)),
                ),
            ],
          ),
          const SizedBox(height: 14),
          Text(label.toUpperCase(),
              style: AppTextStyles.labelCaps
                  .copyWith(fontSize: 10, color: AppColors.textDark)),
          const SizedBox(height: 4),
          Text(value,
              style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary)),
        ],
      ),
    );
  }

  Widget _bookingDensityCard() {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Booking Density: Kampala',
                      style: AppTextStyles.headlineMd.copyWith(fontSize: 15)),
                  Text('Real-time demand map across city sectors',
                      style: AppTextStyles.bodyMd.copyWith(fontSize: 12)),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainer,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text('L',
                          style: AppTextStyles.labelCaps.copyWith(
                              fontSize: 9, color: AppColors.textGrey)),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text('H',
                          style: AppTextStyles.labelCaps
                              .copyWith(fontSize: 9, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(12),
            ),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
              ),
              itemCount: 32,
              itemBuilder: (context, index) {
                final intensity = (index * 37) % 100 / 100;
                return Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1 + intensity * 0.75),
                    borderRadius: BorderRadius.circular(6),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Icon(Icons.map_outlined,
                color: AppColors.outlineVariant, size: 64),
          ),
        ],
      ),
    );
  }

  Widget _popularServicesCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: AppColors.primary.withOpacity(0.2),
              blurRadius: 24,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Popular Services',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white)),
          const Text('Volume share by category',
              style: TextStyle(fontSize: 11, color: Color(0xFFD4BCFA))),
          const SizedBox(height: 20),
          FutureBuilder<List<ServiceStat>>(
            future: _servicesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                );
              }

              if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text('Error loading services: ${snapshot.error}',
                      style: const TextStyle(
                          fontSize: 12, color: Color(0xFFD4BCFA))),
                );
              }

              final services = snapshot.data ?? [];

              if (services.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text('No services match "$_searchQuery"',
                      style: const TextStyle(
                          fontSize: 12, color: Color(0xFFD4BCFA))),
                );
              }

              return Column(
                children: services.map((s) => _serviceBar(s)).toList(),
              );
            },
          ),
          const SizedBox(height: 12),
          CustomPaint(
            size: const Size(60, 60),
            painter: _SunPainter(),
          ),
        ],
      ),
    );
  }

  Widget _serviceBar(ServiceStat s) {
    final percent = s.percent;
    final goldOpacity = 0.4 + (percent / 100) * 0.6;
    final goldColor = Color.lerp(
      const Color(0xFFF5A623).withOpacity(0.4),
      const Color(0xFFF5A623),
      percent / 48.0,
    )!;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(s.name,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: percent / 100,
                    minHeight: 6,
                    backgroundColor: Colors.white.withOpacity(0.15),
                    valueColor: AlwaysStoppedAnimation(goldColor),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text('$percent%',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white.withOpacity(goldOpacity))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _cohortsCard() {
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Retention & Loyalty Cohorts',
                      style: AppTextStyles.headlineMd.copyWith(fontSize: 15)),
                  Text('Customer behavior by acquisition month',
                      style: AppTextStyles.bodyMd.copyWith(fontSize: 12)),
                ],
              ),
              Row(
                children: [
                  _legendDot(AppColors.primary, 'High LTV'),
                  const SizedBox(width: 12),
                  _legendDot(AppColors.surfaceContainer, 'At Risk'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const SizedBox(
                  width: 130,
                  child: Text('COHORT MONTH',
                      style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textGrey))),
              const SizedBox(
                  width: 90,
                  child: Text('NEW CUSTOMERS',
                      style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textGrey))),
              ...List.generate(
                  6,
                  (i) => Expanded(
                        child: Center(
                          child: Text('M$i',
                              style: const TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textGrey)),
                        ),
                      )),
            ],
          ),
          const SizedBox(height: 8),
          FutureBuilder<List<CohortMonth>>(
            future: _cohortsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                );
              }

              if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text('Error loading cohorts: ${snapshot.error}',
                      style: AppTextStyles.bodyMd),
                );
              }

              final cohorts = snapshot.data ?? [];
              return Column(
                children: cohorts.map((c) => _cohortRow(c)).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _legendDot(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label, style: AppTextStyles.labelCaps.copyWith(fontSize: 9)),
      ],
    );
  }

  Widget _cohortRow(CohortMonth c) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
              width: 130,
              child: Text(c.month,
                  style: AppTextStyles.bodyMd.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark))),
          SizedBox(
              width: 90,
              child: Text('${c.newCustomers}', style: AppTextStyles.bodyMd)),
          ...c.values.map((v) => Expanded(
                child: Center(
                  child: v == null
                      ? const SizedBox()
                      : Container(
                          width: 36,
                          height: 28,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: v >= 70
                                ? AppColors.primary
                                : v >= 50
                                    ? AppColors.primaryContainer.withOpacity(0.5)
                                    : AppColors.surfaceContainer,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text('$v%',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: v >= 70
                                      ? Colors.white
                                      : AppColors.textDark)),
                        ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _topStylistEfficiencyCard() {
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
              Text('Top Stylist Efficiency',
                  style: AppTextStyles.headlineMd.copyWith(fontSize: 15)),
              Text('VIEW ALL',
                  style: AppTextStyles.labelCaps
                      .copyWith(color: AppColors.primary, fontSize: 10)),
            ],
          ),
          const SizedBox(height: 16),
          FutureBuilder<List<StylistEfficiency>>(
            future: _stylistsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                );
              }

              if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text('Error loading stylists: ${snapshot.error}',
                      style: AppTextStyles.bodyMd),
                );
              }

              final stylists = snapshot.data ?? [];

              if (stylists.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      const Icon(Icons.search_off_rounded,
                          color: AppColors.outlineVariant, size: 20),
                      const SizedBox(width: 8),
                      Text('No stylists match "$_searchQuery"',
                          style: AppTextStyles.bodyMd),
                    ],
                  ),
                );
              }

              return Column(
                children: stylists.map((s) => _stylistEfficiencyRow(s)).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _stylistEfficiencyRow(StylistEfficiency s) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.surfaceContainer,
            child: Text(
                s.name.split(' ').map((e) => e[0]).take(2).join(),
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(s.name,
                    style: AppTextStyles.bodyMd.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark)),
                const SizedBox(height: 4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: s.utilization,
                    minHeight: 5,
                    backgroundColor: AppColors.surfaceContainer,
                    valueColor:
                        const AlwaysStoppedAnimation(AppColors.primary),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text('${(s.utilization * 100).toInt()}% Utilization',
              style: AppTextStyles.labelCaps.copyWith(fontSize: 10)),
        ],
      ),
    );
  }

  Widget _peakBookingTimesCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 180,
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
          Text('Peak Booking Times',
              style: AppTextStyles.headlineMd.copyWith(fontSize: 15)),
          const SizedBox(height: 16),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [9, 11, 13, 15, 17, 19, 21].map((hour) {
                final height = ((hour * 17) % 60 + 20).toDouble();
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 14,
                      height: height,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainer,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text('${hour}H',
                        style:
                            AppTextStyles.labelCaps.copyWith(fontSize: 8)),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
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
            width: 560,
            height: 38,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: AppColors.textGrey, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (val) {
                      setState(() => _searchQuery = val);
                      _loadFiltered();
                    },
                    style: const TextStyle(
                        fontSize: 13, color: AppColors.textDark),
                    decoration: const InputDecoration(
                      hintText: 'Search stylists, services...',
                      hintStyle: TextStyle(
                          fontSize: 13, color: AppColors.textGrey),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
                if (_searchQuery.isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      _searchController.clear();
                      setState(() => _searchQuery = '');
                      _loadFiltered();
                    },
                    child: const Icon(Icons.close,
                        size: 16, color: AppColors.textGrey),
                  ),
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
                      style: TextStyle(
                          fontSize: 11, color: AppColors.textGrey)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SunPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.25)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.22;

    canvas.drawCircle(center, radius, paint);

    final lineLengths = [8.0, 12.0, 6.0, 14.0, 9.0, 13.0, 7.0, 11.0];
    final count = lineLengths.length;
    for (int i = 0; i < count; i++) {
      final angle = (i * 2 * 3.14159) / count;
      final start = Offset(
        center.dx + (radius + 4) * math.cos(angle),
        center.dy + (radius + 4) * math.sin(angle),
      );
      final end = Offset(
        center.dx + (radius + 4 + lineLengths[i]) * math.cos(angle),
        center.dy + (radius + 4 + lineLengths[i]) * math.sin(angle),
      );
      canvas.drawLine(start, end, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}