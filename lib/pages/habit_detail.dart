import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:labbit/pages/timer.dart';
import 'package:labbit/utils/firebase.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:labbit/pages/home.dart';

class HabitDetail extends StatefulWidget {
  @override
  _HabitDetailState createState() => _HabitDetailState();
}

class _HabitDetailState extends State<HabitDetail> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    initState() {
      setState(() {
        getPostsData();
      });
    }

    initState();
    return Container(
        child: SingleChildScrollView(
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Text(
          'Headline',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(
          height: size.height - 150.0,
          child: ScrollablePositionedList.builder(
            itemCount: habitLength,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) => Card(
              margin: EdgeInsets.all(20.0),
              child: Container(
                padding: EdgeInsets.all(size.width / 2 - 150),
                child: Column(
                  children: [
                    Text(
                      "100日間継続中",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30.0),
                    ),
                    SizedBox(
                      height: size.height / 10,
                    ),
                    Text("合計継続時間:"),
                    Text("合計継続時間:"),
                    Text("合計継続時間:"),
                  ],
                ),
              ),
            ),
            itemScrollController: itemScrollController,
            itemPositionsListener: itemPositionsListener,
          ),
        ),
      ]),
    ));
  }
}
