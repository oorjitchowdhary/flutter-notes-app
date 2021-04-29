import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddNote extends StatefulWidget {
  static String id = "addNote";
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add note'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(40.0),
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
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Body note'
              ),
              maxLines: 5,
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                ElevatedButton(
                  child: Text('Add note'),
                  onPressed: () {}
                ),
                SizedBox(width: 12.0),
                ElevatedButton(
                  child: Text('View notes'),
                  onPressed: () {
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
