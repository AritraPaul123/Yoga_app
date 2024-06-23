import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import '../screens/home.dart';
import '../services/model.dart';
import 'package:url_launcher/url_launcher.dart';

class Customdrawer extends StatelessWidget {
   Customdrawer({super.key});

  Future<void> shareApp() async {
      await FlutterShare.share(
          title: "Hey, I Am Using Yoga For Beginners App",
          text: "Try Out This Awesome Home Yoga App. It Has Yoga Packs For All Age Groups Including Nerds To Athletics.",
          linkUrl: "https://flutter.dev/",
          chooserTitle: "Example Chooser Title"
      );
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 230,
            decoration: BoxDecoration(image: DecorationImage(image: NetworkImage("https://images.unsplash.com/photo-1524863479829-916d8e77f114?q=80&w=1770&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),fit: BoxFit.cover)),
          ),
          SizedBox(height: 10,),
          ListTile(
            onTap: (){
              showDialog(context: context, builder: (context)=>AlertDialog(
                actionsAlignment: MainAxisAlignment.spaceEvenly,
                actionsPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                title: Text("RESET PROGRESS"),
                content: Text("This will reset all of your fitness data including Total Workout Time, Streak and Burned Calories. The action cannot be revert once done.",style: TextStyle(fontSize: 16),),
                actions: [
                  ElevatedButton(onPressed: () async{
                    Navigator.pop(context);
                  },
                      child: Text("CANCEL",style: TextStyle(fontSize: 20),),
                  ),
                  ElevatedButton(onPressed: () async {
                    await LocalDB.saveWorkOutMin(0);
                    await LocalDB.saveStreak(0);
                    await LocalDB.saveKcal(0);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
                  },
                      child: Text("RESET",style: TextStyle(fontSize: 20),),
                  )
                ],
              )
              );
            },
            leading: Icon(Icons.restart_alt_sharp,size: 25),
            title: Text("Restart Progress",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
          ),
          ListTile(
            onTap: shareApp,
            leading: Icon(Icons.share,size: 25),
            title: Text("Share With Friends",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
          ),
          ListTile(
            onTap: () async {
              await launchUrl(Uri.parse("https://play.google.com/store/apps/details?id=com.dhruv.aiem"));
            },
            leading: Icon(Icons.star,size: 25),
            title: Text("Rate Us",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
          ),
          ListTile(
            onTap: () async {
              await launchUrl(Uri.parse("https://sites.google.com/view/yogaforbeginners-indianyoga/privacy-policy"));
            },
            leading: Icon(Icons.security,size: 25),
            title: Text("Privacy Policy",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
          ),
          Divider(thickness: 3,indent: 18,endIndent: 18),
          Text("Version: 1.0.0",style: TextStyle(fontSize: 16),),
        ],
      ),
    );
  }
}
