import 'package:flutter/material.dart';
import 'package:yoga_app/constants.dart';
import '../../main.dart';
import '../../services/databases/localDB.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var _currentVal = "hi";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(translate(context).settings),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 18),
        child: Row(
          children: [
            Text(translate(context).changeAppLanguage,
                style: const TextStyle(fontSize: 20)),
            const Spacer(),
            DropdownButton(
                iconEnabledColor: Colors.white,
                underline: Container(height: 2, color: Colors.black26),
                items: languages,
                hint: Text(_currentVal),
                iconSize: 40,
                onChanged: (String? languageCode) async {
                  if (languageCode != null) {
                    setState(() {
                      _currentVal = languageCode;
                    });
                    await LocalDB.setLocale(
                        languageCode); //Stores Locale through Shared Preferences
                    MyApp.setLocale(
                        Locale(languageCode), context); //set Locale of the app
                  }
                })
          ],
        ),
      ),
    );
  }
}
