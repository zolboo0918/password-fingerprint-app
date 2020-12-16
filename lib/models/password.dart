import 'package:flutter/cupertino.dart';

class Password {
  final String name;
  final String password;

  Password({@required this.name, @required this.password});
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'password': password,
    };
  }
}
