part of 'centers_bloc.dart';

@immutable
abstract class CentersEvent {}

class GetAllCenters extends CentersEvent {
  GetAllCenters();
}

class AddCenter extends CentersEvent {
  final CenterVehicle center;

  AddCenter(this.center);
}