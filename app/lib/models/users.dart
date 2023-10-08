class User {
  final String id;
  final String password;
  final String? firstname;
  final String? lastname;
  final String email;
  final String? birthdayDate;


  User({
    required this.id,
    required this.password,
    this.firstname,
    this.lastname,
    required this.email,
    this.birthdayDate,
  });

  User copyWith({
    String? id,
    String? password,
    String? firstname,
    String? lastname,
    String? email,
    String? birthdayDate,
  }) {
    return User(
      id: id ?? this.id,
      password: password ?? this.password,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      birthdayDate: birthdayDate ?? this.birthdayDate,
    );
  }
}