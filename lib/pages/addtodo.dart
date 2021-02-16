import 'package:flutter/material.dart';

class AddTodo extends StatefulWidget {
  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
          margin: EdgeInsets.all(20.0),
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    SizedBox(
                      child: TextField(),
                      width: 150.0,
                    ),
                    Text("を習慣化させる")
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("１日最低"),
                    SizedBox(
                      child: TextField(),
                      width: 50.0,
                    ),
                    Text("時間")
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("目標・why："),
                    SizedBox(
                      child: TextField(),
                      width: 150.0,
                    ),
                  ],
                ),
              ],
            ),
          )),
      backgroundColor: Color(0xffFFFEEB),
    );
  }
}
