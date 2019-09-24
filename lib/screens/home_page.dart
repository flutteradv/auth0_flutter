import 'package:auth0_flutter/repository/authorization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth0/flutter_auth0.dart';

class HomePage extends StatefulWidget {
  final String accessToken;
  const HomePage({Key key, this.accessToken}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String buffer = '';
  Auth0 auth0;
  String pictureUrl;
  void logout() async {
    auth0.auth.logoutUrl({'client_id': Authorization().clientId});
    Navigator.pop(context);
  }

  void _userInfo() async {
    try {
      Auth0Auth authClient = Auth0Auth(
          auth0.auth.clientId, auth0.auth.client.baseUrl,
          bearer: widget.accessToken);
      var info = await authClient.getUserInfo();
      print(info);
      info.forEach((k, v) {
        if (k != "picture") {
          buffer = '$buffer\n$k: $v';
        }
      });
      setState(() {
        pictureUrl = info['picture'];
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    auth0 = Authorization().auth0;
    _userInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
        ),
        title: Text(
          "User Info",
          style: TextStyle(
              fontSize: 28, fontWeight: FontWeight.w400, color: Colors.black),
        ),
        elevation: 1,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.black,
            ),
            onPressed: () {
              logout();
            },
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              pictureUrl != null ?
              CircleAvatar(
                backgroundImage: NetworkImage(pictureUrl),
                radius: 100,
              ):
              Container(),
              SizedBox(
                height: 10,
              ),
              Text(
                "User info:",
                style: TextStyle(fontSize: 28),
              ),
              Text(
                "$buffer",
                style: TextStyle(fontSize: 22),
                maxLines: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
