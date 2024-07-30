import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:hello_world_newest/screen/home.dart';

import 'model/chat/message.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Messages()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Hello World, Artificial Intelligence Contact Center for Foreign Workers',
      home: MyHomePage(title: 'home'),
    );
  }
}
