import 'package:flutter/material.dart';
import 'package:multiform/form.dart';
import 'package:multiform/multiform.dart';
import 'package:multiform/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MultiForm',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.greenAccent,
        ),
        home: MultiForm());
  }
}
