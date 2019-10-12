import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.green,
        child: Column(
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
                    fontSize: 30.0,
                  ),
                  textAlign: TextAlign.start,
                )),
          ),
          Expanded(
              flex: 15,  
              child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      Divider(color: Colors.black),
                  padding: EdgeInsets.all(5.0),
                  itemCount: tasks.length,
                  itemBuilder: (context, i) => 
                    Card(
                      child: ListTile(
                        leading: FlutterLogo(),
                        title: Text(tasks[i]),
                        trailing: Icon(Icons.check_box_outline_blank),
                      )
                    )
              )
          ),
          Expanded(
              flex: 2,
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
                  ])))
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
