part of 'rents_bloc.dart';

@immutable
abstract class RentsEvent {}

class GetAllRents extends RentsEvent {
  GetAllRents();
}

class AddRent extends RentsEvent {
  final Rent rent;

  AddRent({
    required this.rent,
  });
}

class EditRent extends RentsEvent {
  final Rent rent;

  EditRent({
    required this.rent,
  });
}

class DetailRent extends RentsEvent {
  final String id;

  DetailRent({
    required this.id,
  });
}