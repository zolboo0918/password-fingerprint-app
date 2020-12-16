import 'package:flutter/material.dart';

class Empty extends StatelessWidget {
  final Function addPassword;

  Empty(this.addPassword);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Хувийн нууц үгнүүдээ нэг дор найдвартай хадгалаарай',
            style: TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 100,
          ),
          RaisedButton(
            onPressed: addPassword,
            child: Icon(Icons.add, color: Theme.of(context).primaryColor),
          )
        ],
      ),
    );
  }
}
