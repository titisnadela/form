// ignore_for_file: unused_element

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:multiform/user.dart';
import 'package:http/http.dart' as http;

typedef OnDelete();

class User {
  String name;
  String email;

  User({this.name = '', this.email = ''});

  Map<String, dynamic> toJson() => {'name': name, 'email': email};
}

class UserForm extends StatefulWidget {
  final User user;
  final state = _UserFormState();
  final OnDelete onDelete;

  final String name;
  final String email;

  UserForm({Key key, this.user, this.onDelete, this.name, this.email})
      : super(key: key);
  //const UserForm({Key? key}) : super(key: key);

  @override
  _UserFormState createState() => state;

  bool isValid() => state.validate();
}

class _UserFormState extends State<UserForm> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  final form = GlobalKey<FormState>();

  Future<List> _store() async {
    final respon = await http.post(
        Uri.parse("http://192.168.98.95/multiform/multiform.php"),
        headers: {
          'Content-type': 'application/json',
          //'Accept': 'application/json'
        });

    body:
    json.encode({"name": name.text, "email": email.text});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Card(
        child: Form(
          key: form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AppBar(
                leading: Icon(Icons.people),
                title: Text('User Form'),
                actions: <Widget>[
                  IconButton(
                      onPressed: widget.onDelete, icon: Icon(Icons.delete))
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: name,
                  //initialValue: widget.user.name,
                  onSaved: (val) => widget.user.name = val,
                  validator: (val) => val.isNotEmpty ? null : 'Nama salah',
                  decoration: InputDecoration(
                      labelText: 'full name', hintText: 'enter your full name'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: email,
                  //initialValue: widget.user.email,
                  onSaved: (val) => widget.user.email = val,
                  validator: (val) => val.isNotEmpty ? null : 'Nama salah',
                  decoration: InputDecoration(
                      labelText: 'email', hintText: 'enter your email'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool validate() {
    var valid = form.currentState.validate();
    if (valid) form.currentState.save();
    return valid;
  }
}
