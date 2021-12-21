import 'package:flutter/material.dart';

DataRow localizationFileItem({
  required List<Map> listMap,
  required BuildContext context,
  required int index,
}) {
  Map enFile = listMap[0];
  Map trFile = listMap[1];
  List list = enFile.keys.toList();
  double mqWidth = MediaQuery.of(context).size.width;

  return DataRow(
    cells: <DataCell>[
      dataCell(mqWidth, list, index),
      dataCellMap(mqWidth, enFile, list, index),
      dataCellMap(mqWidth, trFile, list, index),
    ],
  );
}

DataCell dataCellMap(double mqWidth, Map<dynamic, dynamic> enFile,
    List<dynamic> list, int index) {
  return DataCell(
    ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: mqWidth * 0.3,
      ),
      child: Text(
        enFile[list[index]],
        overflow: TextOverflow.ellipsis,
      ),
    ),
  );
}

DataCell dataCell(double mqWidth, List<dynamic> list, int index) {
  return DataCell(
    ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: mqWidth * 0.28,
      ),
      child: Text(
        list[index],
        overflow: TextOverflow.ellipsis,
      ),
    ),
  );
}
