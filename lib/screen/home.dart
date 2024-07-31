import 'package:flutter/material.dart';

import '../utils/navigation.dart';
import '../widget/appbar/appbar.dart';
import '../widget/appbar/bottombar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.question});

  final String question;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arguments = ModalRoute.of(context)!.settings.arguments as Map?;
      print("arguments: $arguments");
      if (arguments != null && arguments['question'] != null) {
        final chatWidgetState =
            context.findAncestorStateOfType<ChatWidgetState>();
        chatWidgetState?.sendMessage(arguments['question']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: const NavigationHandler(),
      bottomNavigationBar: MyBottomBar(
        onTap: (index) {
          setState(() {
            onBottomNavBarTapped(context, index);
          });
        },
      ),
    );
  }
}
