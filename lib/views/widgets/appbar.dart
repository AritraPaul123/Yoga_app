import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:yoga_app/main.dart';
import 'package:yoga_app/services/databases/localDB.dart';
import 'package:yoga_app/constants.dart';

class CustomAppBar extends StatelessWidget {
  final AnimationController animationController;
  final Animation colorTween, iconTween, drawerTween, homeTween, yogaTween;
  final Function()? onPressed;
  const CustomAppBar(
      {super.key,
      required this.animationController,
      required this.colorTween,
      required this.drawerTween,
      required this.homeTween,
      required this.iconTween,
      required this.onPressed,
      required this.yogaTween});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) => AppBar(
                elevation: 0,
                backgroundColor: colorTween.value,
                leading: IconButton(
                  icon: Icon(
                    Icons.dehaze,
                    color: iconTween.value,
                  ),
                  onPressed: onPressed,
                ),
                title: Row(
                  children: [
                    Text(translate(context).home,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: homeTween.value)),    //Home text
                    const SizedBox(width: 6),
                    Text(translate(context).yoga,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: yogaTween.value)),    //Yoga text
                  ],
                ),
                actions: [
                  DropdownButton(
                      items: languages,
                      hint: const Icon(
                        Icons.translate,
                        color: Colors.white,
                      ),
                      iconSize: 30,
                      iconEnabledColor: Colors.white,
                      underline: Container(
                        height: 1,
                        color: Colors.white.withOpacity(0.8),
                      ),
                      onChanged: (String? languageCode) async {
                        if (languageCode != null) {
                          await LocalDB.setLocale(languageCode);               //Sets locale data to local database
                          MyApp.setLocale(Locale(languageCode), context);      //Sets the locale of the app
                        }
                      }),
                  IconButton(
                    color: iconTween.value,
                    onPressed: () {
                      showSimpleNotification(
                          Text(translate(context).notification),
                          background: Colors.grey);
                    },
                    icon: const Icon(Icons.notifications),
                  ),       //Bell notification button
                  const SizedBox(
                    width: 15,
                  )
                ],
              )),
    );
  }
}
