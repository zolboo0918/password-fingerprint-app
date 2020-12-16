import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:password_save_app/models/password.dart';
import 'package:password_save_app/models/passwordDB.dart';
import 'package:password_save_app/screens/login.dart';
import 'package:password_save_app/utils/database.dart';
import 'package:password_save_app/widgets/emptyPass.dart';
import 'package:password_save_app/widgets/newPass.dart';
import 'package:password_save_app/widgets/passwords.dart';

class Home extends StatefulWidget {
  final List<Password> passwordList;
  final String username;
  @override
  _HomeState createState() => _HomeState();
  Home({@required this.username, @required this.passwordList});
}

class _HomeState extends State<Home> {
  final db = DBProvider.db;

  void addNewPass(String name, String pass) {
    var password = Password(name: name, password: pass);
    setState(() {
      widget.passwordList.add(password);
    });
    var newPass = PasswordDB(password, widget.username, name);
    db.insertPass(newPass).then((value) =>
        Fluttertoast.showToast(msg: value ? 'Амжилттай нэмлээ' : 'Амжилтгүй'));
  }

  void modal(BuildContext context) {
    showModalBottomSheet(context: context, builder: (_) => NewPass(addNewPass));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.power_settings_new),
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Login(),
                ),
              ),
            ),
          ],
          title: Text('Нууц үг хадгалагч'),
        ),
        floatingActionButton: widget.passwordList.isEmpty
            ? null
            : FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () => modal(context),
              ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Container(
            child: widget.passwordList.isEmpty
                ? Empty(() => modal(context))
                : Passwords(widget.passwordList),
          ),
        ),
      ),
    );
  }
}
