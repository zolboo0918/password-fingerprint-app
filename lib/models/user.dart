class User {
  String username;
  String password;
  User({this.username, this.password});

  User.fromMap(dynamic obj, this.username, this.password) {
    this.username = obj['username'];
    this.password = obj['password'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["username"] = username;
    map["password"] = password;
    return map;
  }
}
