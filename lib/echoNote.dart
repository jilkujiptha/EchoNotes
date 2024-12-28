import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

class EchoNotes extends StatefulWidget {
  const EchoNotes({super.key});

  @override
  State<EchoNotes> createState() => _EchoNotesState();
}

class _EchoNotesState extends State<EchoNotes> with TickerProviderStateMixin {
  final _key = GlobalKey<ExpandableFabState>();
  late TabController echo;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    echo = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 66, 208, 71),
        title: Text(
          "Echo Notes",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        color: const Color.fromARGB(255, 66, 208, 71),
        child: TabBar(
            controller: echo,
            unselectedLabelColor: Colors.black,
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            labelStyle: TextStyle(fontSize: 20),
            tabs: [
              Tab(
                text: "Text",
              ),
              Tab(
                text: "List",
              ),
              Tab(
                text: "Task",
              ),
            ]),
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
          key: _key,
          type: ExpandableFabType.up,
          pos: ExpandableFabPos.right,
          childrenOffset: Offset(5, 5),
          distance: 60,
          openButtonBuilder: RotateFloatingActionButtonBuilder(
            backgroundColor: const Color.fromARGB(255, 66, 208, 71),
            foregroundColor: const Color.fromARGB(255, 66, 208, 71),
            child: Icon(
              Icons.add,
              color: Colors.black,
              size: 35,
            ),
          ),
          closeButtonBuilder: FloatingActionButtonBuilder(
              size: 50,
              builder: (context, onPressed, progress) {
                return FloatingActionButton(
                    backgroundColor: const Color.fromARGB(255, 66, 208, 71),
                    onPressed: onPressed,
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.notes,
                          size: 35,
                          color: Colors.black,
                        )));
              }),
          children: [
            FloatingActionButton.small(
                backgroundColor: const Color.fromARGB(255, 66, 208, 71),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.check_box,
                    color: Colors.black,
                  ),
                ),
                onPressed: () {}),
            FloatingActionButton.small(
                backgroundColor: const Color.fromARGB(255, 66, 208, 71),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.done,
                    color: Colors.black,
                  ),
                ),
                onPressed: () {}),
          ]),
    );
  }
}
