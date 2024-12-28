import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  TextEditingController title = TextEditingController();
  TextEditingController list = TextEditingController();
  final List ls = [];

  void addData() {
    setState(() {
      ls.add(list.text);
      list.clear();
    });
  }

  void removeData(String index) {
    setState(() {
      ls.remove(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 36, 167, 40),
        title: Text(
          "Add New List",
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
            TextField(
              controller: list,
              decoration: InputDecoration(
                labelText: "Add to list",
                suffixIcon: IconButton(
                  onPressed: () {
                    addData();
                  },
                  icon: Icon(
                    Icons.add,
                    color: const Color.fromARGB(255, 36, 167, 40),
                    size: 30,
                  ),
                ),
                alignLabelWithHint: true,
                labelStyle: TextStyle(
                  color: const Color.fromARGB(255, 36, 167, 40),
                ),
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: const Color.fromARGB(255, 36, 167, 40), width: 2),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: ls.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(ls[index]),
                      trailing: IconButton(
                        onPressed: () {
                          removeData(ls[index]);
                        },
                        icon: Icon(
                          Icons.close,
                          size: 25,
                          color: Colors.black,
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
