import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'add_data_screen.dart';
import 'localizationFileItem.dart';

class DisplayScreen extends StatefulWidget {
  static const String id = 'DisplayScreen';

  const DisplayScreen({Key? key}) : super(key: key);

  @override
  State<DisplayScreen> createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
  Map<String, String> tr = {};
  Map<String, String> en = {};
  List list = [];
  List<Map> listMap = [];

  @override
  void initState() {
    loadKeys();
  }

  Future loadKeys() async {
    String data = await rootBundle.loadString('lib/l10n/app_tr.arb');
    Map<String, dynamic> dynamicMap = json.decode(data);
    tr = dynamicMap.map((key, value) => MapEntry(key, value.toString()));

    data = await rootBundle.loadString('lib/l10n/app_en.arb');
    dynamicMap = json.decode(data);
    en = dynamicMap.map((key, value) => MapEntry(key, value.toString()));
    list = tr.keys.toList();
    listMap = [en, tr];
    setState(() {});
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    String appBarTitle = 'Dil Dosyaları';
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddDataScreen(trMap : tr,enMap: en,)),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: DataTable(columnSpacing: 10, columns: const <DataColumn>[
          DataColumn(
            label: Text(
              'Key',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'EN',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'TR',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ], rows: [
          ...list.map((e) {
            return localizationFileItem(
              context: context,
              listMap: listMap,
              index: list.indexOf(e),
            );
          }).toList(),
        ]),
      ),
    );
  }
}
