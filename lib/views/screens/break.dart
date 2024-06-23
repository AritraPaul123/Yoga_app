import 'dart:async';
import 'package:yoga_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoga_app/views/screens/workoutdet.dart';
import '../../models/model.dart';

class Break extends StatelessWidget {
  final List<Yoga> listYoga;
  final int yogaIndex;
  final String yogaTableName;
  final int avgKcal;
  const Break(this.listYoga, this.yogaIndex, this.yogaTableName, this.avgKcal,
      {super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          TimerModel3(context, listYoga, yogaIndex, yogaTableName, avgKcal),
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                    "https://images.unsplash.com/photo-1558017487-06bf9f82613a?q=80&w=1970&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                  ),   //Background Image
                  fit: BoxFit.cover,
                  opacity: 0.4,
                  colorFilter:
                      ColorFilter.mode(Colors.black45, BlendMode.color))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              Text(translate(context).breakTime,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 38)),
              const SizedBox(height: 30),
              Consumer<TimerModel3>(builder: (context, myModel, child) {
                return Text(myModel.countdown3.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 58));
              }),
              const SizedBox(height: 60),
              Consumer<TimerModel3>(builder: (context, myModel, child) {
                return ElevatedButton(          //Skip button
                  onPressed: () {
                    myModel.skip();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: Text(
                        "SKIP",
                        style: TextStyle(
                            fontSize: 21,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      )),
                );
              }),
              const Spacer(),
              const Divider(
                thickness: 2,
                color: Colors.black26,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Text(
                    "Next: ${listYoga[yogaIndex].YogaTitle}",    //Bottom section
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TimerModel3 extends ChangeNotifier {
  List<Yoga> allYogaList;
  String yogaTableName;
  int yogaIndex;
  int avgKcal;
  bool skipBreak = false;
  TimerModel3(context, this.allYogaList, this.yogaIndex, this.yogaTableName,
      this.avgKcal) {
    timerFunc(context);
  }
  int countdown3 = 20;
  Timer? timer;
  timerFunc(context) async {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      countdown3--;
      notifyListeners();
      if (countdown3 == 0 || skipBreak) {
        timer.cancel();
        timer.cancel();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Workoutdet(
                    allYogaList, yogaIndex, yogaTableName, avgKcal)));
      }
    });
  }

  void skip() {
    skipBreak = true;
    notifyListeners();
  }
}
