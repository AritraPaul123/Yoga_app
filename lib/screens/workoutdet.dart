import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:yoga_app/screens/finish.dart';
import 'package:yoga_app/screens/ready.dart';
import '../services/model.dart';
import 'break.dart';

class Workoutdet extends StatelessWidget {
  List<Yoga> AllYoga;
  String YogaTableName;
  int yogaindex;
  int Avgkcal;
  Workoutdet(this.AllYoga, this.yogaindex, this.YogaTableName, this.Avgkcal);
  @override
  bool isSingleDigit(int number){
    return (number<10);
  }
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context)=>TimerModel2(context, AllYoga, yogaindex, AllYoga[yogaindex].Seconds,YogaTableName, AllYoga[yogaindex].SecondsOrTimes, Avgkcal),
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 280,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(AllYoga[yogaindex].YogaImgUrl.toString()),fit: BoxFit.cover)
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(AllYoga[yogaindex].YogaTitle, style: TextStyle(fontSize: 28,fontWeight: FontWeight.w600),textAlign: TextAlign.center),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(AllYoga[yogaindex].Description,style: TextStyle(fontSize: 18)),
                    ),
                    Spacer(),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 120),
                      padding: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: Colors.lightBlue),
                      child: AllYoga[yogaindex].Seconds? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Consumer<TimerModel2>(
                            builder: (context, myModel, child){
                              return Text("${myModel.minutes} : ",style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold));
  }
                          ),
                          Consumer<TimerModel2>(
                              builder: (context, myModel1, child){
                                return Text(isSingleDigit(myModel1.secs)?myModel1.secs.toString().padLeft(2,"0"): myModel1.secs.toString(),style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),);
                              }
                          ),
                        ],
                      ): Text("X${AllYoga[yogaindex].SecondsOrTimes}",style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold))
                    ),
                    Spacer(),
                    AllYoga[yogaindex].Seconds ? Consumer<TimerModel2>(
                      builder: (context, myModel3, child){
                      return ElevatedButton(onPressed: (){
                        myModel3.showPause();
                      },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                        child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Text("PAUSE",style: TextStyle(fontSize: 21,color: Colors.white,fontWeight: FontWeight.w600),)
                        ),
                      );
                  }
                    ): SizedBox(),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        yogaindex!=0 ? Consumer<TimerModel2>(
                          builder: (context, myModel, child){
                          return TextButton(onPressed: () async{
                            myModel.passOn();
                            await Future.delayed(Duration(seconds: 1));
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Break(AllYoga, yogaindex-1,YogaTableName, Avgkcal)));
                          },
                              child: Row(
                                children: [
                                  Icon(Icons.skip_previous_sharp,color: Colors.blue,size: 28),
                                  Text("Previous",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.blue)),
        
                                ],
                              )
                          );
          }
                        ): SizedBox(),
                        yogaindex!=AllYoga.length-1 ? Consumer<TimerModel2>(
                          builder: (context, myModel, child){
                          return TextButton(onPressed: () async {
                            myModel.passOn();
                            await Future.delayed(Duration(seconds: 1));
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Break(AllYoga, yogaindex+1,YogaTableName, Avgkcal)));
                          },
                              child: Row(
                                children: [
                                  Text("Next",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.blue)),
                                  Icon(Icons.skip_next_sharp,color: Colors.blue,size: 28)
                                ],
                              )
                          );
          }
                        ): Consumer<TimerModel2>(
                            builder: (context, myModel, child){
                              return TextButton(onPressed: () async {
                                myModel.passOn();
                                await Future.delayed(Duration(seconds: 1));
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Finish(YogaTableName, yogaindex, Avgkcal)));
                              },
                                  child: Text("Finish",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.blue))
                              );
                            }
                        ),
                      ],
                    ),
                    Divider(thickness: 2),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: yogaindex!=AllYoga.length-1? Text("Next: ${AllYoga[yogaindex+1].YogaTitle}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),):SizedBox(),
                      ),)
                  ],
                ),
              ),
              Consumer<TimerModel2>(
                builder: (context, myModel1, child){
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
                              Text("PAUSE",style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),),
                              Icon(Icons.pause,color: Colors.white,size: 43,)
                            ],
                          ),
                          SizedBox(height: 10,),
                          Text("Yoga For 15 Mins Makes You Feel Better.",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 22,color: Colors.white),textAlign: TextAlign.center,),
                          SizedBox(height: 40),
                          OutlinedButton(onPressed: (){
                            myModel1.hidePause(context);
                          },
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
                              child: Container(
                                width: 90,
                                child: Text("RESUME",style: TextStyle(fontSize: 20,color: Colors.blue,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                              ),
                          ),
                          SizedBox(height: 10),
                          OutlinedButton(onPressed: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Ready(YogaTablename: YogaTableName, index: 0, Avgkcal: Avgkcal,)));
                          },
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
                            child: Container(
                              width: 90,
                              child: Text("RESTART",style: TextStyle(fontSize: 20,color: Colors.blue,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                            ),
                          ),
                          SizedBox(height: 10),
                          OutlinedButton(onPressed: (){
                            Navigator.pop(context);
                          },
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
                            child: Container(
                              width: 90,
                              child: Text("QUIT",style: TextStyle(fontSize: 20,color: Colors.blue,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                            ),
                          ),
                        ],
                      ),
                    )
                );
              }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class TimerModel2 extends ChangeNotifier{
  List<Yoga> allYogaList;
  String YogaTableName;
  int yogaIndex;
  int AvgKcal;
  bool secondsornot;
  late String countTime;
  TimerModel2(context, this.allYogaList, this.yogaIndex, this.secondsornot,this.YogaTableName, this.countTime, this.AvgKcal){
    setTimer(int.parse(countTime));
    checkIfLast();
    if(yogaIndex==0){
      savestartTime();
      ReadUpdateStreak();
    }
    if(secondsornot) {
      TimerFunc(context);
    }
  }
  bool visibilty=false;
  late int countdown2;
  late int minutes,secs;
  Timer? timer;
  bool pass=false;
  bool isLast=false;
  TimerFunc(context) async {
    Timer.periodic(Duration(seconds: 1), (timer){
      visibilty? countdown2+0 :countdown2--;
      minutes=(countdown2/60).floor();
      secs=(countdown2%60);
      notifyListeners();
      if(countdown2==0){
        timer.cancel();
        timer.cancel();
        isLast? Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Finish(YogaTableName,yogaIndex,AvgKcal))) :
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Break(allYogaList, yogaIndex+1,YogaTableName, AvgKcal)));
      }
      if(pass){
        timer.cancel();
      }
    });
  }
  void showPause(){
    visibilty=true;
    notifyListeners();
  }
  void hidePause(context){
    visibilty=false;
    notifyListeners();
  }
  void passOn(){
    pass=true;
    notifyListeners();
  }
  void setTimer(int count_time){
    countdown2=count_time;
    minutes=(countdown2/60).floor();
    secs=(countdown2%60);
    notifyListeners();
  }
  void checkIfLast(){
    isLast=yogaIndex>=allYogaList.length-1;
    notifyListeners();
  }
  void savestartTime() async{
    String StartTime=DateTime.now().toString();
    await LocalDB.saveStartTime(StartTime);
    await LocalDB.saveLastDateOn(StartTime);
  }
  void ReadUpdateStreak() async {
    DateTime tempDate=new DateFormat("yy-MM-dd hh:mm:ss").parse(await LocalDB.getLastDateOn()?? "2022:05:24 19:31:15.182");
    int difference=DateTime.now().difference(tempDate).inDays;
    if(difference==0){
      print("Same Day");
    }else if(difference==1){
      print("Streak Maintained");
      int preStreak=jsonDecode(await LocalDB.getStreak().toString())?? 0;
      await LocalDB.saveStreak(preStreak+1);
    }
    else{
      print("Streak Broken");
      await LocalDB.saveStreak(1);
    }
    int workoutmin=await LocalDB.getWorkOutMin()?? 0;
  }
}


