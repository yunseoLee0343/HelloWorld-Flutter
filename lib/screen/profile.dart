import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/navigation.dart';
import '../widget/appbar/bottombar.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key, required this.title});

  final String title;

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color.fromRGBO(255, 255, 255, 1),
        child: Stack(
          children: <Widget>[
            _buildTopBackground(),
            _buildMainContainer(),
            _buildUserInfo(),
            _buildBottomNav(),
            _buildTitle(),
            _buildDivider(),
            _buildSectionTitle(top: 234, left: 35, text: '상담'),
            _buildSectionTitle(top: 414, left: 26, text: '계정 설정'),
            _buildSection(
              top: 291,
              left: 35,
              text: '챗봇 상담 히스토리 요약 보기',
              iconPath: 'assets/images/vector.svg',
            ),
            _buildSection(
              top: 471,
              left: 28,
              text: '프로필 변경',
              iconPath: 'assets/images/vector.svg',
            ),
            _buildSection(
              top: 332,
              left: 36,
              text: '상담 접수 내역',
              iconPath: 'assets/images/vector.svg',
            ),
            _buildLine(top: 385, left: 17, path: 'assets/images/line3.svg'),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomBar(
        onTap: (index) {
          setState(() {
            onBottomNavBarTapped(context, index);
          });
        },
      ),
    );
  }

  Positioned _buildTopBackground() {
    return Positioned(
      top: 0,
      left: 0,
      child: Container(
        width: 360,
        height: 294,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
          color: Color.fromRGBO(75, 123, 245, 1),
        ),
      ),
    );
  }

  Positioned _buildMainContainer() {
    return Positioned(
      top: 128,
      left: 16,
      child: Container(
        width: 330,
        height: 741,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(75, 75, 75, 0.15),
              offset: Offset(0, 2),
              blurRadius: 16,
            )
          ],
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
      ),
    );
  }

  Positioned _buildUserInfo() {
    return Positioned(
      top: 152,
      left: 41,
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/images/Image4.png'),
          ),
          SizedBox(width: 12),
          Text(
            'User Yennefer Doe',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Rubik',
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Positioned _buildBottomNav() {
    return Positioned(
      top: 752,
      left: 0,
      child: Container(
        color: Color.fromRGBO(253, 253, 253, 1),
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SvgPicture.asset('assets/images/vector.svg', semanticsLabel: 'vector'),
            SizedBox(width: 20),
            SvgPicture.asset('assets/images/vector.svg', semanticsLabel: 'vector'),
            SizedBox(width: 20),
            SvgPicture.asset('assets/images/vector.svg', semanticsLabel: 'vector'),
          ],
        ),
      ),
    );
  }

  Positioned _buildTitle() {
    return Positioned(
      top: 60,
      left: 69,
      child: Text(
        'MyPage',
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Rubik',
          fontSize: 28,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  Positioned _buildDivider() {
    return Positioned(
      top: 216,
      left: 16,
      child: Divider(
        color: Color.fromRGBO(201, 201, 201, 1),
        thickness: 0.5,
      ),
    );
  }

  Positioned _buildSectionTitle({required double top, required double left, required String text}) {
    return Positioned(
      top: top,
      left: left,
      child: Text(
        text,
        style: TextStyle(
          color: Color.fromRGBO(173, 173, 173, 1),
          fontFamily: 'Nunito',
          fontSize: 18,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  Positioned _buildSection({required double top, required double left, required String text, required String iconPath}) {
    return Positioned(
      top: top,
      left: left,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Nunito',
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
          SvgPicture.asset(iconPath, semanticsLabel: 'vector'),
        ],
      ),
    );
  }

  Positioned _buildLine({required double top, required double left, required String path}) {
    return Positioned(
      top: top,
      left: left,
      child: SvgPicture.asset(path, semanticsLabel: 'line'),
    );
  }
}