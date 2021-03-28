import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labbit/models/stop_watch_model.dart';
import 'package:provider/provider.dart';
import 'package:labbit/pages/home.dart';
import 'package:flutter_picker/flutter_picker.dart';

class StopWatch extends StatefulWidget {
  @override
  _StopWatchState createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  List<String> habits = [];
  String selectedHabit;
  StopWatchModel model = StopWatchModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPostsData();
    final DateTime datetime = DateTime.now();
    // print(time_now.add(datetime));
  }

  getPostsData() async {
    QuerySnapshot snapshot =
        await postsRef.doc(user.id).collection("usersPosts").get();

    habits = [];
    setState(() {
      for (var i = 0; i < snapshot.docs.length; i++) {
        var habit = snapshot.docs[i].id;
        habits.add("$habit");
      }
    });
    print(habits);
  }

  void _onSelectedItemChanged_habit(int index) {
    setState(() {
      selectedHabit = habits[index];
    });
  }

  void addCompleteTime() async {
    _onSelectedItemChanged_habit(0);
    DocumentSnapshot target_habit = await postsRef
        .doc(user.id)
        .collection("usersPosts")
        .doc("$selectedHabit")
        .get();

    Map<String, dynamic> habit_data = await target_habit.data();

    if (habit_data["first_time"] != null) {
      print("へい！");
      postsRef
          .doc(user.id)
          .collection("usersPosts")
          .doc(selectedHabit)
          .update({"first_time": DateTime.now()});
    } else {
      print("hello");
    }

    print(habits);
    print(habit_data["habit"]);
    print(stopWatchTimeDisplay);
    print(DateTime.now());
  }

  Widget pickerHabits(String str) {
    return Text(
      str,
      style: const TextStyle(fontSize: 32),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: ChangeNotifierProvider<StopWatchModel>(
          create: (_) => StopWatchModel(),
          child: Consumer<StopWatchModel>(
            builder: (context, model, child) {
              return Column(
                children: [
                  const SizedBox(height: 100.0),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      stopWatchTimeDisplay,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 50.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 50, right: 8),
                        child: RaisedButton(
                          color: Colors.redAccent,
                          child: Text(timerButtonName),
                          onPressed: isStopPressed
                              ? model.startStopWatch
                              : model.stopStopWatch,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 30,
                          right: 8,
                        ),
                        child: RaisedButton(
                          color: Colors.green,
                          child: const Text('RESET'),
                          onPressed:
                              isResetPressed ? null : model.resetStopWatch,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                          child: Text(
                            "記録する",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          color: Color(0xffFF962C),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                // barrierDismissible:
                                //     false, // dialog is dismissible with a tap on the barrier
                                builder: (BuildContext context) => Container(
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    child: Column(children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CupertinoButton(
                                            child: Text(
                                              "閉じる",
                                              style: TextStyle(
                                                  color: Colors.lightBlue),
                                            ),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                          CupertinoButton(
                                            child: Text(
                                              "決定",
                                              style: TextStyle(
                                                  color: Colors.lightBlue),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              addCompleteTime();
                                              // setState(() {
                                              //   _initialAge = _selectedAge;
                                              // });
                                            },
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                3,
                                        child: CupertinoPicker(
                                          itemExtent: 40,
                                          children:
                                              habits.map(pickerHabits).toList(),
                                          onSelectedItemChanged:
                                              _onSelectedItemChanged_habit,
                                        ),
                                      )
                                    ] // ボタンの配置
                                        )));
                          })
                    ],
                  )
                  // const SizedBox(height: 20.0),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
