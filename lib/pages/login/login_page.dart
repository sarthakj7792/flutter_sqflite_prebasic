import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttersqflite/data/database_helper.dart';
import 'package:fluttersqflite/models/user.dart';
import 'package:fluttersqflite/pages/login/login_presentor.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginPageContract {
  late BuildContext _ctx;
  late bool _isLoading;
  final formKey = GlobalKey<FormState>();
//  final scaffoldKey = GlobalKey<ScaffoldState>();

  late final _username, _password;

  late LoginPagePresenter _presenter;

  _LoginPageState() {
    _presenter = LoginPagePresenter(this);
  }

  void _submit() {
    final form = formKey.currentState;
    if (form!.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _presenter.doLogin(_username, _password);
      });
    }
  }

  void _showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    var loginBtn = ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
      onPressed: _submit,
      child: const Text("Login"),
    );
    var loginForm = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Sqflite App Login',
          textScaleFactor: 2,
        ),
        Form(
          key: formKey,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                onSaved: (val) => _username = val,
                decoration: const InputDecoration(labelText: "Username"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                onSaved: (val) => _password = val,
                decoration: const InputDecoration(labelText: "Password"),
              ),
            ),
          ]),
        ),
        loginBtn
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Container(
          child: Center(
        child: loginForm,
      )),
    );
  }

  @override
  void onLoginError(String error) {
    // TODO: implement onLoginError
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onLoginsuccess(User user) async {
    // TODO: implement onLoginsuccess
    _showSnackBar(user.toString());
    setState(() {
      _isLoading = false;
    });
    var db = DatabaseHelper();
    await db
        .saveUser(user)
        .then((value) => Timer(const Duration(seconds: 2), () {
              Navigator.of(context).pushNamed('/home');
            }));
  }
}
