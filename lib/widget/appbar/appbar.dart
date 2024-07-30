import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        /*
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
         */
      ),
      // AppBar 위젯을 감싸는 Container입니다.
      child: AppBar(
        title: Container(
          padding: const EdgeInsets.all(24),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 24,
                height: 36,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/chatbot.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              const Text(
                'Hello World',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color.fromRGBO(51, 105, 255, 1),
                  fontFamily: 'Nunito',
                  fontSize: 20,
                  letterSpacing: 0,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
              ),
              const SizedBox(width: 127),
              Container(
                width: 24,
                height: 36,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.headphones_rounded),
                ),
              ),
            ],
          ),
        ),
        centerTitle: false,
        elevation: 0, // 기본 AppBar 그림자 제거
        backgroundColor: Colors.transparent, // 배경색 투명으로 설정
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64); // 커스텀 높이 설정
}
