import 'package:flutter/material.dart';
import 'package:saloon_go/core/theme.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> _services = [
    {'name': 'Braids & Twists', 'percent': 48, 'color': AppColors.primary},
    {'name': 'Nails & Pedicure', 'percent': 24, 'color': AppColors.accent},
    {'name': 'Bridal Makeup', 'percent': 18, 'color': AppColors.primaryContainer},
    {'name': 'Facials & Spa', 'percent': 10, 'color': AppColors.success},
  ];

  final List<Map<String, dynamic>> _cohorts = [
    {
      'month': 'January 2024',
      'newCustomers': 420,
      'values': [100, 78, 65, 52, 28, 41]
    },
    {
      'month': 'February 2024',
      'newCustomers': 512,
      'values': [100, 82, 68, 55, 48, null]
    },
    {
      'month': 'March 2024',
      'newCustomers': 488,
      'values': [100, 75, 60, null, null, null]
    },
  ];

  final List<Map<String, dynamic>> _allStylists = [
    {'name': 'Nakato Sarah', 'utilization': 0.95},
    {'name': 'Mukisa David', 'utilization': 0.88},
  ];

  // Filter stylists by search query
  List<Map<String, dynamic>> get _filteredStylists {
    if (_searchQuery.isEmpty) return _allStylists;
    final q = _searchQuery.toLowerCase();
    return _allStylists
        .where((s) => s['name'].toString().toLowerCase().contains(q))
        .toList();
  }

  // Filter services by search query
  List<Map<String, dynamic>> get _filteredServices {
    if (_searchQuery.isEmpty) return _services;
    final q = _searchQuery.toLowerCase();
    return _services
        .where((s) => s['name'].toString().toLowerCase().contains(q))
        .toList();
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
                      Expanded(flex: 3, child: _bookingDensityCard()),
                      const SizedBox(width: 16),
                      Expanded(flex: 2, child: _popularServicesCard()),
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
              Text('Booking Density: Kampala',
                  style: AppTextStyles.headlineMd.copyWith(fontSize: 15)),
              Row(
                children: [
                  Text('Low',
                      style: AppTextStyles.labelCaps.copyWith(fontSize: 9)),
                  const SizedBox(width: 4),
                  Container(
                    width: 40,
                    height: 6,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [
                        AppColors.surfaceContainer,
                        AppColors.primary,
                      ]),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text('High',
                      style: AppTextStyles.labelCaps.copyWith(fontSize: 9)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text('Real-time demand map across city sectors',
              style: AppTextStyles.bodyMd.copyWith(fontSize: 12)),
          const SizedBox(height: 16),
          GridView.builder(
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
                  color: AppColors.primary.withOpacity(0.15 + intensity * 0.7),
                  borderRadius: BorderRadius.circular(6),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          Center(
            child: Icon(Icons.map_outlined,
                color: AppColors.outlineVariant, size: 28),
          ),
        ],
      ),
    );
  }

  Widget _popularServicesCard() {
    final services = _filteredServices;
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
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white)),
          const Text('Volume share by category',
              style: TextStyle(fontSize: 11, color: Color(0xFFD4BCFA))),
          const SizedBox(height: 20),
          if (services.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text('No services match "$_searchQuery"',
                  style: const TextStyle(
                      fontSize: 12, color: Color(0xFFD4BCFA))),
            )
          else
            ...services.map((s) => _serviceBar(s)),
          const SizedBox(height: 8),
          Center(
            child: Icon(Icons.pie_chart_outline_rounded,
                color: Colors.white.withOpacity(0.3), size: 40),
          ),
        ],
      ),
    );
  }

  Widget _serviceBar(Map<String, dynamic> s) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(s['name'],
                  style: const TextStyle(fontSize: 12, color: Colors.white)),
              Text('${s['percent']}%',
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: s['percent'] / 100,
              minHeight: 6,
              backgroundColor: Colors.white.withOpacity(0.15),
              valueColor: AlwaysStoppedAnimation(s['color'] as Color),
            ),
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
          ..._cohorts.map((c) => _cohortRow(c)),
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

  Widget _cohortRow(Map<String, dynamic> c) {
    final values = c['values'] as List;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
              width: 130,
              child: Text(c['month'],
                  style: AppTextStyles.bodyMd.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark))),
          SizedBox(
              width: 90,
              child:
                  Text('${c['newCustomers']}', style: AppTextStyles.bodyMd)),
          ...values.map((v) => Expanded(
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
    final stylists = _filteredStylists;
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
          if (stylists.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Icon(Icons.search_off_rounded,
                      color: AppColors.outlineVariant, size: 20),
                  const SizedBox(width: 8),
                  Text('No stylists match "$_searchQuery"',
                      style: AppTextStyles.bodyMd),
                ],
              ),
            )
          else
            ...stylists.map((s) => _stylistEfficiencyRow(s)),
        ],
      ),
    );
  }

  Widget _stylistEfficiencyRow(Map<String, dynamic> s) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.surfaceContainer,
            child: Text(
                s['name']
                    .toString()
                    .split(' ')
                    .map((e) => e[0])
                    .take(2)
                    .join(),
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
                Text(s['name'],
                    style: AppTextStyles.bodyMd.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark)),
                const SizedBox(height: 4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: s['utilization'],
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
          Text('${(s['utilization'] * 100).toInt()}% Utilization',
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
                      debugPrint('Analytics search: $val');
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