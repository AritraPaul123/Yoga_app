import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDB {
  static const languageCode = "LanguageCode";
  static const timeKeyStart = "timeKeyStart";
  static const timeKeyEnd = "timeKeyEnd";
  static const minKey = "minKey";
  static const calKey = "KcalKey";
  static const ldKey = "ldKey";
  static const streakKey = "streakKey";

  static Future<Locale> setLocale(String lanCode) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(languageCode, lanCode);
    return const Locale(languageCode);
  }

  static Future<Locale> getLocale() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String lanCode = preferences.getString(languageCode) ?? "en";
    return Locale(lanCode);
  }

  static Future<bool> saveStartTime(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(timeKeyStart, value);
  }

  static Future<String?> getStartTime() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? data = preferences.getString(timeKeyStart);
    return data;
  }

  static Future<bool> saveWorkOutMin(int value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setInt(minKey, value);
  }

  static Future<int?> getWorkOutMin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? data = preferences.getInt(minKey);
    return data;
  }

  static Future<bool> saveKcal(int value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setInt(calKey, value);
  }

  static Future<int?> getKcal() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? data = preferences.getInt(calKey);
    return data;
  }

  static Future<bool> saveLastDateOn(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(ldKey, value);
  }

  static Future<String?> getLastDateOn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? date = preferences.getString(ldKey);
    return date;
  }

  static Future<bool> saveStreak(int value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setInt(streakKey, value);
  }

  static Future<int?> getStreak() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? data = preferences.getInt(streakKey);
    return data;
  }
}
