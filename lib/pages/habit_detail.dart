import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:labbit/pages/timer.dart';

import 'package:labbit/pages/home.dart';

class HabitDetail extends StatefulWidget {
  @override
  _HabitDetailState createState() => _HabitDetailState();
}


class _HabitDetailState extends State<HabitDetail> {
  StopWatch stopWatch = StopWatch();


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
        child: SingleChildScrollView(
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Text(
          'Headline',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(
          height: size.height - 150.0,
          width: size.width + 300,
          child: ListView.builder(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: ,
            itemBuilder: (BuildContext context, int index) => Card(
              child: Center(child: Text('Dummy Card Text')),
            ),
          ),
        ),
      ]),
    ));
  }
}
