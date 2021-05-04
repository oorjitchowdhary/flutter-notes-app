import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'auth.dart';
import 'viewNotes.dart';

class AddNote extends StatefulWidget {
  static String id = "addNote";
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static FirebaseAuth auth = FirebaseAuth.instance;
  final String uid = auth.currentUser.uid;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference notes = firestore.collection("notes");
  String noteTitle, noteBody;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add note'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(40.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Add note',
                style: TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Title'
                ),
                onSaved: (String title) {
                  noteTitle = title;
                },
                validator: (String title) {
                  if (title.isEmpty) {
                    return "Please enter the title";
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Body note'
                ),
                maxLines: 5,
                onSaved: (String body) {
                  noteBody = body;
                },
                validator: (String body) {
                  if (body.isEmpty) {
                    return "Please enter note body";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  ElevatedButton(
                    child: Text('Add note'),
                    onPressed: () {
                      if (formKey.currentState.validate() == true) {
                        formKey.currentState.save();

                        notes.add({
                          'title': noteTitle,
                          'body': noteBody,
                          'uid': auth.currentUser.uid
                        }).then((value) => {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Added note successfully')))
                        }).catchError((error) => {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)))
                        });

                        formKey.currentState.reset();
                      }
                    }
                  ),
                  SizedBox(width: 16.0),
                  ElevatedButton(
                    child: Text('View notes'),
                    onPressed: () {
                      Navigator.pushNamed(context, ViewNotes.id);
                    },
                  ),
                  SizedBox(width: 16.0),
                  ElevatedButton(
                    child: Text('Logout'),
                    onPressed: () {
                      auth.signOut();
                      Navigator.pushNamed(context, Auth.id);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Logged out user.')));
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
