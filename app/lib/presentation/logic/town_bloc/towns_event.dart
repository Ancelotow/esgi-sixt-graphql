part of 'towns_bloc.dart';

@immutable
abstract class TownsEvent {}

class GetTownsEvent extends TownsEvent {
  GetTownsEvent();
}