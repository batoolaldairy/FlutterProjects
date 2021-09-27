import 'package:flutter/material.dart';
import 'package:gridviewapp/pages/tabone.dart' as tabone;
import 'package:gridviewapp/pages/tabtwo.dart' as tabtwo;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController controller;
  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Grid view test app",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[900],
        bottom: TabBar(
          indicatorColor: Colors.red[900],
          indicatorWeight: 5.0,
          controller: controller,
          tabs: const [
            Tab(
              icon: Icon(Icons.face),
              text: "Contacts",
            ),
            Tab(
              icon: Icon(Icons.image),
              text: 'Images',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: const [
          tabone.TabOne(),
          tabtwo.TabTow(),
        ],
      ),
    );
  }
}
