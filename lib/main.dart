import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/app.dart';
import 'package:instagram_clone/screens/feed.dart';
import 'package:instagram_clone/screens/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  runApp(
      _prefs.get('token') == null && _prefs.get('id') == null ? Login() : My());
}

class Login extends StatelessWidget {
  String _email, _password;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  // validator: (value) {
                  //   if (value == null) {
                  //     return "Enter Correct value";
                  //   }
                  //   return value;
                  // },
                  decoration: InputDecoration(
                    hintText: 'ameybhosle3@gn.com',
                    labelText: 'Enter Email',
                  ),
                  onSaved: (value) => _email = value,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'ama12@',
                  ),
                  obscureText: true,
                  onSaved: (value) => _password = value,
                ),
                RaisedButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      var response = await http.post(
                        Uri.parse("http://127.0.0.1:3001/login"),
                        body: jsonEncode(
                            {'email': _email, 'password': _password}),
                        headers: <String, String>{
                          'Content-Type': 'application/json',
                          'Charset': 'utf-8'
                        },
                      );
                      _formKey.currentState.save();
                      if (response.body != null &&
                          response.statusCode == 200 &&
                          json.decode(response.body)["id"] != null &&
                          json.decode(response.body)["token"] != null) {
                        SharedPreferences _pref =
                            await SharedPreferences.getInstance();
                        _pref.setString('id', json.decode(response.body)["id"]);
                        _pref.setString(
                            "token", json.decode(response.body)["token"]);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyApp(),
                          ),
                        );
                      }
                    }
                  },
                  child: Text('Login'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: My(),
    );
  }
}

class My extends StatefulWidget {
  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<My> {
  List<Widget> bodyApp = [App(), Feed(), Profile()];
  int current = 0;
  void tapp(int index) {
    setState(() {
      current = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Instagram'),
        ),
        body: bodyApp[current],
        bottomNavigationBar: BottomNavigationBar(
          // selectedItemColor: Colors.blueGrey,
          // unselectedItemColor: Colors.amber,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.ac_unit),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Feed',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fence),
              label: 'Profile',
            ),
          ],
          onTap: tapp,
          currentIndex: current,
        ),
      ),
    );
  }
}
