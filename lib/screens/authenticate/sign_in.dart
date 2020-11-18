import 'package:brew_crew/Shared/constants.dart';
import 'package:brew_crew/Shared/loading.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  String email = '';
  String password = '';
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading?Loading(): Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0,
        title: Text("SignIn"),
        actions: [
          FlatButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text("Register"))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        // child:
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: "email"),
                  validator: (val) => val.isEmpty ? 'enter an email' : null,
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration:
                      textInputDecoration.copyWith(hintText: "password"),
                  validator: (val) => val.length < 6
                      ? 'enter a password atleast 6 character long'
                      : null,
                  obscureText: true,
                  onChanged: (val) {
                    setState(() {
                      password = val;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      "Sign In",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          loading = true;
                        });
                        dynamic result = await _auth.signinWithEmailPassword(
                            email, password);
                        if (result == null) {
                          setState(() {
                            error =
                                'Please enter a valid email and passsword !!';
                            loading = false;
                          });
                        }
                      } else {}
                    }),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  color: Colors.brown[300],
                 child: Text('Sign in Anonymously'),
                  onPressed: () async {
                  dynamic result = await _auth.signinanon();
                  if (result == null) {
                  print("Error signing in");
                } else {
                  print("Signed in successfully");
                  print(result.uid);
                }
              }),
                SizedBox(
                  height: 20,
                ),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 20),
                ),
              ],
            )),
      ),
    );
  }
}
