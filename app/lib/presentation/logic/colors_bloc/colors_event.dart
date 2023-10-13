part of 'colors_bloc.dart';

@immutable
abstract class ColorsEvent {}

class GetColorsEvent extends ColorsEvent {
  GetColorsEvent();
}
