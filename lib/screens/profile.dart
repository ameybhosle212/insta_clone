import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.none &&
                  snapshot.hasData == null) {
                return CircularProgressIndicator();
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  var data = snapshot.data[index];
                  return Column(
                    children: [
                      Text('${data['name']}'),
                      Text('${data['email']}'),
                    ],
                  );
                },
              );
            },
            future: getaDta(),
          )
        ],
      ),
    );
  }
}

Future getaDta() async {
  // SharedPreferences _prefs = await SharedPreferences.getInstance();_prefs.getString('id')
  var url = 'https://jsonplaceholder.typicode.com/users';
  var response = await http.get(Uri.parse(url));
  if (response.body != null && response.statusCode == 200) {
    print(response.body);
    return json.decode(response.body);
  }
}
