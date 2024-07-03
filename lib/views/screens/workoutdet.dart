import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:yoga_app/views/screens/finish.dart';
import 'package:yoga_app/views/screens/ready.dart';
import '../../models/model.dart';
import '../../services/databases/localDB.dart';
import 'break.dart';
import 'package:yoga_app/constants.dart';

class Workoutdet extends StatelessWidget {
  final List<Yoga> allYoga;
  final String yogaTableName;
  final int yogaIndex;
  final int avgKcal;
  const Workoutdet(
      this.allYoga, this.yogaIndex, this.yogaTableName, this.avgKcal,
      {super.key});

  bool isSingleDigit(int number) {
    return (number < 10);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TimerModel2(
          context,
          allYoga,
          yogaIndex,
          allYoga[yogaIndex].Seconds,
          yogaTableName,
          allYoga[yogaIndex].SecondsOrTimes,
          avgKcal),
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 280,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                allYoga[yogaIndex].YogaImgUrl.toString()),      //Main image
                            fit: BoxFit.cover)),
                  ),
                  const SizedBox(height: 12),
                  Text(allYoga[yogaIndex].YogaTitle,                            //Title
                      style: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(allYoga[yogaIndex].Description,                 //Decsription
                        style: const TextStyle(fontSize: 18)),
                  ),
                  const Spacer(),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 120),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.lightBlue),
                      child: allYoga[yogaIndex].Seconds
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Consumer<TimerModel2>(
                                    builder: (context, myModel, child) {
                                  return Text("${myModel.minutes} : ",
                                      style: const TextStyle(
                                          fontSize: 30,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold));
                                }),
                                Consumer<TimerModel2>(
                                    builder: (context, myModel1, child) {
                                  return Text(
                                    isSingleDigit(myModel1.secs)
                                        ? myModel1.secs
                                            .toString()
                                            .padLeft(2, "0")
                                        : myModel1.secs.toString(),
                                    style: const TextStyle(
                                        fontSize: 30,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  );
                                }),
                              ],
                            )
                          : Text("X${allYoga[yogaIndex].SecondsOrTimes}",
                              style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),       //Timer/Times
                  const Spacer(),
                  allYoga[yogaIndex].Seconds
                      ? Consumer<TimerModel2>(
                          builder: (context, myModel3, child) {
                          return ElevatedButton(
                            onPressed: () {
                              myModel3.showPause();
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue),
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  translate(context).pause,
                                  style: const TextStyle(
                                      fontSize: 21,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                )),
                          );
                        })
                      : const SizedBox(),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      yogaIndex != 0
                          ? Consumer<TimerModel2>(
                              builder: (context, myModel, child) {
                              return TextButton(
                                  onPressed: () async {
                                    myModel.passOn();
                                    await Future.delayed(
                                        const Duration(seconds: 1));
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Break(
                                                allYoga,
                                                yogaIndex - 1,
                                                yogaTableName,
                                                avgKcal)));
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(Icons.skip_previous_sharp,
                                          color: Colors.blue, size: 28),
                                      Text(translate(context).previous,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.blue)),
                                    ],
                                  ));              //Previous & Next Buttons
                            })
                          : const SizedBox(),
                      yogaIndex != allYoga.length - 1
                          ? Consumer<TimerModel2>(
                              builder: (context, myModel, child) {
                              return TextButton(
                                  onPressed: () async {
                                    myModel.passOn();
                                    await Future.delayed(
                                        const Duration(seconds: 1));
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Break(
                                                allYoga,
                                                yogaIndex + 1,
                                                yogaTableName,
                                                avgKcal)));
                                  },
                                  child: Row(
                                    children: [
                                      Text(translate(context).next,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.blue)),
                                      const Icon(Icons.skip_next_sharp,
                                          color: Colors.blue, size: 28)
                                    ],
                                  ));
                            })
                          : Consumer<TimerModel2>(
                              builder: (context, myModel, child) {
                              return TextButton(
                                  onPressed: () async {
                                    myModel.passOn();
                                    await Future.delayed(
                                        const Duration(seconds: 1));
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Finish(
                                                yogaTableName,
                                                yogaIndex,
                                                avgKcal)));
                                  },
                                  child: Text(translate(context).finish,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.blue)));
                            }),
                    ],
                  ),
                  const Divider(thickness: 2),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: yogaIndex != allYoga.length - 1
                          ? Text(
                              "${translate(context).next}: ${allYoga[yogaIndex + 1].YogaTitle}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            )
                          : const SizedBox(),
                    ),
                  )           //Lowest Section
                ],
              ),
              Consumer<TimerModel2>(builder: (context, myModel1, child) {
                return Visibility(
                    visible: myModel1.visibilty,
                    child: Container(
                      color: Colors.blue.withOpacity(0.93),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                translate(context).pause,
                                style: const TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Icon(
                                Icons.pause,
                                color: Colors.white,
                                size: 43,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            translate(context).pauseTip,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 22,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 40),
                          OutlinedButton(
                            onPressed: () {
                              myModel1.hidePause(context);
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    WidgetStateProperty.all(Colors.white)),
                            child: SizedBox(
                              width: 90,
                              child: Text(
                                translate(context).resume,
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          OutlinedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Ready(
                                            yogaTablename: yogaTableName,
                                            index: 0,
                                            avgKcal: avgKcal,
                                          )));
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    WidgetStateProperty.all(Colors.white)),
                            child: SizedBox(
                              width: 90,
                              child: Text(
                                translate(context).restart,
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    WidgetStateProperty.all(Colors.white)),
                            child: SizedBox(
                              width: 90,
                              child: Text(translate(context).quit,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.center),
                            ),
                          ),
                        ],
                      ),
                    ));      //Pause screen
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class TimerModel2 extends ChangeNotifier {
  List<Yoga> allYogaList;
  String yogaTableName;
  int yogaIndex;
  int avgKcal;
  bool secondsOrNot;
  late String countTime;
  TimerModel2(context, this.allYogaList, this.yogaIndex, this.secondsOrNot,
      this.yogaTableName, this.countTime, this.avgKcal) {
    setTimer(int.parse(countTime));
    checkIfLast();
    if (yogaIndex == 0) {
      saveStartTime();
      readUpdateStreak();
    }
    if (secondsOrNot) {
      timerFunc(context);
    }
  }
  bool visibilty = false;
  late int countdown2;
  late int minutes, secs;
  Timer? timer;
  bool pass = false;
  bool isLast = false;
  timerFunc(context) async {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      visibilty ? countdown2 + 0 : countdown2--;
      minutes = (countdown2 / 60).floor();
      secs = (countdown2 % 60);
      notifyListeners();
      if (countdown2 == 0) {
        timer.cancel();
        timer.cancel();
        isLast
            ? Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Finish(yogaTableName, yogaIndex, avgKcal)))
            : Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => Break(
                        allYogaList, yogaIndex + 1, yogaTableName, avgKcal)));
      }
      if (pass) {
        timer.cancel();
      }
    });
  }

  void showPause() {
    visibilty = true;
    notifyListeners();
  }

  void hidePause(context) {
    visibilty = false;
    notifyListeners();
  }

  void passOn() {
    pass = true;
    notifyListeners();
  }

  void setTimer(int countTime) {
    countdown2 = countTime;
    minutes = (countdown2 / 60).floor();
    secs = (countdown2 % 60);
    notifyListeners();
  }

  void checkIfLast() {               //checks if the workout is last of its set.
    isLast = yogaIndex >= allYogaList.length - 1;
    notifyListeners();
  }

  void saveStartTime() async {
    String startTime = DateTime.now().toString();
    await LocalDB.saveStartTime(startTime);
    await LocalDB.saveLastDateOn(startTime);
  }

  void readUpdateStreak() async {
    DateTime tempDate = DateFormat("yy-MM-dd hh:mm:ss")
        .parse(await LocalDB.getLastDateOn() ?? "2022:05:24 19:31:15.182");
    int difference = DateTime.now().difference(tempDate).inDays;
    if (difference == 0) {
      if (kDebugMode) {
        print("Same Day");
      }
    } else if (difference == 1) {
      if (kDebugMode) {
        print("Streak Maintained");
      }
      int preStreak = jsonDecode(LocalDB.getStreak().toString()) ?? 0;
      await LocalDB.saveStreak(preStreak + 1);
    } else {
      if (kDebugMode) {
        print("Streak Broken");
      }
      await LocalDB.saveStreak(1);
    }
    //int workoutmin=await LocalDB.getWorkOutMin()?? 0;
  }
}
