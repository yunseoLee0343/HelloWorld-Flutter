import 'package:flutter/material.dart';

class MyBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 60,
      color: Colors.grey[100],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.chat_outlined, size: 24,),
            onPressed: () {
              Navigator.pushNamed(context, '/chat');
            },
          ),
          IconButton(
            icon: Icon(Icons.map_outlined, size: 24,),
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
          ),
          IconButton(
            icon: Icon(Icons.person_outline_rounded, size: 24,),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
    );
  }
}