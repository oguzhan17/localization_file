import 'dart:convert';

import 'package:flutter/services.dart';

class LoadKeysRepository {
  Map<String, String> tr = {};
  Map<String, String> en = {};
  List listAll = [];

  Future loadKeys() async {
    String data = await rootBundle.loadString('lib/l10n/app_tr.arb');
    Map<String, dynamic> dynamicMap = json.decode(data);
    tr = dynamicMap.map((key, value) => MapEntry(key, value.toString()));

    data = await rootBundle.loadString('lib/l10n/app_en.arb');
    dynamicMap = json.decode(data);
    en = dynamicMap.map((key, value) => MapEntry(key, value.toString()));
    listAll = [tr.keys.toList(),[en, tr]];
    return listAll;
  }
}
