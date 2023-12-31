import 'package:app/domain/models/brand_model.dart';
import 'package:app/domain/models/color.dart';
import 'centers.dart';

class Vehicle {
  final String id;
  final String? number_plate;
  final int? nb_places;
  final int? kilometrage;
  final bool? is_air_conditioner;
  final int? amount_excluding;
  final int? max_charge;
  final int? max_speed_allowed;
  final BrandModel? model;
  final VehicleColor? color;
  final CenterVehicle? center;
  final String? transmission;
  final String? imageUri;


  Vehicle({
    required this.id,
    this.number_plate,
    this.nb_places,
    this.kilometrage,
    this.is_air_conditioner,
    this.amount_excluding,
    this.max_charge,
    this.max_speed_allowed,
    this.model,
    this.color,
    this.center,
    this.transmission,
    this.imageUri,
  });

  Vehicle copyWith({
    String? id,
    String? number_plate,
    int? nb_places,
    int? kilometrage,
    bool? is_air_conditioner,
    int? amount_excluding,
    int? max_charge,
    int? max_speed_allowed,
    BrandModel? model,
    VehicleColor? color,
    CenterVehicle? center,
    String? transmission,
    String? imageUri,
  }) {
    return Vehicle(
      id: id ?? this.id,
      number_plate: number_plate ?? this.number_plate,
      nb_places: nb_places ?? this.nb_places,
      kilometrage: kilometrage ?? this.kilometrage,
      is_air_conditioner: is_air_conditioner ?? this.is_air_conditioner,
      amount_excluding: amount_excluding ?? this.amount_excluding,
      max_charge: max_charge ?? this.max_charge,
      max_speed_allowed: max_speed_allowed ?? this.max_speed_allowed,
      model: model ?? this.model,
      color: color ?? this.color,
      center: center ?? this.center,
      transmission: transmission ?? this.transmission,
      imageUri: imageUri ?? this.imageUri,
    );
  }

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      number_plate: json['number_plate'],
      nb_places: json['nb_places'],
      kilometrage: json['kilometrage'],
      is_air_conditioner: json['is_air_conditioner'],
      amount_excluding: json['amount_excluding'],
      max_charge: json['max_charge'],
      max_speed_allowed: json['max_speed_allowed'],
      model: (json['model'] != null) ? BrandModel.fromJson(json['model']) : null,
      color: (json['color'] != null) ? VehicleColor.fromJson(json['color']) : null,
      center: (json['center'] != null) ? CenterVehicle.fromJson(json['center']) : null,
      transmission: json['transmission'],
      imageUri: json['imageUri'],
    );
  }
}