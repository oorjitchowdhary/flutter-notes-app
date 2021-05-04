import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notes/viewNotes.dart';

import 'auth.dart';
import 'addNote.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> initialization = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Unable to initialize Firebase');
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Notes App',
            routes: {
              Auth.id: (context) => Auth(),
              AddNote.id: (context) => AddNote(),
              ViewNotes.id: (context) => ViewNotes()
            },
            initialRoute: Auth.id,
          );
        }

        return CircularProgressIndicator();
      }
    );

  }
}
