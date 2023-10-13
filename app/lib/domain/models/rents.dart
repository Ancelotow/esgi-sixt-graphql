import 'package:app/domain/models/session.dart';
import 'package:app/domain/models/vehicles.dart';

class Rent {
  final String id;
  final int nbDays;
  final int amountExcluding;
  final int? vatRate;
  final String? rentAt;
  final String? createdAt;
  final int vehicleId;
  final Vehicle? vehicle;
  final int? userId;
  final String status;


  Rent({
    required this.id,
    required this.nbDays,
    required this.amountExcluding,
    this.vatRate,
    this.rentAt,
    this.createdAt,
    this.vehicle,
    required this.vehicleId,
    this.userId,
    required this.status,
  });

  Rent copyWith({
    String? id,
    int? nbDays,
    int? amountExcluding,
    int? vatRate,
    String? rentAt,
    String? createdAt,
    int? vehicleId,
    Vehicle? vehicle,
    int? userId,
    String? status,
  }) {
    return Rent(
      id: id ?? this.id,
      nbDays: nbDays ?? this.nbDays,
      amountExcluding: amountExcluding ?? this.amountExcluding,
      vatRate: vatRate ?? this.vatRate,
      rentAt: rentAt ?? this.rentAt,
      createdAt: createdAt ?? this.createdAt,
      vehicleId: vehicleId ?? this.vehicleId,
      vehicle: vehicle ?? this.vehicle,
      userId: userId ?? this.userId,
      status: status ?? this.status,
    );
  }

  factory Rent.fromJson(Map<String, dynamic> json) {
    return Rent(
      id: json['id'],
      nbDays: json['nbDays'],
      amountExcluding: json['amountExcluding'],
      vatRate: 20,
      rentAt: json['rentAt'],
      createdAt: json['createdAt'],
      vehicleId: int.parse(json['vehicle']['id']),
      vehicle: json['vehicle'] != null ? Vehicle.fromJson(json['vehicle']) : null,
      status: json['status'],
    );
  }
}