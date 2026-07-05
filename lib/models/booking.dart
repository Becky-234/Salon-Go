class Booking {
  final String id;
  final String initials;
  final String customer;
  final String phone;
  final String service;
  final int serviceColorValue;
  final String stylist;
  final String stylistInitials;
  final String date;
  final String time;
  final String status;
  final String amount;

  Booking({
    required this.id,
    required this.initials,
    required this.customer,
    required this.phone,
    required this.service,
    required this.serviceColorValue,
    required this.stylist,
    required this.stylistInitials,
    required this.date,
    required this.time,
    required this.status,
    required this.amount,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      initials: json['initials'],
      customer: json['customer'],
      phone: json['phone'],
      service: json['service'],
      serviceColorValue: json['serviceColorValue'],
      stylist: json['stylist'],
      stylistInitials: json['stylistInitials'],
      date: json['date'],
      time: json['time'],
      status: json['status'],
      amount: json['amount'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'initials': initials,
        'customer': customer,
        'phone': phone,
        'service': service,
        'serviceColorValue': serviceColorValue,
        'stylist': stylist,
        'stylistInitials': stylistInitials,
        'date': date,
        'time': time,
        'status': status,
        'amount': amount,
      };
}