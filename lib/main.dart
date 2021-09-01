import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/app.dart';
import 'package:instagram_clone/screens/feed.dart';
import 'package:instagram_clone/screens/profile.dart';

void main() {
  runApp(MyApp());
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
