import 'package:flutter/material.dart';

class Task extends StatefulWidget {
  const Task({super.key});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  TextEditingController title = TextEditingController();
  TextEditingController task = TextEditingController();
  DateTime _currentDate = DateTime.now();
  TimeOfDay _currentTime = TimeOfDay.now();

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
            onPressed: () {},
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
