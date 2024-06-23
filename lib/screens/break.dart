import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoga_app/screens/workoutdet.dart';
import '../services/model.dart';

class Break extends StatelessWidget {
  late List<Yoga> ListYoga;
  late int yogaindex;
  late String Yogatablename;
  late int Avgkcal;
  Break(this.ListYoga, this.yogaindex, this.Yogatablename, this.Avgkcal);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context)=>TimerModel3(context, ListYoga, yogaindex,Yogatablename, Avgkcal),
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(image: DecorationImage(image: NetworkImage("https://images.unsplash.com/photo-1558017487-06bf9f82613a?q=80&w=1970&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",),fit: BoxFit.cover,opacity: 0.4,colorFilter: ColorFilter.mode(Colors.black45, BlendMode.color))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Spacer(),
              Text("Break Time",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 38)),
              SizedBox(height: 30),
              Consumer<TimerModel3>(
                  builder: (context, myModel, child){
                    return Text(myModel.countdown3.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 58));
                  }
              ),
                SizedBox(height: 60),
              Consumer<TimerModel3>(
                builder: (context, myModel, child){
                return ElevatedButton(onPressed: (){
                  myModel.skip();
                },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                      child: Text("SKIP",style: TextStyle(fontSize: 21,color: Colors.white,fontWeight: FontWeight.w600),
                    )
                ),
                );
  }
              ),
                Spacer(),
              Divider(thickness: 2,color: Colors.black26,),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Text("Next: ${ListYoga[yogaindex].YogaTitle}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                ),)
            ],
          ),
        ),
      ),
    );
  }
}
class TimerModel3 extends ChangeNotifier{
  List<Yoga> allYogaList;
  String Yogatablename;
  int yogaIndex;
  int Avgkcal;
  bool skipbreak=false;
  TimerModel3(context, this.allYogaList, this.yogaIndex, this.Yogatablename, this.Avgkcal){
    TimerFunc(context);
  }
  int countdown3=20;
  Timer? timer;
  TimerFunc(context) async {
    Timer.periodic(Duration(seconds: 1), (timer){
      countdown3--;
      notifyListeners();
      if(countdown3==0 || skipbreak){
        timer.cancel();
        timer.cancel();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Workoutdet(allYogaList, yogaIndex,Yogatablename, Avgkcal)));
      }
    });
  }
  void skip(){
    skipbreak=true;
    notifyListeners();
  }
}

