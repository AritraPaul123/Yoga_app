import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoga_app/screens/workoutdet.dart';
import 'package:yoga_app/services/yogadb.dart';
import '../services/model.dart';

class Ready extends StatelessWidget {
  late String YogaTablename;
  late int index=0;
  late int Avgkcal;
  Ready({required this.YogaTablename,required this.index, required this.Avgkcal});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TimerModel>(
        create: (context)=>TimerModel(context,YogaTablename,Avgkcal),
        child: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Scaffold(
            body: Center(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height/2-100,),
                    Text("ARE YOU READY?",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                    SizedBox(height: 40),
                    Consumer<TimerModel>
                      (builder: (context, myModel, child){
                        return Text(myModel.countdown.toString(),style: TextStyle(fontSize: 48),);
                    }),
                    Spacer(),
                    Divider(thickness: 2),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: Text("Tip: Breathe Slowly While Doing Stretching Yoga",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                    ),)
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}
class TimerModel extends ChangeNotifier{
  late String Tablename;
  late int Avgkcal;
  TimerModel(context,this.Tablename, this.Avgkcal){
  TimerFunc(context);
  FetchAllYoga(Tablename);
}
  int countdown=5;
  Timer? timer;
  late List<Yoga> allYoga;

  bool pass=false;
  bool skip=false;
  TimerFunc(context,) async {
    Timer.periodic(Duration(seconds: 1), (timer){
      countdown--;
      notifyListeners();
      if(countdown==0 || skip){
        timer.cancel();
        timer.cancel();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Workoutdet(allYoga,0,Tablename, Avgkcal)));
      }
      if(pass){
        timer.cancel();
      }
    });
  }
  Future<List<Yoga>> FetchAllYoga(String Tablename) async {
    this.allYoga=await YogaDataBase.instance.readAllYoga(Tablename);
    notifyListeners();
    return allYoga;
  }
  void passOn(){
    pass=true;
    notifyListeners();
  }
  void skipready() async {
    skip=true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
  }
}
