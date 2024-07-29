import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:pawsupunf/Events.dart';
import 'package:pawsupunf/Home.dart';
import 'package:pawsupunf/Voting.dart';
import 'package:pawsupunf/Profile.dart';
import 'package:pawsupunf/MediumLocker.dart';

import 'LargeLocker.dart';
import 'SmallLocker.dart'; // Import the SmallLocker class

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
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildChooseLockerSize(),
            Expanded(
              child: _buildLockerSizeList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, top: 20.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Locker',
          style: TextStyle(
            fontSize: 50.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
            color: Color(0xFF002365),
          ),
        ),
      ),
    );
  }

  Widget _buildChooseLockerSize() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0), // Adjust this value to move it further down
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
        decoration: BoxDecoration(
          color: Color(0xFFD5E0F5),
        ),
        child: Center(
          child: Text(
            'Choose locker size',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
              color: Color(0xFF002365),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLockerSizeList() {
    return Padding(
      padding: EdgeInsets.only(top: 30.0),
      child: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          _buildLockerSizeRectangle('Small Locker', '16 x 11 inches\n200 per Term\n\500php per Term', true),
          SizedBox(height: 35),
          _buildLockerSizeRectangle('Medium Locker', '21.5 x 11 inches\n300php per Term\n\800php per Term', true),
          SizedBox(height: 45),
          _buildLockerSizeRectangle('Large Locker', '32 x 11 inches\n450php per Term\n\1300 per Term', true),
        ],
      ),
    );
  }

  Widget _buildLockerSizeRectangle(String size, String details, bool isGold) {
    double imageSize;
    switch (size) {
      case 'Small Locker':
        imageSize = 50;
        break;
      case 'Medium Locker':
        imageSize = 60;
        break;
      case 'Large Locker':
        imageSize = 70;
        break;
      default:
        imageSize = 60;
    }

    return GestureDetector(
      onTap: () {
        if (size == 'Small Locker') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SmallLocker()),
          );
        } else if (size == 'Medium Locker') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MediumLocker()),
          );
        } else if (size == 'Large Locker') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LargeLocker()),
          );
        }
      },
      child: Container(
        width: double.infinity,
        height: 100.0,
        decoration: BoxDecoration(
          color: Color(0xFF002365),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                'lib/assets/lopi.png',
                width: imageSize,
                height: imageSize,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      size,
                      style: TextStyle(
                        color: isGold ? Color(0xFFFFD700) : Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                      ),
                    ),
                    ...details.split('\n').map((line) => Text(
                      line,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontFamily: 'Inter',
                      ),
                    )).toList(),
                  ],
                ),
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
