import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:yoga_app/constants.dart';
import 'package:yoga_app/views/screens/settings.dart';
import '../../services/databases/localDB.dart';
import '../screens/home.dart';
import 'package:url_launcher/url_launcher.dart';

class Customdrawer extends StatelessWidget {
  const Customdrawer({super.key});

  Future<void> shareApp() async {
    await FlutterShare.share(
        title: "Hey, I Am Using Yoga For Beginners App",
        text:
            "Try Out This Awesome Home Yoga App. It Has Yoga Packs For All Age Groups Including Nerds To Athletics.",
        linkUrl: "https://flutter.dev/",
        chooserTitle: "Example Chooser Title");
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 230,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://images.unsplash.com/photo-1524863479829-916d8e77f114?q=80&w=1770&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"), //Drawer Image
                    fit: BoxFit.cover)),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            //Restart progress
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        actionsAlignment: MainAxisAlignment.spaceEvenly,
                        actionsPadding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 0),
                        title: Text(translate(context).restartDialogHead),
                        content: Text(
                          translate(context).restartDialogBody,
                          style: const TextStyle(fontSize: 16),
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                            child: Text(
                              translate(context).cancel,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              await LocalDB.saveWorkOutMin(0);
                              await LocalDB.saveStreak(0);
                              await LocalDB.saveKcal(0);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Home()));
                            },
                            child: Text(
                              translate(context).reset,
                              style: const TextStyle(fontSize: 20),
                            ),
                          )
                        ],
                      ));
            },
            leading: const Icon(Icons.restart_alt_sharp, size: 25),
            title: Text(
              translate(context).restartProgress,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          ListTile(
            //Share App
            onTap: shareApp,
            leading: const Icon(Icons.share, size: 25),
            title: Text(
              translate(context).shareFriends,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          ListTile(
            //Rate us
            onTap: () async {
              await launchUrl(Uri.parse(
                  "https://play.google.com/store/apps/details?id=com.dhruv.aiem"));
            },
            leading: const Icon(Icons.star, size: 25),
            title: Text(
              translate(context).rate,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          ListTile(
            //privacy policy
            onTap: () async {
              await launchUrl(Uri.parse(
                  "https://sites.google.com/view/yogaforbeginners-indianyoga/privacy-policy"));
            },
            leading: const Icon(Icons.security, size: 25),
            title: Text(
              translate(context).privacypolicy,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          ListTile(
            //Settings
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Settings()));
            },
            leading: const Icon(Icons.settings, size: 25),
            title: Text(
              translate(context).settings,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          const Divider(thickness: 3, indent: 18, endIndent: 18),
          Text(
            "${translate(context).version}: 1.0.0",
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
