import 'package:flutter/material.dart';



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
                  )),
            ),
            SizedBox(
              height: 100.0,
            ),
            Text("このWebアプリはFlutterで作られています。練習で作ってみました。ぜひご活用ください。")
          ],
        ));
  }
}
