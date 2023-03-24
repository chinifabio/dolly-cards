
import 'dart:convert';
import 'dart:math';

import 'package:dolly_cards/model/card_data.dart';
import 'package:dolly_cards/model/card_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_json_view/flutter_json_view.dart';
import 'package:nfc_manager/nfc_manager.dart';

class CardReader extends StatefulWidget {
  const CardReader({super.key});

  @override
  State<StatefulWidget> createState() => _CardReaderState();
}

class _CardReaderState extends State<CardReader> {
  static const String noValueJson = '{"press": "read"}';
  ValueNotifier<String> data = ValueNotifier<String>(noValueJson);

  static const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(4),
          child: ValueListenableBuilder<String>(
            valueListenable: data,
            builder: (context, String value, _) =>
                JsonView.string(
                  value,
                  theme: const JsonViewTheme(
                      backgroundColor: Colors.white
                  ),
                ),
          ),
        ),
        ElevatedButton(
          onPressed: _readCard,
          child: const Text('Read'),
        )
      ],
    );
  }

  void _readCard() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      String json = jsonEncode(tag.data);
      NfcManager.instance.stopSession();

      data.value = json;

      CardDatabase.instance.createCardData(CardData(
          name: getRandomString(10),
          data: json,
          timestamp: DateTime.now())
      );
    });
  }
}