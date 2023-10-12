part of 'users_bloc.dart';

@immutable
abstract class UsersEvent {}

class GetAllUsers extends UsersEvent {
  GetAllUsers();
}

class AddUser extends UsersEvent {
  final User user;

  AddUser({
    required this.user,
  });
}

class EditUser extends UsersEvent {
  final User user;

  EditUser({
    required this.user,
  });
}

class LoginUser extends UsersEvent {
  final User user;

  LoginUser({
    required this.user,
  });
}

class ProfilUser extends UsersEvent {
  final String pseudo;

  ProfilUser({
    required this.pseudo,
  });
}