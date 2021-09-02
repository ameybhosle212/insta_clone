import 'dart:convert';
import 'dart:io';
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
                                '${data["name"]}',
                                textScaleFactor: 1.5,
                              ),
                              trailing: Icon(Icons.done),
                              subtitle: Text('${data["bodyPost"]}'),
                              selected: true,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SecondRoute(datas: data["id"])),
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
  var url = Uri.parse(_localhost());
  var response = await http.post(url);
  print(response.body);
  return json.decode(response.body);
}

String _localhost() {
  if (Platform.isAndroid)
    return 'http://10.0.2.2:3001/getAllPost';
  else // for iOS simulator
    return 'http://localhost:3001/getAllPost';
}
