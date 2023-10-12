import 'package:app/domain/models/users.dart';

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

  get token => _token;

  get user => _user;

}