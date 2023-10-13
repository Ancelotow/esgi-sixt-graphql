import 'package:flutter/material.dart';
import '../domain/models/centers.dart';

abstract class CenterDataSource {

  Future<List<CenterVehicle>> getCenters();

  Future<CenterVehicle> addCenter(CenterVehicle center);

}