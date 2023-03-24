import 'package:dolly_cards/model/card_data.dart';
import 'package:dolly_cards/pages/card_details.dart';
import 'package:flutter/material.dart';

import '../model/card_database.dart';

class CardListWidget extends StatefulWidget {
  const CardListWidget({super.key});

  @override
  State<StatefulWidget> createState() => _CardListWidgetState();
}

class _CardListWidgetState extends State<CardListWidget> {

  late List<CardData> cards;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refresh();
  }

  Future refresh() async {
    setState(() => isLoading = true);

    cards = await CardDatabase.instance.readAll();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isLoading
        ? const CircularProgressIndicator()
        : cards.isEmpty
          ? const Text(
            'No Cards',
            style: TextStyle(color: Colors.teal),
          )
          : buildCards(),
    );
  }

  Widget buildCards() => ListView(
    padding: const EdgeInsets.all(8),
    children: cards.map((e) => GestureDetector(
      onTap: () async {
        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CardDetailPage(cardId: e.id!),
        ));
      },
      child: Card(
        elevation: 2,
        color: Colors.deepOrange,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              e.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
            Text(
              e.timestamp.toIso8601String(),
              style: const TextStyle(
                color: Colors.white10
              ),
            )
          ],
        ),
      ),
    )).toList(),
  );

}