import 'package:flutter/material.dart';
import 'package:saloon_go/core/theme.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  String _selectedStatus = 'All Statuses';
  String _selectedStylist = 'All Stylists';

  final List<Map<String, dynamic>> _bookings = [
    {
      'id': '#SG-9281',
      'initials': 'ZN',
      'customer': 'Zahara Namutebu',
      'phone': '+256 701 234',
      'service': 'Box Braid (Medium)',
      'serviceColor': Color(0xFF6B2DBF),
      'stylist': 'Aisha M.',
      'stylistInitials': 'AM',
      'date': 'Oct 24, 2023',
      'time': '10:30 AM',
      'status': 'CONFIRMED',
      'amount': 'UGX 120k',
    },
    {
      'id': '#SG-9280',
      'initials': 'JK',
      'customer': 'Joel Kato',
      'phone': '+256 750 087',
      'service': "Gent's Fade & Beard",
      'serviceColor': Color(0xFF10B981),
      'stylist': 'David O.',
      'stylistInitials': 'DO',
      'date': 'Oct 24, 2023',
      'time': '11:00 AM',
      'status': 'PENDING',
      'amount': 'UGX 45k',
    },
    {
      'id': '#SG-9275',
      'initials': 'MA',
      'customer': 'Mercy Akello',
      'phone': '+256 788 110',
      'service': 'Bridal Styling Pkg',
      'serviceColor': Color(0xFFF5A623),
      'stylist': 'Sarah K.',
      'stylistInitials': 'SK',
      'date': 'Oct 25, 2023',
      'time': '09:00 AM',
      'status': 'CONFIRMED',
      'amount': 'UGX 350k',
    },
    {
      'id': '#SG-9270',
      'initials': 'PO',
      'customer': 'Patrick Okello',
      'phone': '+256 750 100',
      'service': "Men's Manicure",
      'serviceColor': Color(0xFF4A1A8C),
      'stylist': 'Unassigned',
      'stylistInitials': '?',
      'date': 'Oct 25, 2023',
      'time': '02:00 PM',
      'status': 'CANCELLED',
      'amount': 'UGX 30k',
    },
  ];

  Color _statusColor(String status) {
    switch (status) {
      case 'CONFIRMED':
        return AppColors.success;
      case 'PENDING':
        return AppColors.accent;
      case 'CANCELLED':
        return AppColors.error;
      default:
        return AppColors.textGrey;
    }
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
                  // Header with Export CSV only
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Booking Management',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textDark,
                              )),
                          SizedBox(height: 4),
                          Text(
                              'Efficiently manage and track all salon appointments.',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.textGrey)),
                        ],
                      ),
                      // Export CSV button - Light purple background
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: AppColors.primary.withOpacity(0.2)),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.download_outlined,
                                size: 16, color: AppColors.primary),
                            SizedBox(width: 6),
                            Text('Export CSV',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primary)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Filters row - With shadow, no border
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.08),
                          blurRadius: 16,
                          offset: const Offset(0, 2),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // STATUS filter
                        Expanded(
                          child: _filterDropdown('STATUS', _selectedStatus,
                              ['All Statuses', 'Confirmed', 'Pending', 'Cancelled'],
                              (val) => setState(() => _selectedStatus = val!)),
                        ),
                        const SizedBox(width: 16),
                        // DATE RANGE filter
                        Expanded(
                          child: _dateFilter(),
                        ),
                        const SizedBox(width: 16),
                        // STYLIST filter
                        Expanded(
                          child: _filterDropdown('STYLIST', _selectedStylist,
                              ['All Stylists', 'Aisha M.', 'David O.', 'Sarah K.'],
                              (val) => setState(() => _selectedStylist = val!)),
                        ),
                        const SizedBox(width: 16),
                        // Apply Filters button
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.tune_rounded,
                                  color: Colors.white, size: 16),
                              SizedBox(width: 8),
                              Text('Apply Filters',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Table
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.06),
                          blurRadius: 24,
                          offset: const Offset(0, 4),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Table with horizontal scroll
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            width: 1100,
                            child: Column(
                              children: [
                                // Table header
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 14),
                                  decoration: BoxDecoration(
                                    color: AppColors.surfaceContainerLow,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      _headerCell('BOOKING ID', width: 100),
                                      _headerCell('CUSTOMER', width: 180),
                                      _headerCell('SERVICE', width: 150),
                                      _headerCell('STYLIST', width: 120),
                                      _headerCell('DATE & TIME', width: 150),
                                      _headerCell('STATUS', width: 110),
                                      _headerCell('AMOUNT', width: 100),
                                      _headerCell('ACTIONS', width: 80),
                                    ],
                                  ),
                                ),
                                // Table rows
                                ..._bookings.map((b) => _tableRow(b)),
                              ],
                            ),
                          ),
                        ),
                        // Pagination
                        _pagination(),
                      ],
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

  Widget _headerCell(String text, {double width = 100}) {
    return SizedBox(
      width: width,
      child: Text(text,
          style: AppTextStyles.labelCaps.copyWith(
              fontSize: 11, color: AppColors.textGrey)),
    );
  }

  Widget _tableRow(Map<String, dynamic> b) {
    final statusColor = _statusColor(b['status']);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: const BoxDecoration(
        border: Border(
            bottom: BorderSide(color: AppColors.outlineVariant, width: 0.5)),
      ),
      child: Row(
        children: [
          // Booking ID
          SizedBox(
            width: 100,
            child: Text(b['id'],
                style: AppTextStyles.bodyMd.copyWith(
                    fontWeight: FontWeight.w600, color: AppColors.textDark)),
          ),
          // Customer
          SizedBox(
            width: 180,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.surfaceContainer,
                  child: Text(b['initials'],
                      style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary)),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(b['customer'],
                          style: AppTextStyles.bodyMd.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textDark),
                          overflow: TextOverflow.ellipsis),
                      Text(b['phone'], style: AppTextStyles.labelCaps),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Service
          SizedBox(
            width: 150,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: (b['serviceColor'] as Color).withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(b['service'],
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: b['serviceColor'] as Color),
                  overflow: TextOverflow.ellipsis),
            ),
          ),
          // Stylist
          SizedBox(
            width: 120,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: AppColors.surfaceContainer,
                  child: Text(b['stylistInitials'],
                      style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary)),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(b['stylist'],
                      style: AppTextStyles.bodyMd,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
          // Date & Time
          SizedBox(
            width: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(b['date'],
                    style: AppTextStyles.bodyMd
                        .copyWith(color: AppColors.textDark)),
                Text(b['time'], style: AppTextStyles.labelCaps),
              ],
            ),
          ),
          // Status
          SizedBox(
            width: 110,
            child: Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(b['status'],
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: statusColor)),
              ],
            ),
          ),
          // Amount
          SizedBox(
            width: 100,
            child: Text(b['amount'],
                style: AppTextStyles.bodyMd.copyWith(
                    fontWeight: FontWeight.w600, color: AppColors.textDark)),
          ),
          // Actions
          SizedBox(
            width: 80,
            child: Row(
              children: [
                const Icon(Icons.visibility_outlined,
                    size: 18, color: AppColors.textGrey),
                const SizedBox(width: 8),
                const Icon(Icons.edit_outlined,
                    size: 18, color: AppColors.textGrey),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterDropdown(String label, String value, List<String> items,
      ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.labelCaps.copyWith(fontSize: 10)),
        const SizedBox(height: 4),
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.outlineVariant),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              items: items
                  .map((e) => DropdownMenuItem(
                      value: e, 
                      child: Text(e, style: AppTextStyles.bodyMd)))
                  .toList(),
              onChanged: onChanged,
              icon: const Icon(Icons.keyboard_arrow_down_rounded,
                  size: 18, color: AppColors.textGrey),
              style: AppTextStyles.bodyMd,
            ),
          ),
        ),
      ],
    );
  }

  Widget _dateFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('DATE RANGE', style: AppTextStyles.labelCaps.copyWith(fontSize: 10)),
        const SizedBox(height: 4),
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.outlineVariant),
          ),
          child: const Row(
            children: [
              Icon(Icons.calendar_today_outlined,
                  size: 14, color: AppColors.textGrey),
              SizedBox(width: 8),
              Text('Today, Oct 24', style: AppTextStyles.bodyMd),
            ],
          ),
        ),
      ],
    );
  }

  Widget _pagination() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Showing 1 to 4 of 128 bookings',
              style: AppTextStyles.bodyMd.copyWith(fontSize: 12)),
          Row(
            children: [
              _pageBtn(Icons.chevron_left_rounded),
              const SizedBox(width: 4),
              _pageNumBtn('1', true),
              const SizedBox(width: 4),
              _pageNumBtn('2', false),
              const SizedBox(width: 4),
              _pageNumBtn('3', false),
              const SizedBox(width: 4),
              _pageBtn(Icons.chevron_right_rounded),
            ],
          ),
        ],
      ),
    );
  }

  Widget _pageBtn(IconData icon) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.outlineVariant),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(icon, size: 18, color: AppColors.textGrey),
    );
  }

  Widget _pageNumBtn(String label, bool isActive) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : Colors.transparent,
        border: Border.all(
            color: isActive ? AppColors.primary : AppColors.outlineVariant),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Text(label,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isActive ? Colors.white : AppColors.textGrey)),
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
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                SizedBox(width: 12),
                Icon(Icons.search, color: AppColors.textGrey, size: 18),
                SizedBox(width: 8),
                Text('Search appointments, clients or styles...',
                    style: TextStyle(fontSize: 13, color: AppColors.textGrey)),
              ],
            ),
          ),
          const Spacer(),
          const Icon(Icons.notifications_none_rounded, color: AppColors.textMid),
          const SizedBox(width: 16),
          const Icon(Icons.access_time_rounded, color: AppColors.textMid),
          const SizedBox(width: 16),
          Container(
            width: 1,
            height: 28,
            color: AppColors.outlineVariant,
          ),
          const SizedBox(width: 16),
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.surfaceContainer,
                child: const Icon(Icons.person, color: AppColors.primary, size: 18),
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
                      style: TextStyle(fontSize: 11, color: AppColors.textGrey)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}