import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:login_api/service/api.dart';
import 'package:login_api/models/api_response.dart';
import 'package:login_api/models/api_error.dart';
import 'package:login_api/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _userId = "";

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  void _handleLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userId');
    Navigator.pushNamedAndRemoveUntil(
        context, '/login', ModalRoute.withName('/login'));
  }

  _getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userId = (prefs.getString('userId') ?? "");
    try {
      ApiResponse _apiResponse = await getUserDetails(_userId);
      print('hello');
      print(json.encode(_apiResponse.data));
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Welcome back " + _userId + "!"),
              // Text("Last login was on " + _user!.lastLogin.toString()),
              // Text("Your Email is  " + _user!.email.toString()),
              ElevatedButton(
                onPressed: _handleLogout,
                child: Text("Logout"),
              )
            ],
          ),
        ));
  }
}
