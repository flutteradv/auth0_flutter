import 'package:auth0_flutter/screens/login_page.dart';
import 'package:auth0_flutter/screens/signup_page.dart';
import 'package:flutter/material.dart';
import 'custom_widgets/gradient_button.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Auth0 Demo",
      home: FirstPage(),
      theme: ThemeData(
          canvasColor: Colors.white,
          primarySwatch: Colors.indigo,
          hintColor: Colors.black38),
    );
  }
}

class FirstPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset("assets/images/logo.png"),
            ),
            Spacer(
              flex: 2,
            ),
            RaisedGradientButton(
              child: Text(
                "LogIn",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              ),
              gradient: LinearGradient(
                colors: <Color>[
                  Colors.deepOrange,
                  Colors.indigo[900],
                ],
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }));
              },
            ),
            SizedBox(
              height: 18,
            ),
            RaisedGradientButton(
              child: Text(
                "SignUp",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              ),
              gradient: LinearGradient(
                colors: <Color>[
                  Colors.deepOrange,
                  Colors.indigo[900],
                ],
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SignupPage();
                }));
              },
            ),
            Spacer(
              flex: 2,
            )
          ],
        ),
      ),
    );
  }
}
