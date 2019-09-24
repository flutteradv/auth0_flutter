import 'package:auth0_flutter/custom_widgets/gradient_button.dart';
import 'package:auth0_flutter/repository/authorization.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String _email, _password;
  bool isSigningUp = false;
  bool formIsValid() {
    final form = formKey.currentState;
    form.save();
    return form.validate();
  }

  void _signUp() async {
    final scaffold = scaffoldKey.currentState;
    if (formIsValid()) {
      setState(() {
        isSigningUp = true;
      });
      try {
        var response = await Authorization().auth0.auth.createUser({
          'email': _email,
          'password': _password,
          'connection': 'Username-Password-Authentication'
        });
         setState(() {
          isSigningUp = false;
        });
        final snackBar = SnackBar(
            content: Text("${response['email']} signed up successfully"));
        scaffold.showSnackBar(snackBar);
      } catch (e) {
        final snackBar = SnackBar(content: Text(e.toString()));
        scaffold.showSnackBar(snackBar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
        ),
        title: Text(
          "SignUp",
          style: TextStyle(
              fontSize: 28, fontWeight: FontWeight.w400, color: Colors.black),
        ),
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 0, 40, 10),
        child: ListView(
          children: <Widget>[
            Image.asset(
              "assets/images/logo.png",
              height: 270,
            ),
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Email"),
                    validator: (value) =>
                        value.isEmpty ? "Please enter your email" : null,
                    onSaved: (value) => _email = value.trim(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Password"),
                    validator: (value) =>
                        value.isEmpty ? "Please enter your password" : null,
                    onSaved: (value) => _password = value.trim(),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  RaisedGradientButton(
                      child: !isSigningUp
                          ? Text(
                              "SignUp",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                            )
                          : CircularProgressIndicator(),
                      gradient: LinearGradient(
                        colors: <Color>[
                          Colors.deepOrange,
                          Colors.indigo[900],
                        ],
                      ),
                      onPressed: _signUp),
                ],
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Already have an Account?",
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
                InkWell(
                  child: Text(
                    " Login",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.indigo[900]),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginPage()));
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
