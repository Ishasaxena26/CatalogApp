class User {
  int? id;
  String? token;
  String? username;
  String? email, first_name, last_name;

  User({
    this.email,
    this.first_name,
    this.last_name,
    this.id,
    this.username,
  });

  // {"pk":8,"username":"Shashisaxena","email":"","first_name":"","last_name":""}
  factory User.fromJson(json) {
    return User(
      email: json["email"],
      first_name: json["first_name"],
      id: json["pk"],
      last_name: json["last_name"],
      username: json["username"],
    );
  }
}
