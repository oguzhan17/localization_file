import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization_desktop/localization_list_bloc/localization_bloc.dart';
import 'package:localization_desktop/localization_list_bloc/localization_states.dart';

import '../../data/repository.dart';
import '../../localization_list_bloc/localization_events.dart';
import '../add_data/add_data_screen.dart';
import 'localizationFileItem.dart';

class DisplayScreen extends StatefulWidget {
  static const String id = 'DisplayScreen';

  const DisplayScreen({Key? key}) : super(key: key);

  @override
  State<DisplayScreen> createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
  @override
  void initState() {
    BlocProvider.of<LocalizationListBloc>(context, listen: false)
        .add(StartEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String appBarTitle = 'Language files';
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddDataScreen(

                    )),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<LocalizationListBloc, LocalizationListStates>(
          builder: (BuildContext context, LocalizationListStates state) {
        if (state is LocalizationListLoadingState) {
          debugPrint('NewsLoadingState');
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is LocalizationListLoadedState) {
          List keysList = state.listAll[0];
          List<Map> trEnFile = state.listAll[1];
          debugPrint('NewsLoadedState');
          return SingleChildScrollView(
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
              ...keysList.map((e) {
                return localizationFileItem(
                  context: context,
                  listMap: trEnFile,
                  index: keysList.indexOf(e),
                );
              }).toList(),
            ]),
          );
        } else {
          debugPrint('Else');
          return const Center(
              child: CircularProgressIndicator(
            backgroundColor: Colors.pink,
          ));
        }
      }),
    );
  }
}
