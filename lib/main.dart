import 'package:flutter/material.dart';
import 'package:hello_world_newest/screen/intro.dart';
import 'package:hello_world_newest/screen/login.dart';
import 'package:hello_world_newest/screen/map.dart';
import 'package:hello_world_newest/service/auth.dart';
import 'package:provider/provider.dart';
import 'package:hello_world_newest/screen/home.dart';
import 'model/chat/message.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool isAuthenticated = await AuthService.isLoggedIn();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('isFirstLaunch', true);
  bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Messages()),
      ],
      child: MyApp(
        isAuthenticated: true,
        // isAuthenticated: isAuthenticated,
        isFirstLaunch: isFirstLaunch,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isAuthenticated;
  final bool isFirstLaunch;

  MyApp({required this.isAuthenticated, required this.isFirstLaunch});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello World, Artificial Intelligence Contact Center for Foreign Workers',
      home: isAuthenticated
          ? (isFirstLaunch ? ChatIntroPage() : MyHomePage(title: 'home'))
          : LoginPage(),
      routes: {
        '/intro': (context) => ChatIntroPage(),
        '/chat': (context) => MyHomePage(title: 'chat'),
        '/search': (context) => MyMapPage(title: 'search'),
      },
    );
  }
}