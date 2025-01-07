import 'package:echonotes/listPage.dart';
import 'package:echonotes/taskPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:staggered_grid_view_flutter/rendering/sliver_staggered_grid.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class EchoNotes extends StatefulWidget {
  const EchoNotes({super.key});

  @override
  State<EchoNotes> createState() => _EchoNotesState();
}

class _EchoNotesState extends State<EchoNotes> with TickerProviderStateMixin {
  late TabController _tabController;
  final _key = GlobalKey<ExpandableFabState>();
  final _mydata = Hive.box('mydata');
  List ls = [];
  List taskk = [];
  List textt = [];
  String? Value;
  String? editDelete;
  bool _isupDown = false;
  double width = double.infinity;
  double height = 10;
  bool _isDate = false;
  DateTime _selectedDay = DateTime.now();
  List<bool> _expandList = List.generate(10, (context) => false);

  // @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    listData();
  }

  void listData() {
    if (_mydata.get('list') != null) {
      ls = _mydata.get('list');
      print(_mydata.get("list"));
    }
    if (_mydata.get("Task") != null) {
      taskk = _mydata.get('Task');
      print(_mydata.get("Task"));
    }
    if (_mydata.get("text") != null) {
      textt = _mydata.get('text');
      print(_mydata.get("text"));
    }
  }

  Color? getDateColor() {
    if (_selectedDay.day > DateTime.now().day &&
        _selectedDay.month > DateTime.now().month &&
        _selectedDay.year > DateTime.now().year) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(239, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.greenAccent[700],
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Echo Note",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          dividerColor: Colors.white,
          indicatorColor: Colors.white,
          labelStyle: const TextStyle(
            fontSize: 18,
          ),
          tabs: const [
            Tab(
              text: "Text",
            ),
            Tab(
              text: "List",
            ),
            Tab(
              text: "Task",
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        key: _key,
        type: ExpandableFabType.up,
        pos: ExpandableFabPos.right,
        childrenOffset: const Offset(5, 5),
        distance: 60,
        openButtonBuilder: RotateFloatingActionButtonBuilder(
          backgroundColor: Colors.greenAccent[700],
          child: const Icon(
            Icons.add,
            color: Colors.black,
          ),
          fabSize: ExpandableFabSize.regular,
          angle: 3.14 * 2,
        ),
        closeButtonBuilder: FloatingActionButtonBuilder(
          size: 56,
          builder: (context, onPressed, progress) {
            return FloatingActionButton(
              backgroundColor: Colors.greenAccent[700],
              onPressed: () {
                Navigator.pushNamed(context, "text");
              },
              child: const Icon(
                Icons.notes,
                color: Colors.black,
              ),
            );
          },
        ),
        children: [
          FloatingActionButton.small(
            heroTag: null,
            backgroundColor: Colors.greenAccent[700],
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ListPage(),
                ),
              );
            },
            child: const Icon(
              Icons.check_box,
              color: Colors.black,
            ),
          ),
          FloatingActionButton.small(
            heroTag: null,
            backgroundColor: Colors.greenAccent[700],
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Task(),
                ),
              );
            },
            child: Image.asset(
              "./images/checked.png",
              height: 20,
              width: 20,
            ),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Container(
            child: Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                child: MasonryGridView.builder(
                    itemCount: textt.length,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    gridDelegate:
                        SliverSimpleGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      var data = textt[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "data2",
                              arguments: index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromARGB(255, 30, 134, 33),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                  title: Text(
                                    data["title"],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  trailing: DropdownButton<String>(
                                      icon: Icon(
                                        Icons.more_vert,
                                        color: Colors.white,
                                      ),
                                      underline: Container(
                                        height: 0,
                                      ),
                                      value: editDelete,
                                      items: [
                                        DropdownMenuItem<String>(
                                            value: "Edit",
                                            child: TextButton(
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                      context, "edit1",
                                                      arguments: index);
                                                },
                                                child: Text(
                                                  "Edit",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ))),
                                        DropdownMenuItem<String>(
                                            value: "Delete",
                                            child: TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    textt.removeAt(index);
                                                    _mydata.put("text", textt);
                                                  });
                                                },
                                                child: Text(
                                                  "Delete",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                )))
                                      ],
                                      onChanged: (String? value) {
                                        setState(() {
                                          editDelete = value;
                                        });
                                      })),
                              Container(
                                padding: EdgeInsets.only(bottom: 10, left: 15),
                                child: Text(
                                  data["items"],
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ),
          Container(
            child: Expanded(
              child: Container(
                  padding: EdgeInsets.all(10),
                  child: MasonryGridView.builder(
                      itemCount: ls.length,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      gridDelegate:
                          SliverSimpleGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        var data = ls[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "data1",
                                arguments: index);
                          },
                          child: Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 30, 134, 33),
                            ),
                            child: Column(
                              children: [
                                ListTile(
                                    title: Text(
                                      data["title"],
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    trailing: DropdownButton<String>(
                                        icon: Icon(
                                          Icons.more_vert,
                                          color: Colors.white,
                                        ),
                                        underline: Container(
                                          height: 0,
                                        ),
                                        value: editDelete,
                                        items: [
                                          DropdownMenuItem<String>(
                                              value: "Edit",
                                              child: TextButton(
                                                  onPressed: () {
                                                    Navigator.pushNamed(
                                                        context, "edit2",
                                                        arguments: index);
                                                  },
                                                  child: Text(
                                                    "Edit",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ))),
                                          DropdownMenuItem<String>(
                                              value: "Delete",
                                              child: TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      ls.removeAt(index);
                                                      _mydata.put("list", ls);
                                                    });
                                                  },
                                                  child: Text(
                                                    "Delete",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  )))
                                        ],
                                        onChanged: (String? value) {
                                          setState(() {
                                            editDelete = value;
                                          });
                                        })),
                                Expanded(
                                  flex: 0,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: data["items"].length,
                                    itemBuilder: (context, i) {
                                      print(data);
                                      return Container(
                                        padding: EdgeInsets.only(left: 10),
                                        margin: EdgeInsets.only(bottom: 10),
                                        child: Text(
                                          data['items'][i],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      })),
            ),
          ),
          Container(
            child: Container(
              child: Expanded(
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: MasonryGridView.builder(
                        itemCount: taskk.length,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        gridDelegate:
                            SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          // print(_selectedDay);
                          // print(DateTime.now());
                          // print(
                          //     "==============================================");
                          var data = taskk[index];
                          return Container(
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(10)),
                                    color: getDateColor(),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                          title: Text(
                                            data["title"],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                          subtitle: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    data["date"],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    data["time"],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          trailing: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _expandList[index] =
                                                    !_expandList[index];
                                              });
                                            },
                                            icon: _expandList[index] == false
                                                ? Image.asset(
                                                    "./images/down-arrow.png",
                                                    width: 20,
                                                    height: 20,
                                                    color: Colors.white,
                                                  )
                                                : Image.asset(
                                                    "./images/upload.png",
                                                    width: 15,
                                                    height: 15,
                                                    color: Colors.white,
                                                  ),
                                          )),
                                    ],
                                  ),
                                ),
                                AnimatedContainer(
                                  width: width,
                                  height: _expandList[index] == true
                                      ? height = 100
                                      : height = 20,
                                  alignment: Alignment.bottomCenter,
                                  curve: Curves.easeInOut,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(15)),
                                    color: getDateColor(),
                                  ),
                                  duration: Duration(milliseconds: 500),
                                  child: ListView(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          data["items"],
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      ListTile(
                                        subtitle: TextButton(
                                            onPressed: () {},
                                            child: Text("data")),
                                        trailing: DropdownButton<String>(
                                            icon: Icon(
                                              Icons.more_vert,
                                              color: Colors.white,
                                            ),
                                            underline: Container(
                                              width: 0,
                                            ),
                                            value: editDelete,
                                            items: [
                                              DropdownMenuItem<String>(
                                                  value: "Edit",
                                                  child: TextButton(
                                                      onPressed: () {
                                                        Navigator.pushNamed(
                                                            context, "edit3",
                                                            arguments: index);
                                                      },
                                                      child: Text(
                                                        "Edit",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ))),
                                              DropdownMenuItem<String>(
                                                  value: "Delete",
                                                  child: TextButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          taskk.removeAt(index);
                                                          _mydata.put(
                                                              "Task", taskk);
                                                        });
                                                      },
                                                      child: Text(
                                                        "Delete",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      )))
                                            ],
                                            onChanged: (String? value) {
                                              setState(() {
                                                editDelete = value;
                                              });
                                            }),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        })),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
