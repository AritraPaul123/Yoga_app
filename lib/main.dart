import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:yoga_app/screens/finish.dart';
import 'package:yoga_app/screens/startup.dart';
import 'screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          fontFamily: "SF Pro",
          useMaterial3: true,
        ),
        home: Home(),
      ),
    );
  }
}

