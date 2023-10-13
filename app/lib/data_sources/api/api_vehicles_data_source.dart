import 'package:app/data_sources/vehicles_data_source.dart';
import 'package:app/domain/models/brand.dart';
import 'package:app/domain/models/brand_model.dart';
import 'package:app/domain/models/town.dart';
import 'package:app/domain/models/vehicles.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:app/domain/models/centers.dart';
import '../../domain/models/session.dart';

class ApiVehiclesDataSource extends VehiclesDataSource {

  @override
  Stream<List<Vehicle>> getAllVehicles() {
    const String get30Vehicles = r'''
    query {
      vehicles (first: 30) {
        edges {
          node {
            id
            transmission
            nbPlaces
            amountExcluding
            model {
              id
              name
              releaseYear
              brand {
                id
                name
                logoUri
              }
            }
            center {    
              id     
              name
              address 
              town {
                inseeCode
                zipCode
                name
              }
            }
            imageUri
            kilometrage
          }
        }
      }
    }
    ''';

    final QueryOptions options = QueryOptions(
      document: gql(get30Vehicles),
    );

    return Stream.fromFuture(Session.instance().getGraphQLClient().value.query(options)).asyncExpand((result) {
      if (result.hasException) {
        return Stream.error('Erreur GraphQL: ${result.exception.toString()}');
      } else {
        final List<dynamic> edges = result.data!['vehicles']['edges'];
        List<Vehicle> listVehicles = [];

        for (var edge in edges) {
          Vehicle vehicle = Vehicle(
            id: edge['node']['id'],
            transmission: edge['node']['transmission'],
            nb_places: edge['node']['nbPlaces'],
            amount_excluding: edge['node']['amountExcluding'],
            model: BrandModel.fromJson(edge['node']['model']),
            center: CenterVehicle.fromJson(edge['node']['center']),
            imageUri: edge['node']['imageUri'] ?? "",
            kilometrage: edge['node']['kilometrage'],
          );

          listVehicles.add(vehicle);
        }
        return Stream.value(listVehicles);
      }
    });
  }

  @override
  Future<String> addVehicle(Vehicle vehicle) async {
    const String query = r'''
    mutation AddVehicle($numberPlate: String!, $nbPlaces: Int!, $kilometrage: Int!, $isAirConditioner: Boolean!, $amountExcluding: Int!, $maxCharge: Int!, $modelId: Int!, $colorId: Int!, $centerId: Int!, $maxSpeedAllowed: Int!, $imageUri: String!, $transmissionId: Int!) {
      addVehicle(input: {numberPlate: $numberPlate, nbPlaces: $nbPlaces, kilometrage: $kilometrage, isAirConditioner: $isAirConditioner, amountExcluding: $amountExcluding, maxCharge: $maxCharge, modelId: $modelId, colorId: $colorId, centerId: $centerId, maxSpeedAllowed: $maxSpeedAllowed, imageUri: $imageUri, transmissionId: $transmissionId}) {
        vehicle{
            id
            nbPlaces
            amountExcluding
            model {
              name
              brand {
                logoUri
              }
            }
            center {    
              id
              name
              address
              town {
                inseeCode
                zipCode
                name
              }
            }
            imageUri
            kilometrage
        }
      }
    }
    ''';

    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: {
        'numberPlate': vehicle.number_plate,
        'nbPlaces': vehicle.nb_places ?? 2,
        'kilometrage': vehicle.kilometrage ?? 20,
        'isAirConditioner': vehicle.is_air_conditioner ?? false,
        'amountExcluding': vehicle.amount_excluding,
        'maxCharge': vehicle.max_charge ?? 100,
        'modelId': vehicle.model!.id,
        'colorId': vehicle.color?.id ?? 1,
        'centerId': int.parse(vehicle.center!.id),
        'maxSpeedAllowed': vehicle.max_speed_allowed ?? 20,
        'imageUri': vehicle.imageUri,
        'transmissionId': 1
      },
    );

    final QueryResult result = await Session.instance().getGraphQLClient().value.query(options);

    if (result.hasException) {
      print(result.exception.toString());
      throw Exception('Erreur GraphQL: ${result.exception.toString()}');
    } else {
      final String idVehicle = result.data!['addVehicle']['vehicle']['id'];
      return idVehicle;
    }

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

  @override
  Stream<List<Vehicle>> getVehiclesFilter(String maxKm, String minPlace) {
    const String getFilterVehicles = r'''
      query VehiclesFilter($maxKm: Int, $minPlace: Int){
        vehiclesFilter (filter: {maxKilometrage: $maxKm, minimumPlaces: $minPlace}) {
          id
            transmission
            nbPlaces
            amountExcluding
            model {
              id
              name
              releaseYear
              brand {
                id
                name
                logoUri
              }
            }
            center {    
              id     
              name
              address 
              town {
                inseeCode
                zipCode
                name
              }
            }
            imageUri
            kilometrage
        }
      }
    ''';

    final QueryOptions options = QueryOptions(
      document: gql(getFilterVehicles),
      variables: {
        'maxKm': int.parse(maxKm),
        'minPlace': int.parse(minPlace),
      },
    );

    return Stream.fromFuture(Session.instance().getGraphQLClient().value.query(options)).asyncExpand((result) {
      if (result.hasException) {
        return Stream.error('Erreur GraphQL: ${result.exception.toString()}');
      } else {
        final List<dynamic> vehicles_filter = result.data!['vehiclesFilter'];
        List<Vehicle> listVehicles = [];
        for (var vehicle_filter in vehicles_filter) {
          Vehicle vehicle = Vehicle(
            id: vehicle_filter['id'],
            transmission: vehicle_filter['transmission'],
            nb_places: vehicle_filter['nbPlaces'],
            amount_excluding: vehicle_filter['amountExcluding'] ?? 0,
            model: BrandModel.fromJson(vehicle_filter['model']),
            center: CenterVehicle.fromJson(vehicle_filter['center']),
            imageUri: vehicle_filter['imageUri'] ?? "",
            kilometrage: vehicle_filter['kilometrage'],
          );
          listVehicles.add(vehicle);
        }
        return Stream.value(listVehicles);
      }
    });
  }
}
