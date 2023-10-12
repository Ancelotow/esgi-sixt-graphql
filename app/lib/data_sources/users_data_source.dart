import 'package:app/domain/models/users.dart';

abstract class UsersDataSource {
  Future<String> addUser(User user);

  Future<void> editUser(User user);

  Future<void> loginUser(User user);

  Future<User> profilUser(String pseudo);
}