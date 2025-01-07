import 'package:echonotes/echoNote.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:table_calendar/table_calendar.dart';

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
  DateTime _selectedDay = DateTime.now();
  DateTime _focuseDay = DateTime.now();

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
                  "date": _selectedDay,
                  "_isUpdown": false,
                  "_isComplete": false,
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
                TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            child: Container(
                              // padding: EdgeInsets.all(10),
                              height: 500,
                              width: 400,
                              child: Column(
                                children: [
                                  TableCalendar(
                                    firstDay: DateTime.utc(2020, 1, 1),
                                    lastDay: DateTime.utc(2030, 12, 31),
                                    focusedDay: _focuseDay,
                                    selectedDayPredicate: (day) {
                                      return isSameDay(_selectedDay, day);
                                    },
                                    onDaySelected: (selectedDay, focusedDay) {
                                      setState(() {
                                        _selectedDay = selectedDay;
                                        _focuseDay = focusedDay;
                                      });
                                    },
                                    calendarFormat: CalendarFormat.month,
                                    startingDayOfWeek: StartingDayOfWeek.monday,
                                    calendarStyle: CalendarStyle(
                                      selectedDecoration: BoxDecoration(
                                        color: Colors.blue,
                                        shape: BoxShape.circle,
                                      ),
                                      todayDecoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    headerStyle: HeaderStyle(
                                      formatButtonVisible: false,
                                      titleCentered: true,
                                    ),
                                  ),
                                  SizedBox(height: 50),
                                  Row(
                                    children: [
                                      Spacer(),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Cancel",
                                          )),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Ok",
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: Text(
                    ' ${_selectedDay.day}-${_selectedDay.month}-${_selectedDay.year}',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 36, 167, 40)),
                  ),
                ),
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
