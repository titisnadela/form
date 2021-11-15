import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:multiform/form.dart';
import 'package:multiform/user.dart';
import 'package:http/http.dart' as http;

class MultiForm extends StatefulWidget {
  //const MultiForm({ Key? key }) : super(key: key);

  @override
  _MultiFormState createState() => _MultiFormState();
}

class _MultiFormState extends State<MultiForm> {
  // TextEditingController name = TextEditingController();
  // TextEditingController email = TextEditingController();
  List<User> users = [];
  List<UserForm> forms = [];

  Future<List> _simpan() async {
    for (int n = 0; n < forms.length; n++) {
      final respon = await http.post(
          Uri.parse("http://192.168.98.95/multiform/multiform.php"),
          body: json.encode(forms[n].user.toJson()));
      //var datauser = json.decode(respon.body);
      print(respon.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    forms.clear();
    for (int i = 0; i < users.length; i++) {
      forms.add(UserForm(
        key: GlobalKey(),
        user: users[i],
        onDelete: () => onDelete(i),
      ));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Users Form'),
        actions: <Widget>[FlatButton(onPressed: onSave, child: Text('save'))],
      ),
      body: users.length <= 0
          ? Center(
              child: Text('Add form by yapping [+] button below'),
            )
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (_, i) => forms[i],
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: onAddForm,
      ),
    );
  }

  void onDelete(int index) {
    setState(() {
      users.removeAt(index);
    });
  }

  void onAddForm() {
    setState(() {
      users.add(User());
    });
  }

  void onSave() {
    forms.forEach((form) => form.isValid());
    _simpan();
  }
}
