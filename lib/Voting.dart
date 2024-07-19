import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:pawsupunf/Home.dart';
import 'package:pawsupunf/Events.dart';
import 'package:pawsupunf/Profile.dart';
import 'package:pawsupunf/VotingSheet.dart';
import 'locker.dart';

class Voting extends StatefulWidget {
  @override
  _VotingState createState() => _VotingState();
}

class _VotingState extends State<Voting> {
  int _page = 2;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  Color iconColor(int index) {
    return _page == index ? Color(0xFFFFD700) : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 70.0,
            left: 30.0,
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: 'Vote Now!',
                    style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Inter',
                      color: Color(0xFF002365),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 170.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                              },
                              child: Card(
                                color: Color(0xFFD2E1F1),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 70.0,
                                        backgroundImage: AssetImage('lib/assets/sgpic.jpg'),
                                      ),
                                      SizedBox(height: 10.0),
                                      Container(
                                        color: Color(0xFF002365),
                                        padding: EdgeInsets.all(4.0),
                                        child: Text(
                                          'Student Government',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontFamily: 'Inter',
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => VotingSheet()),
                                );
                              },
                          child:Card(
                              color: Color(0xFFD2E1F1),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 70.0,
                                      backgroundImage: AssetImage('lib/assets/comsoc.jpg'),
                                    ),
                                    SizedBox(height: 10.0),
                                    Container(
                                      color: Color(0xFF002365),
                                      padding: EdgeInsets.all(4.0),
                                      child: Text(
                                        "Computer Society",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontFamily: 'Inter',
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Card(
                              color: Color(0xFFD2E1F1),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 70.0,
                                      backgroundImage: AssetImage('lib/assets/pice.jpg'),
                                    ),
                                    SizedBox(height: 10.0),
                                    Container(
                                      color: Color(0xFF002365),
                                      padding: EdgeInsets.all(4.0),
                                      child: Text(
                                        "PICE",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontFamily: 'Inter',
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Card(
                              color: Color(0xFFD2E1F1),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 70.0,
                                      backgroundImage: AssetImage('lib/assets/isite.jpg'),
                                    ),
                                    SizedBox(height: 10.0),
                                    Container(
                                      color: Color(0xFF002365),
                                      padding: EdgeInsets.all(4.0),
                                      child: Text(
                                        "iSITE",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontFamily: 'Inter',
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Card(
                              color: Color(0xFFD2E1F1),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 70.0,
                                      backgroundImage: AssetImage('lib/assets/icpep.jpg'),
                                    ),
                                    SizedBox(height: 10.0),
                                    Container(
                                      color: Color(0xFF002365),
                                      padding: EdgeInsets.all(4.0),
                                      child: Text(
                                        "ICPEP SE",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontFamily: 'Inter',
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Card(
                              color: Color(0xFFD2E1F1),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 70.0,
                                      backgroundImage: AssetImage('lib/assets/uapsa.jpg'),
                                    ),
                                    SizedBox(height: 10.0),
                                    Container(
                                      color: Color(0xFF002365),
                                      padding: EdgeInsets.all(4.0),
                                      child: Text(
                                        "UAPSA",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontFamily: 'Inter',
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Card(
                              color: Color(0xFFD2E1F1),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 70.0,
                                      backgroundImage: AssetImage('lib/assets/nsrc.jpg'),
                                    ),
                                    SizedBox(height: 10.0),
                                    Container(
                                      color: Color(0xFF002365),
                                      padding: EdgeInsets.all(4.0),
                                      child: Text(
                                        "NSRC",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontFamily: 'Inter',
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Card(
                              color: Color(0xFFD2E1F1),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 70.0,
                                      backgroundImage: AssetImage('lib/assets/jpia.jpg'),
                                    ),
                                    SizedBox(height: 10.0),
                                    Container(
                                      color: Color(0xFF002365),
                                      padding: EdgeInsets.all(4.0),
                                      child: Text(
                                        "JPIA",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontFamily: 'Inter',
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        child: CurvedNavigationBar(
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
                break;
              case 1:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Events()),
                );
                break;
              case 3:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Locker()),
                );
                break;
              case 4:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                );
                break;
            }
          },
          letIndexChange: (index) => true,
        ),
      ),
    );
  }
}
