import 'package:echonotes/listPage.dart';
import 'package:echonotes/taskPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:hive_flutter/adapters.dart';

class EchoNotes extends StatefulWidget {
  const EchoNotes({super.key});

  @override
  State<EchoNotes> createState() => _EchoNotesState();
}

class _EchoNotesState extends State<EchoNotes> with TickerProviderStateMixin {
  late TabController _tabController;
  final _key = GlobalKey<ExpandableFabState>();
  var _mydata = Hive.box('mydata');
  List list_items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    listData();
  }

  void listData() {
    if (_mydata.get('list') != null) {
      list_items = _mydata.get('list');
    }
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
            child: const Icon(Icons.add),
            fabSize: ExpandableFabSize.regular,
            angle: 3.14 * 2,
          ),
          closeButtonBuilder: FloatingActionButtonBuilder(
            size: 56,
            builder: (context, onPressed, progress) {
              return FloatingActionButton(
                backgroundColor: Colors.greenAccent[700],
                onPressed: onPressed,
                child: const Icon(
                  Icons.close,
                ),
              );
            },
          ),
          children: [
            FloatingActionButton.small(
              backgroundColor: Colors.greenAccent[700],
              heroTag: null,
              onPressed: () {
                Navigator.pushNamed(context, "/notes");
              },
              child: const Icon(
                Icons.notes,
              ),
            ),
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
                "./lib/Icons/check.png",
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
              child: const Center(
                child: Text("Text"),
              ),
            ),
            Container(
                child: Expanded(
                    child: GridView.builder(
              padding: EdgeInsets.only(top: 20, left: 10, right: 10),
              itemCount: list_items.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 2 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                var items = list_items[index];
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blueAccent,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.all(10),
                        title: Text(
                          items['title'],
                        ),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.more_vert),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: items['items'].length,
                          itemBuilder: (context, i) {
                            return Container(
                              padding: EdgeInsets.only(left: 10),
                              margin: EdgeInsets.only(bottom: 10),
                              child: Text(items['items'][i]),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ))),
            Container(
              child: const Center(
                child: Text("Task"),
              ),
            ),
          ],
        ));
  }
}
