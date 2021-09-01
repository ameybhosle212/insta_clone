import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SecondRoute extends StatelessWidget {
  const SecondRoute({this.datas});
  final String datas;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return CircularProgressIndicator();
        }
        return Container(
          child: Text('snapshot.data.name'),
        );
      },
      future: getData(datas),
    );
  }
}

Future getData(datas) async {
  var response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/users/${datas}'));
  if (response.statusCode == 200) {
    return response.body;
  }
}
