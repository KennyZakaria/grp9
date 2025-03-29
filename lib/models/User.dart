class User {
  final String fName;
  final String lName;
  final String login;
  final String password;

  User({
    required this.fName,
    required this.lName,
    required this.login,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fName: json['fName'],
      lName: json['lName'],
      login: json['login'],
      password: json['password'],
    );
  }
}
