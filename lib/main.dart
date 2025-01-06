import 'package:echonotes/echoNote.dart';
import 'package:echonotes/listPage.dart';
import 'package:echonotes/passData1.dart';
import 'package:echonotes/passData2.dart';
import 'package:echonotes/taskPage.dart';
import 'package:echonotes/textPage.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('mydata');
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: EchoNotes(),
    routes: {
      "echo": (context) => EchoNotes(),
      "list": (context) => ListPage(),
      "task": (context) => Task(),
      "text": (context) => TextPage(),
      "data1": (context) => PassData1(),
      "data2": (context) => PassData2(),
    },
  ));
}
