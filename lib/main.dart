import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/providers/event_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => EventProvider(),
      child: MaterialApp(
        title: 'Reminder App',
        home: MyHomePage(),
        theme: ThemeData(primaryColor: Colors.purple[300]),
      ),
    );
  }
}
