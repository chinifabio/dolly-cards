import 'package:dolly_cards/model/card_data.dart';
import 'package:flutter/material.dart';

import '../model/card_database.dart';

class CardDetailPage extends StatefulWidget {
  final int cardId;

  const CardDetailPage({
    Key? key,
    required this.cardId,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CardDetailState();
}

class _CardDetailState extends State<CardDetailPage> {
  late CardData cardData;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refresh();
  }

  Future refresh() async {
    setState(() => isLoading = true);

    cardData = await CardDatabase.instance.readCardData(widget.cardId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      actions: [emulateButton(), deleteButton()],
    ),
    body: isLoading
    ? const Center(child: CircularProgressIndicator())
    : Padding(
      padding: const EdgeInsets.all(12),
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          Text(
            cardData.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            // intl: DateFormat.yMMMd().format(cardData.timestamp),
            cardData.timestamp.toIso8601String(),
            style: const TextStyle(color: Colors.white38),
          ),
          const SizedBox(height: 8),
          Text(
            cardData.data,
            style: const TextStyle(color: Colors.white70, fontSize: 18),
          )
        ],
      ),
    ),
  );

  Widget emulateButton() => IconButton(
      icon: const Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;
        _emulate('');
      });

  Widget deleteButton() => IconButton(
    icon: const Icon(Icons.delete),
    onPressed: () async {
      await CardDatabase.instance.delete(widget.cardId);

      Navigator.of(context).pop();
    },
  );

  void _emulate(String data) {
    print('emulating');
  }
}