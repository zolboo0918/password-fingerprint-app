import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class PasswordItem extends StatefulWidget {
  final String name;
  final String pass;
  final Function deletePass;

  PasswordItem(
      {@required this.name, @required this.pass, @required this.deletePass});

  @override
  _PasswordItemState createState() => _PasswordItemState();
}

class _PasswordItemState extends State<PasswordItem> {
  var _show = false;

  void changer() async {
    if (!_show) {
      LocalAuthentication auth = LocalAuthentication();
      var success = await auth.authenticateWithBiometrics(
        localizedReason: 'Хурууны хээ уншуулна уу',
        useErrorDialogs: true,
        stickyAuth: false,
      );
      if (success) {
        setState(() {
          _show = !_show;
        });
      }
    } else {
      setState(() {
        _show = !_show;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 20),
      elevation: 10,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: constraints.maxWidth * 0.2,
                child: FittedBox(
                  child: Text(
                    widget.name,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              !_show ? Text('*****') : Text(widget.pass),
              IconButton(
                icon: Icon(!_show ? Icons.lock : Icons.lock_open),
                onPressed: changer,
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: widget.deletePass,
              ),
            ],
          );
        },
      ),
    );
  }
}
