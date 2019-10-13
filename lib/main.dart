import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'dart:convert';
import 'package:flutter/src/material/dialog.dart' as Dialog;
import 'dart:async';

var controller = StreamController<String>();

final ValueNotifier<int> counter = ValueNotifier<int>(0);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'todo_list_for_web',
      theme: ThemeData(
        primarySwatch: Colors.grey, 
        fontFamily: "Sawarabi",
        unselectedWidgetColor: Colors.white,
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
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Flutter todo list app'),
                decoration: BoxDecoration(
                  color: Colors.black38
                ),
              ),
              ListTile(
                title: Text("Todo List"),
                onTap: () {

                },
              ),
              ListTile(
                title: Text("Licenses"),
                onTap: () {

                },
              ),
              ListTile(
                title: Text("Description"),
                onTap: () {
                  
                },
              ),
            ],
          )
        ),
        appBar: AppBar(
          title: Text("Flutter Todo list",
              style: TextStyle(color: Color(0xfffafafa), fontFamily: "Roboto")),
          backgroundColor: Colors.black87,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: ValueListenableBuilder(
          builder: (BuildContext context, int value, Widget child) {
            return Row(
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
                    color: Color(0xfffafafa),
                    child: InfoWindows(),
                  ),
                )
              ],
            );
          },
          valueListenable: counter,
        ));
  }
}

class TaskListArea extends StatefulWidget {
  @override
  _TaskListAreaState createState() => _TaskListAreaState();
}

class _TaskListAreaState extends State<TaskListArea> {
  List<Map<String, dynamic>> tasks = [
    {"task": "try making coffee", "value": false},
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
      tempMap["value"] ? counter.value += 1 : counter.value -= 1;
    });
  }

  _addTask(String addedTask) {
    setState(() {
      tasks.add({"task": addedTask, "value": false});
      _taskTextFieldController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage("assets/coffee_wallpaper.jpg"),
              fit: BoxFit.cover
            ),
          ),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.0))
            )
          ),
        ),
        Column(
            mainAxisAlignment: MainAxisAlignment.start, 
            children: <Widget>[
            Expanded(
              flex: 2,
              child: Padding(
                  //Title Text
                  padding: EdgeInsets.only(top: 18.0, left: 10.0, bottom: 30.0),
                  child: Text(
                    "Today's tasks.",
                    style: TextStyle(
                      fontSize: 37.0,
                      fontFamily: "Roboto",
                      color: Color(0xfffafafa),
                    ),
                    textAlign: TextAlign.start,
                  )),
            ),
            Expanded(
                flex: 15,
                child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        Divider(color: Colors.black12),
                    padding:
                        EdgeInsets.symmetric(horizontal: 50.0, vertical: 5.0),
                    itemCount: tasks.length,
                    itemBuilder: (BuildContext context, int index) {
                      final task = tasks[index];
                      return CheckboxListTile(
                        activeColor: Colors.redAccent,
                        title: Text(
                          task["task"],
                          style: TextStyle(
                            fontSize: 25.0,
                            decoration: task["value"]
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          color: Color(0xfffafafa),
                          ),
                        ),
                        controlAffinity: ListTileControlAffinity.trailing,
                        value: task["value"],
                        onChanged: (e) {
                          _changeBool(e, index);
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
                            child: Container(
                              color: Colors.white54,
                              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                              child: TextField(
                                cursorColor: Colors.white70,
                                controller: _taskTextFieldController,
                                decoration: InputDecoration(
                                    hintText: "make coffee.",
                                    border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black26),
                                    )),
                              ))),
                          Expanded(
                            child: SizedBox(
                              width: 10.0,
                            ),
                          ),
                          FlatButton(
                            color: Colors.white54,
                            onPressed: () {
                              if (_taskTextFieldController.text != "") {
                                _addTask(_taskTextFieldController.text);
                              }
                            },
                            child: Icon(
                              Icons.add,
                            ),
                          )
                      ]))))
          ])]);
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
        Text(
          "Finished Tasks Counter",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 37.0,
            fontFamily: "Roboto"
          )  
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          counter.value.toString(),
          style: TextStyle(
            fontSize: 35.0,
            fontFamily: "Roboto"
          )
        )
      ],
    );
  }
}
