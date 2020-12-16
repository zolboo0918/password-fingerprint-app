import 'package:flutter/material.dart';
import 'package:password_save_app/models/password.dart';
import 'package:password_save_app/utils/database.dart';
import 'package:password_save_app/widgets/passItem.dart';

class Passwords extends StatefulWidget {
  final List<Password> passwordList;
  Passwords(this.passwordList);

  @override
  _PasswordsState createState() => _PasswordsState();
}

class _PasswordsState extends State<Passwords> {
  void _deletePass(Password pass) {
    var db = DBProvider.db;
    setState(() {
      widget.passwordList.remove(pass);
    });
    db.deletePass(pass);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.passwordList.length,
      itemBuilder: (ctx, index) => PasswordItem(
        name: widget.passwordList[index].name,
        pass: widget.passwordList[index].password,
        deletePass: () => _deletePass(widget.passwordList[index]),
      ),
    );
  }
}
