import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
                fontWeight: FontWeight.normal,
                height: 1,
              ),
            ),
            const SizedBox(width: 127),
            Container(
              width: 24,
              height: 36,
              child: IconButton(onPressed: () {}, icon: const Icon(Icons.headphones_rounded)),
            ),
          ],
        ),
      ),
      centerTitle: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}