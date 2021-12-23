import 'dart:convert';

import 'package:flutter/services.dart';

class LoadKeysRepository{

  static final LoadKeysRepository _singleton = LoadKeysRepository._internal();
  factory LoadKeysRepository() => _singleton;
  LoadKeysRepository._internal();


  Map<String, String> tr = {};
  Map<String, String> en = {};
  List list = [];
  List<Map> listMap = [];

  // @override
  // void initState() {
  //   loadKeys();
  // }

  Future loadKeys() async {
    String data = await rootBundle.loadString('lib/l10n/app_tr.arb');
    Map<String, dynamic> dynamicMap = json.decode(data);
    tr = dynamicMap.map((key, value) => MapEntry(key, value.toString()));

    data = await rootBundle.loadString('lib/l10n/app_en.arb');
    dynamicMap = json.decode(data);
    en = dynamicMap.map((key, value) => MapEntry(key, value.toString()));
    list = tr.keys.toList();
    listMap = [en, tr];
    // setState(() {});
//    debugPrint(tr.keys.first);
    return Future.value();
  }
}