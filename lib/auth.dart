import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes/addNote.dart';

class Auth extends StatefulWidget {
  static String id = "auth";
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  String userEmail, userPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Auth'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Authentication',
                style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Email'
                ),
                keyboardType: TextInputType.emailAddress,
                onSaved: (String email) {
                  userEmail = email;
                },
                validator: (String email) {
                  if (email == null || email.isEmpty) {
                    return "Please enter your email";
                  }

                  else {
                    return null;
                  }

                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
                keyboardType: TextInputType.visiblePassword,
                onSaved: (String password) {
                  userPassword = password;
                },
                obscureText: true,
                validator: (String password) {
                  if (password == null || password.isEmpty) {
                    return "Please enter your password";
                  }

                  else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: Text('Login'),
                    onPressed: () {
                      if (formKey.currentState.validate() == true) {
                        formKey.currentState.save();

                        try {
                          final user = auth.signInWithEmailAndPassword(email: userEmail, password: userPassword);
                          // add navigation

                        } catch (error) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
                        }
                      }
                    },
                  ),
                  SizedBox(width: 16.0),
                  ElevatedButton(
                    child: Text('Register'),
                    onPressed: () async {
                      if (formKey.currentState.validate() == true) {
                        formKey.currentState.save();

                        try {
                          final newUser = await auth.createUserWithEmailAndPassword(email: userEmail, password: userPassword);

                          if (newUser != null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registered user successfully.')));
                          }

                        } on FirebaseAuthException catch (error) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.message)));
                        }
                      }
                    },
                  ),
                  SizedBox(width: 16.0),
                  ElevatedButton(
                    child: Text('Logout'),
                    onPressed: () {
                      auth.signOut();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Logged out successfully.')));
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
