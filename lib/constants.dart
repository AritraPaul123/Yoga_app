import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

 List<DropdownMenuItem<String>> languages=const [
  DropdownMenuItem(value: "en",child: Text("English")),
  DropdownMenuItem(value: "hi",child: Text("हिंदी")),
  DropdownMenuItem(value: "bn",child: Text("বাংলা")),
];

AppLocalizations translate(BuildContext context){
  return AppLocalizations.of(context)!;
}