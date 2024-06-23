import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:yoga_app/views/screens/home.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'services/databases/localDB.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(Locale locale, BuildContext context){
    _MyAppState? state=context.findAncestorStateOfType<_MyAppState>();        //storing the current state of the app.
    state?.setlocale(locale);          //changing the locale of app at current state level to reflect immediate translation without app restart
  }

}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setlocale(Locale locale){    //Set the locale
    setState(() {
      _locale=locale;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    LocalDB.getLocale().then((locale)=>{     //On change in dependency, locale data is fetched from Local database
      setlocale(locale)
    });
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Home Yoga',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: _locale,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          fontFamily: "SF Pro",
          useMaterial3: true,
        ),
        home: const Home(),
      ),
    );
  }
}

