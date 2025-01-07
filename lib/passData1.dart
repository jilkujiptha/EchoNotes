import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class PassData1 extends StatefulWidget {
  const PassData1({super.key});

  @override
  State<PassData1> createState() => _PassData1State();
}

class _PassData1State extends State<PassData1> {
  List ls = [];
  var pass;
  bool _isChecked = false;

  final _mydata = Hive.box('mydata');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passPage();
  }

  void passPage() {
    if (_mydata.get('list') != null) {
      ls = _mydata.get('list');
      print(_mydata.get("list"));
    }
  }

  @override
  Widget build(BuildContext context) {
    pass = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent[700],
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          ls[pass]["title"],
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
          IconButton(onPressed: () {}, icon: Icon(Icons.delete))
        ],
      ),
      body: Expanded(
          child: ListView.builder(
              itemCount: ls[pass]["items"].length,
              itemBuilder: (context, index) {
                return ListTile(
                    leading: Checkbox(
                      value: _isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked = value!;
                        });
                      },
                    ),
                    title: Text(ls[pass]["items"][index]));
              })),
    );
  }
}
