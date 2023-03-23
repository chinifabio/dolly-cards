import 'package:flutter/material.dart';

import '../widgets/card_list.dart';
import 'card_reader.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _navigationIndex = 0;

  final tabs = [
    const CardListWidget(),
    const Center(child: Text('C')),
    const Center(child: Text('C'))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: tabs[_navigationIndex],
      floatingActionButton: FloatingActionButton(
        tooltip: 'Read Card',
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder:
            (context) => const CardReader())
        ),
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _navigationIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: "Cards",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Utilities"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.copy_all),
              label: "Reader"
          )
        ],
        onTap: (value) => setState(() {
          _navigationIndex = value;
        }),
      ),
    );
  }
}