class Stylist {
  final String name;
  final String specialty;
  final String initials;
  final String earnings;
  final int services;
  final double rating;

  Stylist({
    required this.name,
    required this.specialty,
    required this.initials,
    required this.earnings,
    required this.services,
    required this.rating,
  });

  factory Stylist.fromJson(Map<String, dynamic> json) {
    return Stylist(
      name: json['name'],
      specialty: json['specialty'],
      initials: json['initials'],
      earnings: json['earnings'],
      services: json['services'],
      rating: (json['rating'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'specialty': specialty,
        'initials': initials,
        'earnings': earnings,
        'services': services,
        'rating': rating,
      };
}