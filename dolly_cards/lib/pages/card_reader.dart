
import 'package:flutter/material.dart';
import 'package:flutter_json_view/flutter_json_view.dart';
import 'package:nfc_manager/nfc_manager.dart';

class CardReader extends StatefulWidget {
  const CardReader({super.key});

  @override
  State<StatefulWidget> createState() => CardReaderState();
}

class CardReaderState extends State<CardReader> {
  ValueNotifier<dynamic> data = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Card Reader'),
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(4),
              child: ValueListenableBuilder<dynamic>(
                valueListenable: data,
                builder: (context, value, _) =>
                    JsonView.map(
                      value ?? {'press': 'read'},
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
        ));
  }

  void _readCard() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      data.value = tag.data;
      NfcManager.instance.stopSession();
    });
  }
}