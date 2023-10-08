import 'dart:js';

import 'package:app/data_sources/users_data_source.dart';
import 'package:app/models/users.dart';
import 'package:dbcrypt/dbcrypt.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ApiUsersDataSource extends UsersDataSource {
  late final HttpLink httpLink;
  late final ValueNotifier<GraphQLClient> client;

  ApiUsersDataSource() {
    httpLink = HttpLink("http://localhost:4000/graphql");
    client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(),
      ),
    );
  }

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
  Future<void> loginUser(User user) async {
    // TODO: implement profilUser
    throw UnimplementedError();
  }

  @override
  Future<User> profilUser(String pseudo) async {
    const String profilUserQuery = r'''
    query {
      user(pseudo: $pseudo) {
        id
        lastname
        firstname
        email
        birthdayDate
      }
    }
    ''';

    final QueryOptions options = QueryOptions(
      document: gql(profilUserQuery),
      variables: {
        'pseudo': pseudo,
      },
    );

    final QueryResult result =
        await GraphQLProvider.of(context as BuildContext).value.query(options);
    if (result.hasException) {
      // Gérer les erreurs
      throw Exception(result.exception);
    } else {
      // Accéder aux données de la réponse
      final Map<String, dynamic>? data = result.data;
      if (data == null) {
        throw Exception("Aucune donnée renvoyée par la requête GraphQL");
      }
      final Map<String, dynamic> userData = data['user'];

      final user = User(
        id: userData['id'],
        firstname: userData['firstname'],
        lastname: userData['lastname'],
        email: userData['email'],
        birthdayDate: userData['birthdayDate'],
        password: '',
      );
      return user;
    }
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
