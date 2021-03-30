import 'package:flutter/material.dart';
import 'package:labbit/pages/home.dart';
import 'package:labbit/models/user.dart';

class AddTodo extends StatefulWidget {
  final User currentUser;

  AddTodo({this.currentUser});

  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController captionController = TextEditingController();
  String habit = "";
  String hours = "";
  String minutes = "";
  String goal = "";

  createPostInFirestore(habit, hours, minutes, goal) {
    postsRef.doc(currentUser.id).collection("usersPosts").doc(habit);

    postsRef.doc(currentUser.id).collection("usersPosts").doc(habit).set({
      "username": currentUser.username,
      "goal": goal,
      "targetTime_hours": hours,
      "targetTime_minutes": minutes,
      "complete_time": 0,
      "complete_day": 0,
      "first_time": null,
    });
  }

  @override
  void initState() {
    super.initState();
    // currentUser = User();
    print(currentUser.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
          margin: EdgeInsets.all(20.0),
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: <Widget>[
                    SizedBox(
                      child: TextField(
                        onChanged: (String value) {
                          setState(() {
                            habit = value;
                          });
                        },
                      ),
                      width: 150.0,
                    ),
                    Text("を習慣化させる", style: TextStyle(fontSize: 22.0))
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("１日最低", style: TextStyle(fontSize: 22.0)),
                    SizedBox(
                      child: TextField(
                        onChanged: (String value) {
                          setState(() {
                            hours = value;
                          });
                        },
                      ),
                      width: 50.0,
                    ),
                    Text("時間", style: TextStyle(fontSize: 22.0)),
                    SizedBox(
                      child: TextField(
                        onChanged: (String value) {
                          setState(() {
                            minutes = value;
                          });
                        },
                      ),
                      width: 50.0,
                    ),
                    Text("分", style: TextStyle(fontSize: 22.0)),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("目標・why：", style: TextStyle(fontSize: 22.0)),
                    SizedBox(
                      child: TextField(
                        onChanged: (String value) {
                          setState(() {
                            goal = value;
                          });
                        },
                      ),
                      width: 150.0,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text(
                        "追加",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      color: Color(0xffFF962C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () {
                        createPostInFirestore(habit, hours, minutes, goal);
                        pageController.animateToPage(0,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                        captionController.clear();
                      },
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "３日経っても継続時間が更新され\nないと、習慣化失敗になるよ！\n１回で習慣化させよう！！",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Color(0xffFD3636),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
      backgroundColor: Color(0xffFFFEEB),
    );
  }
}
