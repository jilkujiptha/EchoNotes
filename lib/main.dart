import 'package:echonotes/echoNote.dart';
import 'package:echonotes/listPage.dart';
import 'package:echonotes/taskPage.dart';
import 'package:echonotes/textPage.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('mydata');
  runApp(MaterialApp(
    home: EchoNotes(),
    routes: {
      "echo": (context) => EchoNotes(),
      "list": (context) => ListPage(),
      "task": (context) => Task(),
      "text": (context) => TextPage(),
    },
  ));
}
// GestureDetector(
//                                     onTap: () {
//                                       animatedContainer();
//                                     },
//                                     child: AnimatedContainer(
//                                       width: _isanimated ? 100 : 13,
//                                       height: _isanimated ? 100 : 13,
//                                       // curve: Curves.easeIn,
//                                       duration: Duration(seconds: 1),
//                                       child: _isanimated
//                                           ? Image.asset(
//                                               "./images/upload.png",
//                                               width: 13,
//                                               height: 13,
//                                               color: Colors.white,
//                                             )
//                                           : Image.asset(
//                                               "./images/down-arrow.png",
//                                               width: 13,
//                                               height: 13,
//                                               color: Colors.white,
//                                             ),
//                                     ),
//                                   ),
//  DropdownButton<String>(
//                                   icon: Icon(
//                                     Icons.more_vert,
//                                     color: Colors.white,
//                                   ),
//                                   dropdownColor: Colors.white,
//                                   padding: EdgeInsets.all(10),
//                                   underline: Container(
//                                     height: 0,
//                                   ),
//                                   items: editDelete.map((String edit) {
//                                     return DropdownMenuItem(
//                                         value: edit,
//                                         child: Text(
//                                           edit,
//                                         ));
//                                   }).toList(),
//                                   onChanged: (value) {
//                                     setState(() {
//                                       Value = value;
//                                     });
//                                   },
//                                 ), Text(
                                //   data["title"],
                                //   style: TextStyle(color: Colors.white),
                                // ),