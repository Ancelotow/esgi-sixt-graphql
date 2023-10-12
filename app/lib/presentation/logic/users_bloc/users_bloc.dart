import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../domain/models/users.dart';
import '../../../domain/repository/users_repository.dart';

part 'users_event.dart';

part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UsersRepository repository;

  UsersBloc(this.repository) : super(UsersState()) {
    on<AddUser>((event, emit) async {
      emit(state.copyWith(status: UsersStatus.loading));
      try {
        await repository.addUser(event.user);
        emit(state.copyWith(status: UsersStatus.editSuccess));
      } catch (e) {
        String errorMessage = e.toString().replaceAll('Exception: ', '');
        emit(state.copyWith(error: errorMessage, status: UsersStatus.error));
      }
    });

    on<EditUser>((event, emit) async {
      emit(state.copyWith(status: UsersStatus.loading));
      try {
        await repository.editUser(event.user);
        emit(state.copyWith(status: UsersStatus.editSuccess));
      } catch (e) {
        String errorMessage = e.toString().replaceAll('Exception: ', '');
        emit(state.copyWith(error: errorMessage, status: UsersStatus.error));
      }
    });

    on<LoginUser>((event, emit) async {
      emit(state.copyWith(status: UsersStatus.loading));
      try {
        await repository.loginUser(event.user);
        emit(state.copyWith(status: UsersStatus.success));
      } catch (e) {
        String errorMessage = e.toString().replaceAll('Exception: ', '');
        emit(state.copyWith(error: errorMessage, status: UsersStatus.error));
      }
    });

    on<ProfilUser>((event, emit) async {
      emit(state.copyWith(status: UsersStatus.loading));
      try {
        await repository.profilUser(event.pseudo);
        emit(state.copyWith(status: UsersStatus.success));
      } catch (e) {
        String errorMessage = e.toString().replaceAll('Exception: ', '');
        emit(state.copyWith(error: errorMessage, status: UsersStatus.error));
      }
    });
  }
}
