import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'todo_list_for_web',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
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
          title: Text(
            "Flutter Todo list",
            style: TextStyle(
              color: Colors.white,
            )
          ),
          backgroundColor: Colors.black87,
        ),
        body: Row(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.white,
                child: TaskListArea(),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                child: InfoWindows(),
              ),
            )
          ],
        ));
  }
}

class TaskListArea extends StatefulWidget {
  @override
  _TaskListAreaState createState() => _TaskListAreaState();
}

class _TaskListAreaState extends State<TaskListArea> {
  List<String> tasks = [
    "try making coffee",
    "work on homework",
    "do my paper",
  ];

  Map<String, bool> tasksValue = {};

  @override
  void initState() {
    super.initState();
    for (int i = 0; tasks.length > i; i++) {
      tasksValue[tasks[i]] = false;
      print(tasksValue[tasks[i]]);
    }
  }

  _changeBool(bool e, String key) {
    setState(() {
      tasksValue[key] = e;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.green,
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: <
            Widget>[
          Expanded(
            flex: 2,
            child: Padding(
                //Title Text
                padding: EdgeInsets.only(top: 18.0, left: 10.0, bottom: 30.0),
                child: Text(
                  "Today's tasks.",
                  style: TextStyle(
                    fontSize: 37.0,
                  ),
                  textAlign: TextAlign.start,
                )),
          ),
          Expanded(
              flex: 15,
              child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      Divider(color: Colors.black),
                  padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 5.0),
                  itemCount: tasks.length,
                  itemBuilder: (context, i) => CheckboxListTile(
                        activeColor: Colors.redAccent,
                        title: Text(
                          tasks[i],
                          style: TextStyle(
                            fontSize: 25.0,
                            decoration: tasksValue[tasks[i]] ? TextDecoration.lineThrough : TextDecoration.none,
                          ),  
                        ),
                        controlAffinity: ListTileControlAffinity.trailing,
                        value: tasksValue[tasks[i]],
                        onChanged: (e) {
                          _changeBool(e, tasks[i]);
                        },
                      ))),
          Expanded(
              flex: 2,
              child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(children: <Widget>[
                        Expanded(
                            flex: 20,
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: "make coffee.",
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  )),
                            )),
                        Expanded(
                          child: SizedBox(
                            width: 10.0,
                          ),
                        ),
                        Expanded(
                            flex: 5,
                            child: FlatButton(
                              color: Colors.grey,
                              onPressed: () {},
                              child: Text("Add"),
                            ))
                      ]))))
        ]));
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
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text("Timer"),

      ],
    );
  }
}


