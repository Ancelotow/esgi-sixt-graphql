import 'package:app/data_sources/users_data_source.dart';
import 'package:app/domain/models/users.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../domain/models/session.dart';

class ApiUsersDataSource extends UsersDataSource {

  @override
  Future<String> addUser(User user) async {
    const String registerUser = r'''
    mutation AddUser($lastname: String!, $firstname: String!, $birthdayDate: String, $email: String!, $password: String!){
      addUser(input: {email: $email, password: $password, lastname: $lastname, firstname: $firstname, birthday_date: $birthdayDate}) {
        user{
          id
          firstname
        }
      }
    }
    ''';

    final QueryOptions options = QueryOptions(
      document: gql(registerUser),
      variables: {
        'lastname': user.lastname,
        'firstname': user.firstname,
        'email': user.email,
        'password': user.password,
      },
    );

    final QueryResult result = await Session.instance().getGraphQLClient().value.query(options);

    if (result.hasException) {
      throw Exception('Erreur GraphQL: ${result.exception.toString()}');
    } else {
      final String idUser = result.data!['addUser']['user']['id'];
      return idUser;
    }
  }

  @override
  Future<void> editUser(User user) async {
    // TODO: implement addUser
    throw UnimplementedError();
    /*
    const String editUserMutation = r'''
    mutation EditUser($id: String!, $lastname: String, $firstname: String, $birthdayDate: String, $email: String) {
      updateUser(id: $id, lastname: lastname, firstname: firstname, birthdayDate: birthdayDate, email: email) {
        id
        lastname
        firstname
        birthdayDate
        email
      }
    }
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(editUserMutation),
      variables: {
        'id': user.id,
        'lastname': user.lastname,
        'firstname': user.firstname,
        'birthdayDate': user.birthdayDate,
        'email': user.email,
      },
    );

    final GraphQLClient client =
        GraphQLProvider.of(context as BuildContext).value;
    final QueryResult result = await client.mutate(options);

    if (result.hasException) {
      // Gérer les erreurs
      throw Exception(result.exception);
    } else {
      // Les données ont été mises à jour avec succès
    }
     */
  }

  @override
  Future<void> loginUser(User user) async {
    const String query = r'''
    mutation Login($email: String!, $password: String!){
      login(input: {email: $email, password: $password}) {
        session {
          token
          user {
            id
            firstname
            lastname
            email
            birthdayDate
            isAdmin
          }
        }
      }
    }
    ''';

    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: {
        'email': user.email,
        'password': user.password,
      },
    );

    final QueryResult result = await Session.instance().getGraphQLClient().value.query(options);

    if (result.hasException) {
      throw Exception('Erreur GraphQL: ${result.exception.toString()}');
    } else {
      final sessionJson = result.data!['login']['session'];
      final String token = sessionJson['token'];
      final user = User.fromJson(sessionJson['user']);
      Session.instance().setSession(token, user);
    }
  }

  @override
  Future<User> profilUser(String pseudo) async {
    // TODO: implement addUser
    throw UnimplementedError();
    /*
    const String profilUserQuery = r'''
    query {
      user(pseudo: $pseudo) {
        id
        lastname
        firstname
        email
        birthdayDate
        rents {
          id
          nbDays
          amountExcluding
          rentAt
          vehicleId
        }
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
        rents: data['user']['rents'],
      );
      return user;
    }
     */
  }
}
