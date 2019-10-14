import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:async';

var controller = StreamController<String>();

final ValueNotifier<int> counter = ValueNotifier<int>(0);

enum PagesWidget { TODOLIST, LICENSES, DESCRIPTION }

List<Map<String, dynamic>> tasks = [
  {"task": "try making coffee", "value": false},
];

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

class _RootPageState extends State<RootPage>
    with SingleTickerProviderStateMixin<RootPage> {
  PagesWidget selectedPageWidget = PagesWidget.TODOLIST;
  AnimationController _controller;
  Animation _animation;
  StreamController<PagesWidget> _refreshController;


  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _refreshController = StreamController<PagesWidget>();
    _refreshController.add(selectedPageWidget);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Flutter todo list app'),
            decoration: BoxDecoration(color: Colors.black38),
          ),
          ListTile(
            title: Text("Todo List"),
            leading: Icon(Icons.list),
            onTap: () {
              selectedPageWidget = PagesWidget.TODOLIST;
              print(selectedPageWidget.toString());
              _refreshController.add(selectedPageWidget);
            },
          ),
          ListTile(
            title: Text("Licenses"),
            leading: Icon(Icons.check),
            onTap: () {
              selectedPageWidget = PagesWidget.LICENSES;
              print(selectedPageWidget.toString());
              _refreshController.add(selectedPageWidget);
            },
          ),
          ListTile(
            title: Text("Description"),
            leading: Icon(Icons.description),
            onTap: () {
              selectedPageWidget = PagesWidget.DESCRIPTION;
              print(selectedPageWidget.toString());
              _refreshController.add(selectedPageWidget);
            },
          ),
        ],
      )),
      appBar: AppBar(
        title: Text("Flutter Todo list",
            style: TextStyle(color: Color(0xfffafafa), fontFamily: "Roboto")),
        backgroundColor: Colors.black87,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder(
        future: _playAnimation(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return StreamBuilder(
            stream: _refreshController.stream,
            initialData: PagesWidget.TODOLIST,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return getCustomPage();
            },
          );
        },
      ),
    );
  }

  _playAnimation() {
    _controller.reset();
    _controller.forward();
  }

  Widget getCustomPage() {
    print("called");
    switch (selectedPageWidget) {
      case PagesWidget.TODOLIST:
        return getTodoListPage();
      case PagesWidget.LICENSES:
        return getLicensesPage();
      case PagesWidget.DESCRIPTION:
        return getDescriptionPage();
    }
    return getTodoListPage();
  }

  Widget getTodoListPage() {
    return FadeTransition(
      opacity: _animation,
      child: TodoListPage(),
    );
  }

  Widget getLicensesPage() {
    return FadeTransition(
      opacity: _animation,
      child: LicensePage(),
    );
  }

  Widget getDescriptionPage() {
    return FadeTransition(
      opacity: _animation,
      child: Descriptions(),
    );
  }
}

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ValueListenableBuilder(
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
    return Stack(children: <Widget>[
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: ExactAssetImage("assets/coffee_wallpaper.jpg"),
              fit: BoxFit.cover),
        ),
      ),
      Positioned.fill(
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
                decoration:
                    BoxDecoration(color: Colors.black.withOpacity(0.0)))),
      ),
      Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
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
                    Divider(color: Colors.white70),
                padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 5.0),
                itemCount: tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  final task = tasks[index];
                  return CheckboxListTile(
                    activeColor: Colors.black87,
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 2.0),
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
      ])
    ]);
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
        Text("Finished Tasks Counter",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 37.0, fontFamily: "Roboto")),
        SizedBox(
          height: 10.0,
        ),
        Text(counter.value.toString(),
            style: TextStyle(fontSize: 35.0, fontFamily: "Roboto"))
      ],
    );
  }
}

class Licenses extends StatefulWidget {
  @override
  _LicensesState createState() => _LicensesState();
}

class _LicensesState extends State<Licenses> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black54,
        child: Column(
          children: <Widget>[Text("hogehoge")],
        ));
  }
}

class Descriptions extends StatefulWidget {
  @override
  _DescriptionsState createState() => _DescriptionsState();
}

class _DescriptionsState extends State<Descriptions> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white70,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 60.0,
            ),
            Text(
              "Description",
              style: TextStyle(
                fontSize: 30.0,
                fontFamily: "Roboto",
              ),
            ),
            SizedBox(
              height: 100.0,
            ),
            SizedBox(
              width: 300.0,
              child: ListTile(
                title: Text("tabe"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Twitter: @tabe_unity"),
                    Text("PortfolioSite: tabedev.work"),
                  ],
                )
              ),
            ),
            SizedBox(
              height: 100.0,
            ),
            Text(
              "このWebアプリはFlutterで作られています。練習で作ってみました。ぜひご活用ください。"
            )

          
          ],
        ));
  }
}
