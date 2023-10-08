class User {
  final String id;
  final String pseudo;
  final String password;
  final String? firstname;
  final String? lastname;
  final String? email;

  User({
    required this.id,
    required this.pseudo,
    required this.password,
    this.firstname,
    this.lastname,
    this.email,
  });

  User copyWith({
    String? id,
    String? pseudo,
    String? password,
    String? firstname,
    String? lastname,
    String? email,
  }) {
    return User(
      id: id ?? this.id,
      pseudo: pseudo ?? this.pseudo,
      password: password ?? this.password,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
    );
  }
}