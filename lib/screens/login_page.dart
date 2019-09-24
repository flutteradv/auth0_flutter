import 'package:auth0_flutter/custom_widgets/gradient_button.dart';
import 'package:auth0_flutter/repository/authorization.dart';
import 'package:auth0_flutter/screens/signup_page.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String _email, _password;
  TextEditingController emailTxtController;
  TextEditingController passTxtController;
  bool isLogingIn;

  @override
  void initState() {
    super.initState();
    isLogingIn = false;
    emailTxtController = TextEditingController();
    passTxtController = TextEditingController();
  }

  bool formIsValid() {
    final form = formKey.currentState;
    form.save();
    return form.validate();
  }

  void _login() async {
    final scaffold = scaffoldKey.currentState;
    if (formIsValid()) {
      setState(() {
        isLogingIn = true;
      });
      try {
        var response = await Authorization().auth0.auth.passwordRealm({
          'username': _email,
          'password': _password,
          'realm': 'Username-Password-Authentication'
        });
        emailTxtController.clear();
        passTxtController.clear();
        setState(() {
          isLogingIn = false;
        });
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return HomePage(
            accessToken: response['access_token'],
          );
        }));
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
          "Login",
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
                    controller: emailTxtController,
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
                    controller: passTxtController,
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
                      child: !isLogingIn ? Text(
                        "LogIn",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ):
                      CircularProgressIndicator(),
                      gradient: LinearGradient(
                        colors: <Color>[
                          Colors.deepOrange,
                          Colors.indigo[900],
                        ],
                      ),
                      onPressed: _login),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: InkWell(
                child: Text(
                  "Forgot Passwords?",
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
                onTap: () {},
              ),
            ),
            SizedBox(
              height: 80,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Don't have an Account?",
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
                InkWell(
                  child: Text(
                    " SignUp",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.indigo[900]),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignupPage()));
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
