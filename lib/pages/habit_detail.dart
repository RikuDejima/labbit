import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:labbit/pages/timer.dart';
import 'package:labbit/utils/firebase.dart';

import 'package:labbit/pages/home.dart';

class HabitDetail extends StatefulWidget {
  @override
  _HabitDetailState createState() => _HabitDetailState();
}

class _HabitDetailState extends State<HabitDetail> {
  FireStore fireStore = FireStore();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    setState(() {
      fireStore.getPostsData();
    });

    return Container(
        child: SingleChildScrollView(
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Text(
          'Headline',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(
          height: size.height - 150.0,
          // width: size.width + 900,
          child: ListView.builder(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: habitLength,
            itemBuilder: (BuildContext context, int index) => Card(
              margin: EdgeInsets.all(20.0),
              child: Container(
                padding: EdgeInsets.only(
                    left: size.width / 2 - 150, right: size.width / 2 - 150),
                child: Row(
                  children: [
                    Text(
                      "100日間継続中",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    ));
  }
}
