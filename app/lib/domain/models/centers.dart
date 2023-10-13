import 'package:app/domain/models/town.dart';

class CenterVehicle {
  final String id;
  final String? name;
  final String? address;
  final Town? town;


  CenterVehicle({
    required this.id,
    this.name,
    this.address,
    this.town,
  });

  factory CenterVehicle.fromJson(Map<String, dynamic> json) {
    return CenterVehicle(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      town: Town.fromJson(json['town']),
    );
  }
}