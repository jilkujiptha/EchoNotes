import 'package:echonotes/echoNote.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  TextEditingController _title = TextEditingController();
  TextEditingController _content = TextEditingController();
  List ls = [];
  List list = [];
  var _mydata = Hive.box('mydata');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(239, 255, 255, 255),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: const Color.fromRGBO(0, 200, 83, 1),
        title: const Text(
          "Add New List",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (_title.text == "") {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Empty title"),
                  ),
                );
              } else if (ls == []) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Add at least one item"),
                  ),
                );
              } else {
                var data = {
                  "title": _title.text,
                  "items": ls,
                };
                if (_mydata.get('list') != null) {
                  list = _mydata.get('list');
                  list.add(data);
                  _mydata.put('list', list);
                } else {
                  list.add(data);
                  _mydata.put('list', list);
                }
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => EchoNotes(),
                  ),
                  (route) => false,
                );
              }
              print("======================================================");
              print(_mydata.get('list'));
            },
            icon: const Icon(
              Icons.done,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              child: TextField(
                cursorColor: Colors.greenAccent[700],
                controller: _title,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black54,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color.fromRGBO(0, 200, 83, 1),
                      width: 3,
                    ),
                  ),
                  labelText: "Title",
                  labelStyle: TextStyle(
                    color: Colors.greenAccent[700],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _content,
              cursorColor: Colors.greenAccent[700],
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    if (_content.text != "") {
                      setState(() {
                        ls.add(_content.text);
                      });
                      _content.clear();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Empty"),
                          duration: Duration(
                            milliseconds: 500,
                          ),
                        ),
                      );
                    }
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.greenAccent[700],
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black54,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: const Color.fromRGBO(0, 200, 83, 1),
                    width: 3,
                  ),
                ),
                labelText: "Add to list",
                alignLabelWithHint: true,
                labelStyle: TextStyle(
                  color: Colors.greenAccent[700],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: ls.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      ls[index],
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          ls.remove(ls[index]);
                        });
                      },
                      icon: Icon(
                        Icons.close,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
