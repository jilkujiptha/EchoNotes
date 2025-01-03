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
  var _mydata = Hive.box('mydata');
  List ls = [];

  // @override
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
            child: const Center(
              child: Text("Text"),
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

                        return Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.blueAccent,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Text(data["title"]),
                                trailing: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.more_vert),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: data["items"].length,
                                  itemBuilder: (context, i) {
                                    print(data);
                                    return Container(
                                      padding: EdgeInsets.only(left: 10),
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: Text(data['items'][i]),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      })),
            ),
          ),
          Container(
            child: const Center(
              child: Text("Task"),
            ),
          ),
        ],
      ),
    );
  }
}
