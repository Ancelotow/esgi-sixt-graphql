class Brand {
  final int id;
  final String name;
  final String logoUri;

  Brand({
    required this.id,
    required this.name,
    required this.logoUri,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: int.parse(json['id']),
      name: json['name'],
      logoUri: json['logoUri'],
    );
  }
}