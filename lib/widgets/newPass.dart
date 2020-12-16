import 'package:flutter/material.dart';

class NewPass extends StatefulWidget {
  final Function addPassword;

  NewPass(this.addPassword);

  @override
  _NewPassState createState() => _NewPassState();
}

class _NewPassState extends State<NewPass> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  void submitData() {
    widget.addPassword(nameController.text, passwordController.text);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            children: [
              Text(
                'Шинэ нууц үг нэмэх',
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 20),
              ),
              TextField(
                decoration: InputDecoration(labelText: "Сайтын нэр"),
                controller: nameController,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Нууц үг"),
                controller: passwordController,
              ),
              SizedBox(height: 30),
              RaisedButton(
                  onPressed: submitData,
                  child: Text(
                    'Нэмэх',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 20),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
