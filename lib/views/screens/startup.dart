import 'package:flutter/material.dart';
import 'package:yoga_app/views/screens/ready.dart';
import 'package:yoga_app/services/databases/yogadb.dart';
import '../../models/model.dart';
import 'package:yoga_app/constants.dart';

class Startup extends StatefulWidget {
  final YogaSummary yogaSum;
  const Startup(this.yogaSum, {super.key});
  @override
  State<Startup> createState() => _StartupState();
}

class _StartupState extends State<Startup> {
  late List<Yoga> allYogaList;
  bool isLoading = true;
  Future readAllYogaList() async {
    allYogaList =
        await YogaDataBase.instance.readAllYoga(widget.yogaSum.WorkOutName);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    readAllYogaList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  translate(context).start,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Ready(
                            yogaTablename: widget.yogaSum.WorkOutName,
                            index: 0,
                            avgKcal: int.parse(widget.yogaSum.KCAL))));
              },
            ),
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.blue,
                  actions: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.thumb_up_alt_rounded,
                          color: Colors.white,
                        ))
                  ],
                  expandedHeight: 300,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                        widget.yogaSum.BackImgUrl.toString(),
                        fit: BoxFit.cover),
                    title: Text(
                      widget.yogaSum.YogaPackName,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    centerTitle: true,
                    collapseMode: CollapseMode.parallax,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  "${widget.yogaSum.TotalTime} ${translate(context).minutes} • ${widget.yogaSum.TotalWorkOut} ${translate(context).workouts}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            ],
                          ),
                          const Divider(thickness: 2),
                          ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => ListTile(
                                    leading: Container(
                                      margin: const EdgeInsets.only(right: 15),
                                      child: Image.network(
                                        "https://institute.careerguide.com/wp-content/uploads/2020/10/Yoga-animation.gif",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    title: Text(
                                      allYogaList[index].YogaTitle,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    subtitle: Text(
                                      allYogaList[index].Seconds
                                          ? "${int.parse(allYogaList[index].SecondsOrTimes) ~/ 60}:${(int.parse(allYogaList[index].SecondsOrTimes) % 60).toString().padLeft(2, "0")}"
                                          : "X${allYogaList[index].SecondsOrTimes}",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                              separatorBuilder: (context, index) =>
                                  const Divider(thickness: 2),
                              itemCount: allYogaList.length)
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
  }
}
