import 'package:flutter/material.dart';
import 'auth.dart';
import 'addNote.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      routes: {
        Auth.id: (context) => Auth(),
        AddNote.id: (context) => AddNote()
      },
      initialRoute: Auth.id,
    );
  }
}
