import 'package:password_save_app/models/password.dart';

class PasswordDB {
  Password password;
  String user;
  String siteName;

  PasswordDB(this.password, this.user, this.siteName);

  Map<String, dynamic> toMap() {
    return {
      'password': password,
      'user': user,
      'siteName': siteName,
    };
  }
}
