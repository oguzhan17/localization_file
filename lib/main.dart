import 'package:flutter/material.dart';
import 'package:localization_desktop/display_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: DisplayScreen.id,
      routes: {
        DisplayScreen.id: (context) => const DisplayScreen(),
      },
    );
  }
}


