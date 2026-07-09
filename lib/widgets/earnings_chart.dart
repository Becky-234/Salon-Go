import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:saloon_go/core/theme.dart';

class EarningsChart extends StatefulWidget {
  const EarningsChart({super.key});

  @override
  State<EarningsChart> createState() => _EarningsChartState();
}

class _EarningsChartState extends State<EarningsChart> {
  bool showRevenue = true;

  final List<Map<String, dynamic>> data = const [
    {'week': 'WEEK 01', 'bar1': 500000.0, 'bar2': 350000.0},
    {'week': 'WEEK 02', 'bar1': 1200000.0, 'bar2': 800000.0},
    {'week': 'WEEK 03', 'bar1': 480000.0, 'bar2': 320000.0},
    {'week': 'WEEK 04', 'bar1': 900000.0, 'bar2': 600000.0},
  ];

  final List<Map<String, dynamic>> ordersData = const [
    {'week': 'WEEK 01', 'bar1': 28.0, 'bar2': 18.0},
    {'week': 'WEEK 02', 'bar1': 45.0, 'bar2': 30.0},
    {'week': 'WEEK 03', 'bar1': 22.0, 'bar2': 15.0},
    {'week': 'WEEK 04', 'bar1': 38.0, 'bar2': 25.0},
  ];

  @override
  Widget build(BuildContext context) {
    final currentData = showRevenue ? data : ordersData;
    final maxVal = showRevenue ? 1400000.0 : 55.0;

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
                  Text('Earnings Trend',
                      style: AppTextStyles.headlineMd.copyWith(fontSize: 15)),
                  Text('Financial performance over the last 30 days',
                      style: AppTextStyles.bodyMd.copyWith(fontSize: 12)),
                ],
              ),
              // Whole toggle track is light purple — top, bottom, and
              // both sides around the active pill.
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    _toggleBtn('Revenue', true),
                    _toggleBtn('Orders', false),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: maxVal,
                groupsSpace: 24,
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (_) => AppColors.primary,
                    tooltipPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    tooltipMargin: 8,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      final val = rod.toY;
                      final label = showRevenue
                          ? 'UGX ${(val / 1000).toStringAsFixed(0)}k'
                          : '${val.toInt()} orders';
                      return BarTooltipItem(
                        label,
                        const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 32,
                      getTitlesWidget: (value, meta) {
                        final label =
                            currentData[value.toInt()]['week'] as String;
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(label,
                              style: AppTextStyles.labelCaps
                                  .copyWith(fontSize: 9)),
                        );
                      },
                    ),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: maxVal / 4,
                  getDrawingHorizontalLine: (value) => const FlLine(
                    color: AppColors.outlineVariant,
                    strokeWidth: 0.5,
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: currentData.asMap().entries.map((e) {
                  final isHighlight = e.key == 1;
                  final bar1 = e.value['bar1'] as double;
                  return BarChartGroupData(
                    x: e.key,
                    barRods: [
                      BarChartRodData(
                        toY: bar1,
                        color: isHighlight
                            ? AppColors.accent
                            : AppColors.surfaceContainer,
                        width: 32,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _toggleBtn(String label, bool isRevenue) {
    final bool isActive = showRevenue == isRevenue;
    return GestureDetector(
      onTap: () => setState(() => showRevenue = isRevenue),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          // Active pill sits on top of the light purple track; inactive
          // is transparent so the track shows through underneath it.
          color: isActive ? AppColors.surface : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.10),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isActive ? AppColors.textDark : AppColors.textGrey,
          ),
        ),
      ),
    );
  }
}