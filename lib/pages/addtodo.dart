import 'package:flutter/material.dart';
import 'package:labbit/pages/home.dart';
import 'package:labbit/widgets/header.dart';

class AddTodo extends StatefulWidget {
  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Card(
            child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        TextField(
                          decoration: InputDecoration(hintText: "何を習慣化させるか"),
                        ),
                      ],
                    )
                  ],
                )),
          ),
        ),
      ),
      backgroundColor: Color(0xffFFFEEB),
    );
  }
}
