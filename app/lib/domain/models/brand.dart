class Brand {
  final String id;
  final String name;
  final String logoUri;
  final int? releaseYear;

  Brand({
    required this.id,
    required this.name,
    required this.logoUri,
    this.releaseYear,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: int.parse(json['id']),
      name: json['name'],
      logoUri: json['logoUri'],
    );
  }
}