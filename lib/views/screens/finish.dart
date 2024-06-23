import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yoga_app/constants.dart';
import 'package:yoga_app/views/screens/ready.dart';
import '../../services/databases/localDB.dart';
import 'home.dart';

class Finish extends StatelessWidget {
  final String yogaTableName;
  final int index;
  final int avgKcal;
  const Finish(this.yogaTableName, this.index, this.avgKcal, {super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UpdateFitnessModel>(
      create: (context) => UpdateFitnessModel(avgKcal),
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              height: 350,
              width: 350,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://media.istockphoto.com/vectors/first-prize-gold-trophy-iconprize-gold-trophy-winner-first-prize-vector-id1183252990?k=20&m=1183252990&s=612x612&w=0&h=BNbDi4XxEy8rYBRhxDl3c_bFyALnUUcsKDEB5EfW2TY="),
                ),
              ),
            ),    //Trophy Image
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Consumer<UpdateFitnessModel>(
                          builder: (context, myModel, child) {
                        return Text(
                          myModel.kcal.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 26),
                        );
                      }),
                      Text(
                        translate(context).kcal,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Consumer<UpdateFitnessModel>(
                          builder: (context, myModel, child) {
                        return Text(
                          myModel.difference.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 26),
                        );
                      }),
                      Text(
                        translate(context).minutes,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                    ],
                  )
                ],
              ),
            ),    //Workout data
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text(translate(context).doAgainBody),
                                actionsAlignment: MainAxisAlignment.spaceEvenly,
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(translate(context).cancel)),
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Ready(
                                                      yogaTablename:
                                                          yogaTableName,
                                                      index: index,
                                                      avgKcal: avgKcal,
                                                    )));
                                      },
                                      child: Text(translate(context).yes))
                                ],
                              ));
                    },
                    child: Row(
                      children: [
                        Text(
                          translate(context).doAgain,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.blue),
                        ),
                        const Icon(
                          Icons.redo_sharp,
                          size: 24,
                          color: Colors.blue,
                        )
                      ],
                    ),
                  ),    //Redo Button
                  Row(
                    children: [
                      Text(
                        translate(context).share,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.blue),
                      ),
                      const Icon(
                        Icons.share,
                        size: 24,
                        color: Colors.blue,
                      )
                    ],
                  )      //Share button
                ],
              ),
            ),
            const Divider(thickness: 2),
            ElevatedButton(
                onPressed: () async {
                  await launchUrl(Uri.parse(
                      "https://play.google.com/store/apps/details?id=com.dhruv.aiem"));
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    backgroundColor: Colors.blue),
                child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Text(
                      translate(context).rateApp,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ))),       //Rate App Button
            TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Home()));
                },
                child: Text(
                  translate(context).goHome,
                  style: const TextStyle(color: Colors.blue, fontSize: 18),
                )),
            const SizedBox(
              height: 3,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 157,
              color: Colors.redAccent,
              child: const Text("Hello"),
            ),
            Consumer<UpdateFitnessModel>(builder: (context, myModel, child) {
              return const SizedBox();
            })
          ],
        ),
      ),
    );
  }
}

class UpdateFitnessModel extends ChangeNotifier {
  late int avgKcal;
  UpdateFitnessModel(this.avgKcal) {
    readUpdateMins();
    updateKcal();
  }
  late int exKcal;
  late int kcal;
  late int difference = 0;
  void readUpdateMins() async {
    if (kDebugMode) {
      print("Method Called");
    }
    DateTime tempDate = DateFormat("yy-MM-dd hh:mm:ss")
        .parse(await LocalDB.getStartTime() ?? "2022-05-24 19:31:15.182");
    difference = DateTime.now().difference(tempDate).inMinutes;
    int workoutMin = await LocalDB.getWorkOutMin() ?? 0;
    await LocalDB.saveWorkOutMin(workoutMin + difference);
    notifyListeners();
  }

  void updateKcal() async {
    kcal = avgKcal * (difference / 60).round();
    notifyListeners();
    exKcal = await LocalDB.getKcal() ?? 0;
    await LocalDB.saveKcal(exKcal + kcal);
  }
}
