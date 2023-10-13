import 'package:app/domain/models/users.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gql_dio_link/gql_dio_link.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Session {

  static Session? _instance;
  String _token;
  User _user;

  Session._(this._token, this._user);

  static Session instance() {
    _instance ??= Session._('', User(id: '', password: '', email: ''));
    return _instance!;
  }

  void setSession(String token, User user) {
    _token = token;
    _user = user;
  }

  ValueNotifier<GraphQLClient> getGraphQLClient() {
    return ValueNotifier<GraphQLClient>(
      GraphQLClient(
        link: HttpLink(
          '${dotenv.env['API_BASE_URI']}/graphql',
          defaultHeaders: {
            "Authorization": "Bearer ${Session.instance().token}",
          },
        ),
        cache: GraphQLCache(),
      ),
    );
  }

  get token => _token;

  get user => _user;

}