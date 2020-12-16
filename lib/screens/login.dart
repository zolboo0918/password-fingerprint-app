import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/local_auth.dart';
import 'package:password_save_app/models/password.dart';
import 'package:password_save_app/screens/Home.dart';
import 'package:password_save_app/screens/register.dart';
import 'package:password_save_app/utils/database.dart';

class Login extends StatelessWidget {
  final LocalAuthentication auth = LocalAuthentication();
  final db = DBProvider.db;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> _authenticate(BuildContext context) async {
    if (usernameController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Нэвтрэх нэр хоосон байна');
    } else {
      var db = DBProvider.db;
      var a = false;
      db.isExist(usernameController.text).then((value) async {
        if (value) {
          a = await auth.authenticateWithBiometrics(
            localizedReason: 'Хурууны хээгээ уншуулна уу',
            useErrorDialogs: true,
            stickyAuth: false,
          );
          if (a) {
            Future<List<Password>> list =
                db.getPasswords(usernameController.text).then((value) {
              return value;
            });
            list.then((value) {
              return Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => Home(
                    username: usernameController.text,
                    passwordList: value,
                  ),
                ),
              );
            });
          }
        } else {
          Fluttertoast.showToast(msg: 'Хэрэглэгч олдсонгүй');
        }
      });
    }
  }

  bool checkEmpty() {
    return usernameController.text.isEmpty || passwordController.text.isEmpty;
  }

  void _login(BuildContext context) {
    if (checkEmpty()) {
      Fluttertoast.showToast(
        msg: 'Нэвтрэх нэр нууц үгийн талбар хоосон байж болохгүй',
      );
    } else {
      db.login(usernameController.text, passwordController.text).then((value) {
        if (value != null) {
          Future<List<Password>> list =
              db.getPasswords(usernameController.text).then((value) {
            return value;
          });
          list.then((value) {
            return Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => Home(
                  username: usernameController.text,
                  passwordList: value,
                ),
              ),
            );
          });
        } else {
          Fluttertoast.showToast(
            msg: 'Нэвтрэх нэр нууц үг буруу байна',
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Нэвтрэх',
              style: TextStyle(
                color: Theme.of(context).secondaryHeaderColor,
                fontSize: 32,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Form(
                child: Column(children: [
                  TextFormField(
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).secondaryHeaderColor),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).secondaryHeaderColor),
                      ),
                      labelText: 'Нэвтрэх нэр',
                      labelStyle: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                    ),
                    style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor),
                    controller: usernameController,
                  ),
                  TextFormField(
                    style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor),
                    obscureText: true,
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
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                    ),
                    controller: passwordController,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: RaisedButton(
                            onPressed: () => _login(context),
                            child: Text('Нэвтрэх'),
                            textColor: Theme.of(context).primaryColor,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: RaisedButton(
                            onPressed: () => _authenticate(context),
                            child: Icon(Icons.fingerprint),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register()));
                      },
                      child: Text(
                        'Бүртгүүлэх',
                        style: TextStyle(color: Theme.of(context).buttonColor),
                      ))
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
