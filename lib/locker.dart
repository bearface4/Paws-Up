import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:pawsupunf/Events.dart';
import 'package:pawsupunf/Home.dart';
import 'package:pawsupunf/Voting.dart';
import 'package:pawsupunf/Profile.dart';

class Locker extends StatefulWidget {
  @override
  _LockerState createState() => _LockerState();
}

class _LockerState extends State<Locker> {
  int _page = 3; // Set the initial page to Locker (0-based index)
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  Color iconColor(int index) {
    return _page == index ? Color(0xFFFFD700) : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(color: Colors.white),
          _buildHeader(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHeader() {
    return Positioned(
      top: 70.0,
      left: 30.0,
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: 'Locker',
              style: TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
                color: Color(0xFF002365),
                decorationColor: Color(0xFF002365),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return CurvedNavigationBar(
      key: _bottomNavigationKey,
      index: _page,
      height: 60.0,
      items: <Widget>[
        Image.asset('lib/assets/homez.png', height: 30, width: 30, color: iconColor(0)),
        Image.asset('lib/assets/star.png', height: 30, width: 30, color: iconColor(1)),
        Image.asset('lib/assets/star2.png', height: 30, width: 30, color: iconColor(2)),
        Image.asset('lib/assets/lockers.png', height: 30, width: 30, color: iconColor(3)),
        Image.asset('lib/assets/profile.png', height: 30, width: 30, color: iconColor(4)),
      ],
      color: Color(0xFF002365),
      buttonBackgroundColor: Color(0xFF002365),
      backgroundColor: Colors.white,
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 600),
      onTap: (index) {
        setState(() {
          _page = index;
        });
        switch (index) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Events()),
            );
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Voting()),
            );
            break;
          case 4:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Profile()),
            );
            break;
        }
      },
      letIndexChange: (index) => true,
    );
  }
}
