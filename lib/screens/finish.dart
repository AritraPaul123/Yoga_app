import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yoga_app/screens/ready.dart';

import '../services/model.dart';
import 'home.dart';

class Finish extends StatelessWidget {
  String YogaTableName;
  int index;
  int AvgKcal;
  Finish(this.YogaTableName, this.index, this.AvgKcal);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UpdateFitnessModel>(
      create: (context)=>UpdateFitnessModel(AvgKcal),
      child: Scaffold(
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                height: 350,
                width: 350,
                decoration: BoxDecoration(image: DecorationImage(image: NetworkImage("https://media.istockphoto.com/vectors/first-prize-gold-trophy-iconprize-gold-trophy-winner-first-prize-vector-id1183252990?k=20&m=1183252990&s=612x612&w=0&h=BNbDi4XxEy8rYBRhxDl3c_bFyALnUUcsKDEB5EfW2TY="),),),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 50,vertical: 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Consumer<UpdateFitnessModel>(
                          builder: (context, myModel, child){
                          return Text(myModel.kcal.toString(), style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 26),);
  }
                        ),
                        Text("KCAL",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                      ],
                    ),
                    Column(
                      children: [
                        Consumer<UpdateFitnessModel>(
                    builder: (context, myModel, child) {
                      return Text(myModel.difference.toString(), style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 26),);
                    }
                            ),
                        Text("Minutes",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 35,vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: (){
                        showDialog(context: context, builder: (context)=>AlertDialog(
                          title: Text("Do You Want To Do It Again?"),
                          actionsAlignment: MainAxisAlignment.spaceEvenly,
                          actions: [
                            ElevatedButton(onPressed: (){
                              Navigator.pop(context);
                            }, child: Text("CANCEL")),
                            ElevatedButton(onPressed: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Ready(YogaTablename: YogaTableName,index: index, Avgkcal: AvgKcal,)));
                            }, child: Text("YES"))
                          ],
                        ));
                      },
                      child: Row(
                        children: [
                          Text("Do Again",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20,color: Colors.blue),),
                          Icon(Icons.redo_sharp,size: 24,color: Colors.blue,)
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text("Share",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20,color: Colors.blue),),
                        Icon(Icons.share,size: 24,color: Colors.blue,)
                      ],
                    )
                  ],
                ),
              ),
              Divider(thickness: 2),
              ElevatedButton(onPressed: () async {
                await launchUrl(Uri.parse("https://play.google.com/store/apps/details?id=com.dhruv.aiem"));
              },
                  style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),backgroundColor: Colors.blue),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                    child: Text("RATE OUR APP",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.white),))
              ),
              TextButton(onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
              },
                  child: Text("GO TO HOME",style: TextStyle(color: Colors.blue,fontSize: 18),)
              ),
              SizedBox(height: 3,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 157,
                color: Colors.redAccent,
                child: Text("Hello"),
              ),
              Consumer<UpdateFitnessModel>(
                  builder: (context, myModel, child){
                    return SizedBox();
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
class UpdateFitnessModel extends ChangeNotifier{
  late int Avgkcal;
  UpdateFitnessModel(this.Avgkcal){
  ReadUpdateMins();
  UpdatekCal();
  }
  late int exKcal;
  late int kcal;
  late int difference=0;
  void ReadUpdateMins() async {
    print("Method Called");
    DateTime tempDate=new DateFormat("yy-MM-dd hh:mm:ss").parse(await LocalDB.getStartTime()?? "2022-05-24 19:31:15.182");
    difference=DateTime.now().difference(tempDate).inMinutes;
    int workoutmin=await LocalDB.getWorkOutMin()?? 0;
    await LocalDB.saveWorkOutMin(workoutmin+difference);
    notifyListeners();
  }
  void UpdatekCal() async {
    kcal=Avgkcal*(difference/60).round();
    notifyListeners();
    exKcal=await LocalDB.getKcal()?? 0;
    await LocalDB.saveKcal(exKcal+kcal);
  }
}
