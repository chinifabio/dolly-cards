import 'package:flutter/cupertino.dart';

class CardListWidget extends StatefulWidget {
  const CardListWidget({super.key});

  @override
  State<StatefulWidget> createState() => _CardListWidgetState();
}

class _CardListWidgetState extends State<CardListWidget> {

  final cards = [
    const Center(child: Text('A')),
    const Center(child: Text('B')),
    const Center(child: Text('C'))
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: cards,
    );
  }

}