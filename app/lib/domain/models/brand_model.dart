import 'brand.dart';

class BrandModel {

  final int id;
  final String name;
  final int releaseYear;
  final Brand brand;

  BrandModel({
    required this.id,
    required this.name,
    required this.releaseYear,
    required this.brand,
  });

  BrandModel copyWith({
    int? id,
    String? name,
    int? releaseYear,
    Brand? brand,
  }) {
    return BrandModel(
      id: id ?? this.id,
      name: name ?? this.name,
      releaseYear: releaseYear ?? this.releaseYear,
      brand: brand ?? this.brand,
    );
  }

  factory BrandModel.fromJson(Map<String, dynamic> json) => BrandModel(
    id: int.parse(json['id']),
    name: json['name'] as String,
    releaseYear: json['releaseYear'],
    brand: Brand.fromJson(json['brand']),
  );

}