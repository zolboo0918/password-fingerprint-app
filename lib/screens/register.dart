import 'package:flutter/material.dart';
import 'package:password_save_app/models/user.dart';
import 'package:password_save_app/utils/database.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();

    final _email = TextEditingController();
    final _pass1 = TextEditingController();
    final _pass2 = TextEditingController();

    bool checkSame() {
      return _pass1.text == _pass2.text;
    }

    final dbProvider = DBProvider.db;

    void _insertUser() {
      if (checkSame()) {
        var user = User(password: _pass1.text, username: _email.text);
        dbProvider.newUser(user).then((value) {
          if (value) {
            Fluttertoast.showToast(
              msg: "Амжилттай бүртгэгдлээ.",
            );
            Navigator.pop(context);
          } else {
            Fluttertoast.showToast(
              msg: "Хэрэглэгчийн нэр давхардаж байна.",
            );
          }
        });
      } else {
        Fluttertoast.showToast(
          msg: "Нууц үг адилхан биш байна.",
        );
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text('Бүртгэл'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Center(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  style:
                      TextStyle(color: Theme.of(context).secondaryHeaderColor),
                  controller: _email,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).secondaryHeaderColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).secondaryHeaderColor),
                    ),
                    labelText: 'Хэрэглэгчийн нэр',
                    labelStyle: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor),
                  ),
                ),
                TextFormField(
                  style:
                      TextStyle(color: Theme.of(context).secondaryHeaderColor),
                  obscureText: true,
                  controller: _pass1,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).secondaryHeaderColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).secondaryHeaderColor),
                    ),
                    labelText: 'Нууц үг',
                    labelStyle: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor),
                  ),
                ),
                TextFormField(
                  style:
                      TextStyle(color: Theme.of(context).secondaryHeaderColor),
                  obscureText: true,
                  controller: _pass2,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).secondaryHeaderColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).secondaryHeaderColor),
                    ),
                    labelText: 'Нууц үг давт',
                    labelStyle: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: RaisedButton(
                    onPressed: _insertUser,
                    child: Text('Бүртгүүлэх'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
