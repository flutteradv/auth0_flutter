import 'package:flutter_auth0/flutter_auth0.dart';

class Authorization{

  static final String clientId = '2vNvMSZKXZQt0uOuemW25M1bCzuD9dyY';
  static final String domain = 'dev-suas7y-p.eu.auth0.com';
  //Makes Authorization a singleton
  static final Authorization _instance =  Authorization._internal();
  factory Authorization() => _instance;
  Authorization._internal();

  Auth0 get auth0{
      return Auth0(baseUrl: 'https://$domain/', clientId: clientId);
  }


}