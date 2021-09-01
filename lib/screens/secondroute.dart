import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SecondRoute extends StatelessWidget {
  const SecondRoute({this.datas});
  final String datas;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder(
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                  break;
                default:
                  if (snapshot.hasError) {
                    return Text('Error');
                  } else {
                    return Column(
                      children: [
                        Text('$snapshot.data'),
                        SizedBox(
                          height: 50,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, int index) {
                            return Text('$snapshot.data');
                          },
                        )
                      ],
                    );
                  }
              }
            },
            future: getData(datas),
          ),
        ],
      ),
    );
  }
}

Future getData(datas) async {
  List data = [];
  var response = await http.get(Uri.parse('http://localhost:3001/$datas'));
  if (response.statusCode == 200) {
    data.add(response.body);
    print(data);
    return data;
  }
}
