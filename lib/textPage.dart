import 'package:echonotes/echoNote.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class TextPage extends StatefulWidget {
  const TextPage({super.key});

  @override
  State<TextPage> createState() => _TextState();
}

class _TextState extends State<TextPage> {
  TextEditingController title = TextEditingController();
  TextEditingController text = TextEditingController();
  final _mydata = Hive.box('mydata');
  List list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 36, 167, 40),
        title: Text(
          "Add New Note",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (title.text == "") {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Empty title"),
                  ),
                );
              } else if (text.text == "") {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Content is empty"),
                  ),
                );
              } else {
                var data = {
                  "title": title.text,
                  "items": text.text,
                };
                if (_mydata.get('text') != null) {
                  list = _mydata.get('text');
                  list.add(data);
                  _mydata.put('text', list);
                } else {
                  list.add(data);
                  _mydata.put('text', list);
                }
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => EchoNotes(),
                  ),
                  (route) => false,
                );
              }
              print("======================================================");
              print(_mydata.get('text'));
            },
            icon: Icon(
              Icons.done,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: title,
              decoration: InputDecoration(
                  labelText: "Title",
                  labelStyle: TextStyle(
                    color: const Color.fromARGB(255, 36, 167, 40),
                  ),
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: const Color.fromARGB(255, 36, 167, 40),
                          width: 2))),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: TextField(
                controller: text,
                maxLines: 200,
                decoration: InputDecoration(
                    labelText: "Content",
                    alignLabelWithHint: true,
                    labelStyle: TextStyle(
                      color: const Color.fromARGB(255, 36, 167, 40),
                    ),
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: const Color.fromARGB(255, 36, 167, 40),
                            width: 2))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
