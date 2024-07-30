import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:hello_world_newest/screen/map.dart';
import 'package:provider/provider.dart';

import 'package:hello_world_newest/screen/home.dart';

import 'model/chat/message.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NaverMapSdk.instance.initialize(
      clientId: '0y26j6fv1v',
      onAuthFailed: (error) {
        print('Auth failed: $error');
      });

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
    return MaterialApp(
      title: 'Hello World, Artificial Intelligence Contact Center for Foreign Workers',
      home: MyHomePage(title: 'home'),
      routes: {
        '/chat': (context) => MyHomePage(title: 'chat'),
        '/search': (context) => MyMapPage(title: 'search'),
        // '/profile': (context) => MyHomePage(title: 'profile'),
      },
    );
  }
}
