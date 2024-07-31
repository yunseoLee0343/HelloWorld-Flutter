import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world_newest/screen/home.dart';
import 'package:hello_world_newest/screen/intro.dart';
import 'package:hello_world_newest/screen/map.dart';
import 'package:hello_world_newest/screen/profile.dart';
import 'package:hello_world_newest/service/auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/chat/message.dart';

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

  final GoRouter _router = GoRouter(
    initialLocation: '/intro',
    routes: [
      GoRoute(
        path: '/intro',
        builder: (context, state) => const ChatIntroPage(),
      ),
      GoRoute(
        path: '/chat/:question',
        builder: (context, state) =>
            MyHomePage(question: state.pathParameters['question'] ?? ''),
      ),
      GoRoute(
        path: '/search',
        builder: (context, state) => const MyMapPage(title: 'search'),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const MyProfilePage(title: 'profile'),
      ),
    ],
  );

  MyApp(
      {super.key, required this.isAuthenticated, required this.isFirstLaunch});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title:
          'Hello World, Artificial Intelligence Contact Center for Foreign Workers',
      routerConfig: _router,
      /*
      home: isAuthenticated
          ? (isFirstLaunch
              ? const ChatIntroPage()
              : const MyHomePage(title: 'home'))
          : LoginPage(),
      */
    );
  }
}
