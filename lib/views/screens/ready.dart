import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoga_app/views/screens/workoutdet.dart';
import 'package:yoga_app/services/databases/yogadb.dart';
import 'package:yoga_app/models/model.dart';
import 'package:yoga_app/constants.dart';

class Ready extends StatelessWidget {
  final String yogaTablename;
  final int index;
  final int avgKcal;
  const Ready(
      {super.key,
      required this.yogaTablename,
      required this.index,
      required this.avgKcal});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TimerModel>(
        create: (context) => TimerModel(context, yogaTablename, avgKcal),
        child: PopScope(
          canPop: false,
          child: Scaffold(
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2 - 100,
                  ),
                  Text(
                    translate(context).ready,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 40),
                  Consumer<TimerModel>(builder: (context, myModel, child) {
                    return Text(
                      myModel.countdown.toString(),
                      style: const TextStyle(fontSize: 48),
                    );
                  }),
                  const Spacer(),
                  const Divider(thickness: 2),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: Text(
                        translate(context).tip,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class TimerModel extends ChangeNotifier {
  late String tableName;
  late int avgKcal;
  TimerModel(context, this.tableName, this.avgKcal) {
    timerFunc(context);
    fetchAllYoga(tableName);
  }
  int countdown = 5;
  Timer? timer;
  late List<Yoga> allYoga;

  bool pass = false;
  bool skip = false;

  timerFunc(context) async {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      countdown--;
      notifyListeners();
      if (countdown == 0 || skip) {
        timer.cancel();
        timer.cancel();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Workoutdet(allYoga, 0, tableName, avgKcal)));
      }
      if (pass) {
        timer.cancel();
      }
    });
  }

  Future<List<Yoga>> fetchAllYoga(String tableName) async {
    allYoga = await YogaDataBase.instance.readAllYoga(tableName);
    notifyListeners();
    return allYoga;
  }

  void passOn() {
    pass = true;
    notifyListeners();
  }

  void skipReady() async {
    skip = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
  }
}
