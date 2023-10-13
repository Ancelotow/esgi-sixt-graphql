import 'package:app/domain/models/users.dart';
import 'package:app/data_sources/users_data_source.dart';

class UsersRepository {
  final UsersDataSource userDataSource;

  UsersRepository({
    required this.userDataSource,
  });

  Future<String> addUser(User user) {
    return userDataSource.addUser(user);
  }

  Future<void> editUser(User user) {
    return userDataSource.editUser(user);
  }

  Future<void> loginUser(User user){
    return userDataSource.loginUser(user);
  }

  Future<User> profilUser(String pseudo){
    return userDataSource.profilUser(pseudo);
  }
}