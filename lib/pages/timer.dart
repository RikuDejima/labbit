import 'package:flutter/material.dart';
import 'package:labbit/models/stop_watch_model.dart';

class Timer extends StatefulWidget {
  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                    model.stopWatchTimeDisplay,
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
                        child: const Text('STOP'),
                        onPressed:
                            model.isStopPressed ? null : model.stopStopWatch,
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
                            model.isResetPressed ? null : model.resetStopWatch,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                RaisedButton(
                  color: Colors.orange,
                  child: const Text('START'),
                  onPressed: model.isStartPressed ? model.startStopWatch : null,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
