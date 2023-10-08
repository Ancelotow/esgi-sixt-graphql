import 'package:app/data_sources/users_data_source.dart';
import 'package:app/models/users.dart';
import 'package:dbcrypt/dbcrypt.dart';

class ApiUsersDataSource extends UsersDataSource {
  @override
  Future<String> addUser(User user) {
    // TODO: implement addUser
    throw UnimplementedError();
  }

  @override
  Future<void> editUser(User user) {
    // TODO: implement editUser
    throw UnimplementedError();
  }

  @override
  Future<void> loginUser(User user) {
    // TODO: implement loginUser
    throw UnimplementedError();
  }

  @override
  Future<User> profilUser(String pseudo) {
    // TODO: implement profilUser
    throw UnimplementedError();
  }

  /*
  @override
  Future<String> addUser(User user) async {
    final querySnapshot = await collectionReference
        .where('pseudo', isEqualTo: user.pseudo)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      throw Exception(
          'Ce pseudo est déjà utilisé! Veuillez en choisir un autre');
    }

    var uuid = const Uuid();
    final response = await collectionReference.add({
      'id_user': uuid.v4(),
      'avatarUrl': '',
      'pseudo': user.pseudo,
      'password': user.password,
      'firstname': '',
      'lastname': '',
      'friends': [],
      'usersBlocked': [],
    });
    return response.id;
  }

  @override
  Future<void> editUser(User user) async {
    final querySnapshot = await collectionReference
        .where('pseudo', isEqualTo: user.pseudo)
        .limit(1)
        .get();
    final userPseudoFirestore = querySnapshot.docs.first;
    if (userPseudoFirestore.id != user.id) {
      throw Exception(
          'Ce pseudo est déjà utilisé! Veuillez en choisir un autre');
    }

    await collectionReference.doc(user.id).update({
      'avatarUrl': user.avatarUrl,
      'pseudo': user.pseudo,
      'firstname': user.firstname,
      'lastname': user.lastname
    });
  }

  @override
  Future<void> loginUser(User user) async {
    final querySnapshot = await collectionReference
        .where('pseudo', isEqualTo: user.pseudo)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final userStored = querySnapshot.docs.first;
      final passwordStored = userStored['password'];

      if (!passwordMatches(user.password, passwordStored)) {
        throw Exception('Mot de passe incorrect');
      }
    } else {
      throw Exception('Utilisateur non trouvé');
    }
  }

  bool passwordMatches(String password, String hashedPassword) {
    return DBCrypt().checkpw(password, hashedPassword);
  }

  @override
  Future<User> profilUser(String pseudo) async {
    final querySnapshot = await collectionReference
        .where('pseudo', isEqualTo: pseudo)
        .limit(1)
        .get();

    final userFirestore = querySnapshot.docs.first;

    final friendList = userFirestore['friends'] as List<dynamic>;
    final blockedFriendsList = userFirestore['usersBlocked'] as List<dynamic>;

    final user = User(
      id: userFirestore.id,
      id_user: userFirestore['id_user'],
      avatarUrl: userFirestore['avatarUrl'],
      pseudo: userFirestore['pseudo'],
      password: '',
      firstname: userFirestore['firstname'],
      lastname: userFirestore['lastname'],
      friends: friendList.cast<String>(),
      usersBlocked: blockedFriendsList.cast<String>(),
    );
    return user;
  }
  */
}
