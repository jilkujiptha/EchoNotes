import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class PassData2 extends StatefulWidget {
  const PassData2({super.key});

  @override
  State<PassData2> createState() => _PassData2State();
}

class _PassData2State extends State<PassData2> {
  List textt = [];

  var pass;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passPage();
  }

  final _mydata = Hive.box('mydata');

  void passPage() {
    if (_mydata.get('text') != null) {
      textt = _mydata.get('text');
      print(_mydata.get("text"));
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
            textt[pass]["title"],
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
        body: ListTile(
          title: Text(textt[pass]["items"]),
        ));
  }
}
