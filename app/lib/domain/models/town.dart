class Town {
  final String name;
  final String inseeCode;
  final String zipCode;

  Town({
    required this.name,
    required this.inseeCode,
    required this.zipCode,
  });

  factory Town.fromJson(Map<String, dynamic> json) {
    return Town(
      name: json['name'] as String,
      inseeCode: json['inseeCode'] as String,
      zipCode: json['zipCode'] as String,
    );
  }
}