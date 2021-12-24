import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

import '../../localization_list_bloc/localization_bloc.dart';
import '../../localization_list_bloc/localization_states.dart';

class AddDataScreen extends StatelessWidget {
  const AddDataScreen({Key? key}) : super(key: key);

  Future<String> get directoryPath async {
    Directory directory = await getApplicationDocumentsDirectory();
    // print("Directory Path: " + directory.path);
    return directory.path;
  }

  Future<File> get createTrFile async {
    var createdFile = await directoryPath;
    return File(createdFile + "\\trFile.txt");
  }

  Future<File> get createEnFile async {
    var createdFile = await directoryPath;
    return File(createdFile + "\\enFile.txt");
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
            BlocBuilder<LocalizationListBloc, LocalizationListStates>(
                builder: (BuildContext context, LocalizationListStates state) {
              return ElevatedButton(
                onPressed: () {
                  if (_textEditingControllerKey.text != '' &&
                      _textEditingControllerEN.text != '' &&
                      _textEditingControllerTR.text != '' &&
                      state is LocalizationListLoadedState) {
                    Map<String, String> trMap = state.listAll[1][1];
                    Map<String, String> enMap = state.listAll[1][0];
                    int keysLength = trMap.keys.length;
                    trMap.putIfAbsent(_textEditingControllerKey.text,
                        () => _textEditingControllerTR.text);
                    enMap.putIfAbsent(_textEditingControllerKey.text,
                        () => _textEditingControllerEN.text);
                    writeToTrFile("\"" + trMap.keys.last + "\": " + "\"" + "\"");
                    writeToEnFile("\"" +
                        enMap.keys.last + "\": " + "\"" + enMap.values.last + "\"");
                    if (trMap.keys.length > keysLength) {
                      print('Writen');
                    } else if (trMap.keys.length == keysLength) {
                      print('Keys Already Exist');
                    } else {
                      print('Error');
                    }
                  }
                },
                style: ElevatedButton.styleFrom(primary: Colors.blue),
                child: const Text("Load"),
              );
            }),
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
