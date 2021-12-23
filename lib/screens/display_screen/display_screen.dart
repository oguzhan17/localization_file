
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization_desktop/localization_list_bloc/localization_bloc.dart';
import 'package:localization_desktop/localization_list_bloc/localization_states.dart';

import '../../repository/load_keys_repository.dart';
import '../add_data_screen/add_data_screen.dart';
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
  LoadKeysRepository().loadKeys();
    super.initState();
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
            MaterialPageRoute(
                builder: (context) => const AddDataScreen(

                )),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<LocalizationListBloc, LocalizationListStates>(
          builder: (BuildContext context, LocalizationListStates state) {

            if (state is LocalizationListLoadingState) {
              debugPrint('Loading');
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LocalizationListLoadedState) {
              debugPrint('Loaded');
             debugPrint(LoadKeysRepository().en.keys.last);
              return const SingleChildList();
            } else if (state is LocalizationListErrorState) {
              debugPrint('Error');
              String error = state.errorMessage;
              return Center(child: Text(error));
            } else {
              debugPrint('Else');
        //      debugPrint(LoadKeysRepository().en.keys.last);
              return const Center(
                  child: CircularProgressIndicator(
                   backgroundColor: Colors.lightBlueAccent,
                  ));
            }
          }),
    );
  }
}

class SingleChildList extends StatelessWidget {
  const SingleChildList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      ],
          rows: [
        ...LoadKeysRepository().list.map((e) {
          return localizationFileItem(
            context: context,
            listMap: LoadKeysRepository().listMap,
            index: LoadKeysRepository().list.indexOf(e),
          );
        }).toList(),
      ]
      ),
    );
  }
}
