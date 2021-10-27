import 'package:flutter/material.dart';
import 'package:login_api/models/user.dart';
import 'package:login_api/models/api_error.dart';
import 'package:login_api/models/api_response.dart';
import 'package:login_api/service/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  late ApiResponse _apiResponse;

  String? _username;
  String? _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        key: Key("_username"),
                        decoration: InputDecoration(labelText: "Username"),
                        keyboardType: TextInputType.text,
                        onSaved: (String? value) {
                          _username = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Username is required';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: "Password"),
                        obscureText: true,
                        onSaved: (String? value) {
                          _password = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10.0),
                      ButtonBar(
                        children: <Widget>[
                          ElevatedButton.icon(
                              onPressed: _handleSubmitted,
                              icon: Icon(Icons.arrow_forward),
                              label: Text('Sign in')),
                        ],
                      ),
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  void _handleSubmitted() async {
    final FormState? form = _formKey.currentState;
    if (form != null && !form.validate()) {
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form?.save();
      try {
        _apiResponse = await authenticateUser(_username!, _password!);
      } catch (e) {
        showInSnackBar((_apiResponse.ApiError as ApiError).error);
      }
      _saveAndRedirectToHome();
    }
  }

  void _saveAndRedirectToHome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("userId", (_apiResponse.data as User).userId!);
    Navigator.pushNamedAndRemoveUntil(
        context, '/home', ModalRoute.withName('/home'),
        arguments: (_apiResponse.data as User));
  }

  void showInSnackBar(String? message) {
    // ignore: deprecated_member_use
    _scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(message!)));
  }
}
