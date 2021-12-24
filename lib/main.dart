import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization_desktop/view/table_view/display_screen.dart';
import 'package:localization_desktop/localization_list_bloc/localization_bloc.dart';

import 'localization_list_bloc/localization_states.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocalizationListBloc>(
            create: (context) => LocalizationListBloc(
                initialState: LocalizationListInitState(),))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: DisplayScreen.id,
        routes: {
          DisplayScreen.id: (context) => const DisplayScreen(),
        },
      ),
    );
  }
}


