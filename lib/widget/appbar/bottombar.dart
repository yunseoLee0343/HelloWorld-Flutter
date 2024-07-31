import 'package:flutter/material.dart';

class MyBottomBar extends StatelessWidget {
  final ValueChanged<int> onTap; // 콜백 함수 추가

  MyBottomBar({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 60,
      color: Colors.grey[100],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.chat_outlined, size: 24),
            onPressed: () {
              onTap(0); // 0번 페이지 (Chat)
            },
          ),
          IconButton(
            icon: Icon(Icons.map_outlined, size: 24),
            onPressed: () {
              onTap(1); // 1번 페이지 (Map)
            },
          ),
          IconButton(
            icon: Icon(Icons.person_outline_rounded, size: 24),
            onPressed: () {
              onTap(2); // 2번 페이지 (Profile, 필요 시 추가)
            },
          ),
        ],
      ),
    );
  }
}