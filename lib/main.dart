import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'dart:convert';
import 'PickerData.dart';
import 'package:flutter/src/material/dialog.dart' as Dialog;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'todo_list_for_web',
      theme: ThemeData(primarySwatch: Colors.grey, fontFamily: "RobotoMono"),
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
          title: Text("Flutter Todo list",
              style: TextStyle(color: Colors.white, fontFamily: "RobotoMono")),
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
  List<Map<String, dynamic>> tasks = [
    {"id": 0, "task": "try making coffee", "value": false},
    {"id": 1, "task": "work on homework", "value": false},
    {"id": 2, "task": "do my paper", "value": false}
  ];

  final _taskTextFieldController = TextEditingController();
  Map<String, dynamic> tempMap = {};

  @override
  void initState() {
    super.initState();
    print("initialized.");
  }

  _changeBool(bool e, int id) {
    setState(() {
      tempMap = tasks[id];
      tempMap["value"] = !tempMap["value"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black26,
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 50.0, vertical: 5.0),
                  itemCount: tasks.length,
                  itemBuilder: (BuildContext context, int index) {
                    final task = tasks[index];

                    return CheckboxListTile(
                      activeColor: Colors.redAccent,
                      title: Text(
                        task["id"],
                        style: TextStyle(
                          fontSize: 25.0,
                          decoration: task["task"]
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      controlAffinity: ListTileControlAffinity.trailing,
                      value: task["value"],
                      onChanged: (e) {
                        _changeBool(e, task["task"]);
                      },
                    );
                  })),
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
                              controller: _taskTextFieldController,
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
        IconButton(
          icon: Icon(Icons.add_box),
          iconSize: 20.0,
          color: Colors.black87,
          onPressed: () {},
        )
      ],
    );
  }
}
