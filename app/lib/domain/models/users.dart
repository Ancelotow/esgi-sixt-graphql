import 'package:app/domain/models/rents.dart';

class User {
  final String id;
  final String password;
  final String? firstname;
  final String? lastname;
  final String email;
  final String? birthdayDate;
  final bool isAdmin;


  User({
    required this.id,
    required this.password,
    this.firstname,
    this.lastname,
    required this.email,
    this.isAdmin = false,
    this.birthdayDate,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      password: "",
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      birthdayDate: json['birthdayDate'],
      isAdmin: json['isAdmin'],
    );
  }

  User copyWith({
    String? id,
    String? password,
    String? firstname,
    String? lastname,
    String? email,
    String? birthdayDate,
    bool? isAdmin,
  }) {
    return User(
      id: id ?? this.id,
      password: password ?? this.password,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      birthdayDate: birthdayDate ?? this.birthdayDate,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }
}