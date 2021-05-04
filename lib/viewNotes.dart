import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ViewNotes extends StatefulWidget {
  static String id = "viewNotes";
  @override
  _ViewNotesState createState() => _ViewNotesState();
}

class _ViewNotesState extends State<ViewNotes> {
  static FirebaseAuth auth = FirebaseAuth.instance;
  final String uid = auth.currentUser.uid;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference firebaseNotes = firestore.collection("notes");

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: firebaseNotes.where("uid", isEqualTo: uid).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List<Widget> notes = [];
          snapshot.data.docs.forEach((note) => {
            notes.add(Column(
              children: <Widget>[
                Text(
                  note['title'],
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  note['body'],
                  style: TextStyle(
                    fontSize: 14.0
                  ),
                ),
                SizedBox(height: 12.0)
              ],
            ))
          });

          return Scaffold(
            appBar: AppBar(
              title: Text('View your notes'),
              centerTitle: true,
            ),
            body: Padding(
              padding: EdgeInsets.all(24.0),
              child: ListView(children: notes),
            ),
          );
        }

        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
