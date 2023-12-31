import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../domain/models/rents.dart';
import '../../../domain/repository/rents_repository.dart';

part 'rents_event.dart';
part 'rents_state.dart';

class RentsBloc extends Bloc<RentsEvent, RentsState> {
  final RentsRepository repository;

  RentsBloc(this.repository) : super(RentsState()) {
    on<GetAllRents>((event, emit) async {
      emit(state.copyWith(status: RentsStatus.loading));
      try {
        final rents = await repository.getAllRents();
        print("rentgs : $rents");
        emit(state.copyWith(status: RentsStatus.success, rents: rents));
      } catch (e) {
        print(e);
        String errorMessage = e.toString().replaceAll('Exception: ', '');
        emit(state.copyWith(error: errorMessage, status: RentsStatus.error));
      }
    });

    on<AddRent>((event, emit) async {
      emit(state.copyWith(status: RentsStatus.loading));
      try {
        await repository.addRent(event.rent);
        emit(state.copyWith(status: RentsStatus.editSuccess));
      } catch (e) {
        String errorMessage = e.toString().replaceAll('Exception: ', '');
        emit(state.copyWith(error: errorMessage, status: RentsStatus.error));
      }
    });

    on<EditRent>((event, emit) async {
      emit(state.copyWith(status: RentsStatus.loading));
      try {
        await repository.editRent(event.rent);
        emit(state.copyWith(status: RentsStatus.editSuccess));
      } catch (e) {
        String errorMessage = e.toString().replaceAll('Exception: ', '');
        emit(state.copyWith(error: errorMessage, status: RentsStatus.error));
      }
    });

    on<DetailRent>((event, emit) async {
      emit(state.copyWith(status: RentsStatus.loading));
      try {
        await repository.detailRent(event.id);
        emit(state.copyWith(status: RentsStatus.success));
      } catch (e) {
        String errorMessage = e.toString().replaceAll('Exception: ', '');
        emit(state.copyWith(error: errorMessage, status: RentsStatus.error));
      }
    });
  }
}
