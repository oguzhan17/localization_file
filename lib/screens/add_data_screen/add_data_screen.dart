import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class AddDataScreen extends StatelessWidget {
  final Map<String, String> trMap;
  final Map<String, String> enMap;

  const AddDataScreen({
    Key? key,
    required this.trMap,
    required this.enMap,
  }) : super(
    key: key,
  );

  Future<String> get directoryPath async {
    Directory directory = await getApplicationDocumentsDirectory();
    // print("Directory Path: " + directory.path);
    return directory.path;
  }

  Future<File> get createTrFile async {
    var createdFile = await directoryPath;
    return File(createdFile + "\\trFile.arb");
  }

  Future<File> get createEnFile async {
    var createdFile = await directoryPath;
    return File(createdFile + "\\enFile.arb");
  }

  Future<String> get readTrFile async {
    try {
      var trFile = await createTrFile;
      String fileTrString = trFile.readAsStringSync();
      return fileTrString;
    } catch (e) {
      return "Error $e";
    }
  }

  Future<String> get readEnFile async {
    try {
      var enFile = await createEnFile;
      String fileEnString = enFile.readAsStringSync();
      return fileEnString;
    } catch (e) {
      return "Error $e";
    }
  }

  Future<File> writeToTrFile(String valueToWrite) async {
    var trFile = await createTrFile;
    return trFile.writeAsString(valueToWrite);
  }

  Future<File> writeToEnFile(String valueToWrite) async {
    var enFile = await createEnFile;
    return enFile.writeAsString(valueToWrite);
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _textEditingControllerKey =
    TextEditingController();
    final TextEditingController _textEditingControllerEN =
    TextEditingController();
    final TextEditingController _textEditingControllerTR =
    TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dil dosyası ekleme'),
      ),
      body: Column(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _textEditingControllerKey,
            decoration: const InputDecoration(
              hintText: "Write Key",
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _textEditingControllerEN,
            decoration: const InputDecoration(
              hintText: "Write EN",
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _textEditingControllerTR,
            decoration: const InputDecoration(
              hintText: "Write TR",
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.blue),
              onPressed: () {
                _readFile();
              },
              child: const Text("Read"),
            ),
            ElevatedButton(
              onPressed: () {
                writeToTrFile(_textEditingControllerKey.text);
              },
              style: ElevatedButton.styleFrom(primary: Colors.blue),
              child: const Text("Write"),
            ),
            ElevatedButton(
              onPressed: () {
                if (_textEditingControllerKey.text != '' &&
                    _textEditingControllerEN.text != '' &&
                    _textEditingControllerTR.text != '') {
                  trMap.putIfAbsent(_textEditingControllerKey.text,
                          () => _textEditingControllerTR.text);
                  enMap.putIfAbsent(_textEditingControllerKey.text,
                          () => _textEditingControllerEN.text);
                  writeToTrFile("\"" + trMap.keys.last + "\": " + "\"" + trMap.values.last + "\"");
                  writeToEnFile("\"" + enMap.keys.last + "\": " + "\"" + enMap.values.last + "\"");
                }
              },
              style: ElevatedButton.styleFrom(primary: Colors.blue),
              child: const Text("Load"),
            ),
          ],
        ),
      ]),
    );
  }

  void _readFile() async {
    print(await readTrFile);
    print(await readEnFile);
  }
}
