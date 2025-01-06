import 'package:echonotes/echoNote.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class Task extends StatefulWidget {
  const Task({super.key});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  TextEditingController title = TextEditingController();
  TextEditingController task = TextEditingController();
  final DateTime _currentDate = DateTime.now();
  final TimeOfDay _currentTime = TimeOfDay.now();
  List list = [];
  List taskPage = [];
  final _mydata = Hive.box('mydata');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 36, 167, 40),
        title: Text(
          "Add New Task",
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
              } else if (task.text == "") {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Content is empty"),
                  ),
                );
              } else {
                var data = {
                  "title": title.text,
                  "items": task.text,
                  "time": "${_currentTime.hour}:${_currentTime.minute}",
                  "date":
                      "${_currentDate.year}-${_currentDate.month}-${_currentDate.day}",
                  "_isUpdown": false,
                };
                if (_mydata.get('Task') != null) {
                  list = _mydata.get('Task');
                  list.add(data);
                  _mydata.put('Task', list);
                } else {
                  list.add(data);
                  _mydata.put('Task', list);
                }
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => EchoNotes(),
                  ),
                  (route) => false,
                );
              }
              print("======================================================");
              print(_mydata.get('Task'));
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
        margin: EdgeInsets.all(10),
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
                controller: task,
                maxLines: 200,
                decoration: InputDecoration(
                    labelText: "Description",
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
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                    "${_currentDate.year}-${_currentDate.month}-${_currentDate.day}",
                    style: TextStyle(
                        color: const Color.fromARGB(255, 36, 167, 40),
                        fontWeight: FontWeight.bold)),
                Spacer(),
                Text("${_currentTime.hour}:${_currentTime.minute}",
                    style: TextStyle(
                        color: const Color.fromARGB(255, 36, 167, 40),
                        fontWeight: FontWeight.bold))
              ],
            )
          ],
        ),
      ),
    );
  }
}
