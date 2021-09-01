import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:instagram_clone/screens/secondroute.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(),
          SizedBox(
            height: 40.0,
          ),
          FutureBuilder(
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                  break;
                default:
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Error"),
                    );
                  } else {
                    return Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            var data = snapshot.data[index];
                            return ListTile(
                              leading: Icon(Icons.add),
                              title: Text(
                                '${snapshot.data[index]['name']}',
                                textScaleFactor: 1.5,
                              ),
                              trailing: Icon(Icons.done),
                              subtitle: Text('This is subtitle'),
                              selected: true,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SecondRoute(datas: data[index].id)),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    );
                  }
              }
            },
            future: getData(),
          ),
        ],
      ),
    );
  }
}

Future getData() async {
  var url = Uri.parse('https://jsonplaceholder.typicode.com/users');
  var response = await http.get(url);
  return json.decode(response.body);
}