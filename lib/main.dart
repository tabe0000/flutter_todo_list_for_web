import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo list for web',
      theme: ThemeData(),
      home: RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Flutter Todo list"),
          backgroundColor: Colors.black87,
        ),
        body: Row(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                child: TaskList(),
                color: Colors.white,
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                child: InfoWindows(),
                color: Colors.orange,
              ),
            )
          ],
        ));
  }
}

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<String> tasks = [
    "try making coffee",
    "work on homework",
    "do my paper",
  ];

  List<TextEditingController> _controllers = List();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Stack(
        children: <Widget>[
          Padding(
              //Title Text
              padding: EdgeInsets.only(top: 18.0, left: 10.0, bottom: 30.0),
              child: Text(
                "Today's tasks.",
                style: TextStyle(
                  fontSize: 30.0,
                ),
                textAlign: TextAlign.start,
              )
          ),
        ],
      )
    );
  }
}

class InfoWindows extends StatefulWidget {
  @override
  _InfoWindowsState createState() => _InfoWindowsState();
}

class _InfoWindowsState extends State<InfoWindows> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            flex: 1,
            child: Container(
              color: Colors.red,
            )),
        Expanded(
            flex: 1,
            child: Container(
              color: Colors.blueGrey,
            ))
      ],
    );
  }
}
