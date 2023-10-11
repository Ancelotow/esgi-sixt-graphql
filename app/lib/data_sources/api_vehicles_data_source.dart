import 'package:app/data_sources/vehicles_data_source.dart';
import 'package:app/models/vehicles.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:app/models/centers.dart';

class ApiVehiclesDataSource extends VehiclesDataSource {
  late final HttpLink httpLink;
  late final ValueNotifier<GraphQLClient> client;

  ApiVehiclesDataSource() {
    httpLink = HttpLink("http://192.168.1.107:4000/graphql");
    client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(),
      ),
    );
  }

  @override
  Future<List<Vehicle>> getAllVehicles() async {
    const String get30Vehicles = r'''
    query {
      vehicles (first: 30) {
        edges {
          node {
            id
            amountExcluding
            model {
              name
            }
            center {    
              id      
              town {
                name
              }
            }
            imageUri
          }
        }
      }
    }
    ''';

    final QueryOptions options = QueryOptions(
      document: gql(get30Vehicles),
    );

    final QueryResult result = await client.value.query(options);
    List<Vehicle> listVehicles = [];

    if (result.hasException) {
      throw Exception('Erreur GraphQL: ${result.exception.toString()}');
    } else {
      final List<dynamic> edges = result.data!['vehicles']['edges'];

      for (var edge in edges) {
        Vehicle vehicle = Vehicle(
          id: edge['node']['id'],
          amount_excluding: edge['node']['amountExcluding'],
          model: edge['node']['model']['name'],
          center: CenterVehicle(
            id: edge['node']['center']['id'],
            town: edge['node']['center']['town']['name'],
          ),
          imageUri: edge['node']['imageUri'] ?? "",
        );

        listVehicles.add(vehicle);
      }
    }
    return listVehicles;
  }

  @override
  Future<String> addVehicle(Vehicle vehicle) async {
    // TODO: implement addUser
    throw UnimplementedError();
    /*
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

    final QueryResult result = await client.value.query(options);

    if (result.hasException) {
      print(result.exception.toString());
      throw Exception('Erreur GraphQL: ${result.exception.toString()}');
    } else {
      final String idUser = result.data!['addUser']['user']['id'];
      return idUser;
    }
     */
  }

  @override
  Future<void> editVehicle(Vehicle vehicle) async {
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
  Future<Vehicle> detailVehicle(String id) async {
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
