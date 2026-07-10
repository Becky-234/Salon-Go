import 'package:flutter/material.dart';
import 'package:saloon_go/core/theme.dart';
import 'package:saloon_go/models/inventory_item.dart';
import 'package:saloon_go/repositories/inventory_repository.dart';
import 'package:saloon_go/widgets/earnings_chart.dart';
import 'package:saloon_go/widgets/recent_activity.dart';
import 'package:saloon_go/widgets/stat_card.dart';
import 'package:saloon_go/widgets/top_stylists.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final TextEditingController _searchController = TextEditingController();
  final InventoryRepository _inventoryRepository = InventoryRepository();
  late Future<List<InventoryItem>> _inventoryFuture;

  @override
  void initState() {
    super.initState();
    _inventoryFuture = _inventoryRepository.fetchLowStockItems();
  }

  void _onSearchChanged(String query) {
    debugPrint('Search query: $query');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
                  Text('Overview Dashboard',
                      style: AppTextStyles.display.copyWith(fontSize: 24)),
                  const SizedBox(height: 4),
                  Text('Welcome back. Here\'s what\'s happening at SalonGo today.',
                      style: AppTextStyles.bodyMd),
                  const SizedBox(height: 24),
                  // Stat Cards
                  Row(
                    children: [
                      Expanded(
                        child: StatCard(
                          label: 'Total Revenue',
                          value: 'UGX 4.2M',
                          icon: Icons.payments_outlined,
                          badgeType: StatCardBadgeType.pill,
                          badgeText: '+18%',
                          badgeColor: AppColors.success,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: StatCard(
                          label: 'Active Stylists',
                          value: '24',
                          icon: Icons.content_cut_outlined,
                          badgeType: StatCardBadgeType.text,
                          badgeText: '8 on duty',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: StatCard(
                          label: 'Completed Bookings',
                          value: '158',
                          icon: Icons.check_circle_outline_rounded,
                          badgeType: StatCardBadgeType.pill,
                          badgeText: 'Today',
                          badgeColor: AppColors.accent,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: StatCard(
                          label: 'Customer Rating',
                          value: '4.9',
                          icon: Icons.star_outline_rounded,
                          badgeType: StatCardBadgeType.stars,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Chart + Activity — a bounded-height SizedBox (not
                  // IntrinsicHeight) so both cards stretch to match. fl_chart
                  // uses a LayoutBuilder internally, which throws if asked
                  // for intrinsic dimensions, so IntrinsicHeight isn't safe
                  // here. A fixed height passed down via BoxConstraints
                  // avoids that entirely.
                  //
                  // NOTE: 360 is a starting point — if RecentActivity ever
                  // gets more mock items than fit, its list scrolls inside
                  // this height rather than overflowing (see
                  // recent_activity.dart), so tweak this number to taste
                  // rather than removing the SizedBox.
                  SizedBox(
                    height: 360,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: const [
                        Expanded(flex: 3, child: EarningsChart()),
                        SizedBox(width: 16),
                        Expanded(flex: 2, child: RecentActivity()),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Top Stylists + Inventory
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(flex: 2, child: TopStylists()),
                      const SizedBox(width: 16),
                      Expanded(flex: 2, child: _inventoryAlert()),
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
                    onChanged: _onSearchChanged,
                    style: const TextStyle(fontSize: 13, color: AppColors.textDark),
                    decoration: const InputDecoration(
                      hintText: 'Search appointments, clients or styles...',
                      hintStyle: TextStyle(fontSize: 13, color: AppColors.textGrey),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          const Icon(Icons.notifications_none_rounded, color: AppColors.textMid),
          const SizedBox(width: 16),
          const Icon(Icons.access_time_rounded, color: AppColors.textMid),
          const SizedBox(width: 16),
          // Separator
          Container(
            width: 1,
            height: 28,
            color: AppColors.outlineVariant,
          ),
          const SizedBox(width: 16),
          Row(
            children: [
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
                      style: TextStyle(fontSize: 11, color: AppColors.textGrey)),
                ],
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.accent, width: 2),
                ),
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.surfaceContainer,
                  child: const Icon(Icons.person, color: AppColors.primary, size: 18),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _inventoryAlert() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.sidebar,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Inventory Alert',
                  style: AppTextStyles.headlineMd.copyWith(
                      fontSize: 14, color: Colors.white)),
              const SizedBox(height: 8),
              // Body driven by the repository via FutureBuilder
              FutureBuilder<List<InventoryItem>>(
                future: _inventoryFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Center(
                        child: CircularProgressIndicator(color: AppColors.accent),
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'Could not load inventory: ${snapshot.error}',
                        style: const TextStyle(fontSize: 12, color: Color(0xFFD4BCFA)),
                      ),
                    );
                  }

                  final items = snapshot.data ?? [];

                  if (items.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'All stock levels look healthy.',
                        style: TextStyle(fontSize: 12, color: Color(0xFFD4BCFA)),
                      ),
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${items.length} hair care products are running low. Orders should be placed within 48 hours to avoid service delays.',
                        style: const TextStyle(fontSize: 12, color: Color(0xFFD4BCFA)),
                      ),
                      const SizedBox(height: 16),
                      ...items.map((item) => _inventoryRow(item)),
                    ],
                  );
                },
              ),
              const SizedBox(height: 16),
              FractionallySizedBox(
                widthFactor: 0.4,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text('Manage Inventory',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.accentDark)),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Half-outside icon top right
        Positioned(
          top: -14,
          right: 16,
          child: Container(
            width: 34,
            height: 34,
            decoration: const BoxDecoration(
              color: AppColors.accent,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.chat_bubble_outline_rounded,
                color: AppColors.accentDark, size: 18),
          ),
        ),
      ],
    );
  }

  Widget _inventoryRow(InventoryItem item) {
    final bool isEmpty = item.units == 0;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.07),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(item.name,
                  style: const TextStyle(fontSize: 13, color: Colors.white)),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: isEmpty ? AppColors.error : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border: isEmpty
                    ? null
                    : Border.all(color: AppColors.accent, width: 1.2),
              ),
              child: Text(
                isEmpty ? '0 UNITS LEFT' : '${item.units} UNITS LEFT',
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: isEmpty ? Colors.white : AppColors.accent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}