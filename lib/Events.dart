import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:pawsupunf/Home.dart';
import 'package:pawsupunf/Voting.dart';
import 'package:pawsupunf/Profile.dart';

class Events extends StatefulWidget {
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  int _page = 1; // Set the initial page to Events (0-based index)
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  Color iconColor(int index) {
    return _page == index ? Color(0xFFFFD700) : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
          ),
          Positioned(
            top: 70.0,
            left: 30.0,
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: 'Events',
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
          ),
          Positioned(
            top: 160.0,
            left: 15.0,
            right: 10.0,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(right: 0),
                          child: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Image.asset('lib/assets/setting2.png'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Positioned(
            top: 220.0,
            left: 15.0,
            right: 10.0,
            bottom: 0.0,
            child: Expanded(
            child : SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Color(0xFFD2E1F1),
                        ),
                        height: 143,
                        width: 335,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  CircleAvatar(
                                    radius: 20.0,
                                    backgroundImage: AssetImage('lib/assets/sgpic.jpg'),
                                    backgroundColor: Colors.transparent,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10.0,left: 10.0),  // Adjust value as needed
                                    child: Text(
                                      'Event Info',
                                      style: TextStyle(
                                        fontFamily: 'Sansation',
                                        fontSize: 14.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 0),  // Space between CircleAvatar and Text
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Student Government',
                                    style: TextStyle(
                                      fontFamily: 'Sansation',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  Text(
                                    'Just now',
                                    style: TextStyle(
                                      fontFamily: 'Sansation',
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Container(
                          padding: EdgeInsets.all(0),
                          child: ElevatedButton.icon(
                            icon: Image.asset('lib/assets/regis.png', width: 24, height: 24),
                            label: Text(
                              'Register',
                              style: TextStyle(
                                fontFamily: 'Sansation',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF002365),
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Color(0xFFD2E1F1),
                        ),
                        height: 143,
                        width: 335,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  CircleAvatar(
                                    radius: 20.0,
                                    backgroundImage: AssetImage('lib/assets/sgpic.jpg'),
                                    backgroundColor: Colors.transparent,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10.0,left: 10.0),  // Adjust value as needed
                                    child: Text(
                                      'Event Info',
                                      style: TextStyle(
                                        fontFamily: 'Sansation',
                                        fontSize: 14.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 0),  // Space between CircleAvatar and Text
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Student Government',
                                    style: TextStyle(
                                      fontFamily: 'Sansation',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  Text(
                                    'Just now',
                                    style: TextStyle(
                                      fontFamily: 'Sansation',
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Container(
                          padding: EdgeInsets.all(0),
                          child: ElevatedButton.icon(
                            icon: Image.asset('lib/assets/regis.png', width: 24, height: 24),
                            label: Text(
                              'Registered',
                              style: TextStyle(
                                fontFamily: 'Sansation',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF9AB6EA),
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),


                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Color(0xFFD2E1F1),
                        ),
                        height: 143,
                        width: 335,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  CircleAvatar(
                                    radius: 20.0,
                                    backgroundImage: AssetImage('lib/assets/sgpic.jpg'),
                                    backgroundColor: Colors.transparent,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10.0,left: 10.0),  // Adjust value as needed
                                    child: Text(
                                      'Event Info',
                                      style: TextStyle(
                                        fontFamily: 'Sansation',
                                        fontSize: 14.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 0),  // Space between CircleAvatar and Text
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Student Government',
                                    style: TextStyle(
                                      fontFamily: 'Sansation',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  Text(
                                    'Just now',
                                    style: TextStyle(
                                      fontFamily: 'Sansation',
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Container(
                          padding: EdgeInsets.all(0),
                          child: ElevatedButton.icon(
                            icon: Image.asset('lib/assets/regis.png', width: 24, height: 24),
                            label: Text(
                              'Register',
                              style: TextStyle(
                                fontFamily: 'Sansation',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF002365),
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),


                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Color(0xFFD2E1F1),
                        ),
                        height: 143,
                        width: 335,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  CircleAvatar(
                                    radius: 20.0,
                                    backgroundImage: AssetImage('lib/assets/sgpic.jpg'),
                                    backgroundColor: Colors.transparent,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10.0,left: 10.0),  // Adjust value as needed
                                    child: Text(
                                      'Event Info',
                                      style: TextStyle(
                                        fontFamily: 'Sansation',
                                        fontSize: 14.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 0),  // Space between CircleAvatar and Text
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Student Government',
                                    style: TextStyle(
                                      fontFamily: 'Sansation',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  Text(
                                    'Just now',
                                    style: TextStyle(
                                      fontFamily: 'Sansation',
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Container(
                          padding: EdgeInsets.all(0),
                          child: ElevatedButton.icon(
                            icon: Image.asset('lib/assets/regis.png', width: 24, height: 24),
                            label: Text(
                              'Register',
                              style: TextStyle(
                                fontFamily: 'Sansation',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF002365),
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Color(0xFFD2E1F1),
                        ),
                        height: 143,
                        width: 335,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  CircleAvatar(
                                    radius: 20.0,
                                    backgroundImage: AssetImage('lib/assets/sgpic.jpg'),
                                    backgroundColor: Colors.transparent,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10.0,left: 10.0),  // Adjust value as needed
                                    child: Text(
                                      'Event Info',
                                      style: TextStyle(
                                        fontFamily: 'Sansation',
                                        fontSize: 14.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 0),  // Space between CircleAvatar and Text
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Student Government',
                                    style: TextStyle(
                                      fontFamily: 'Sansation',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  Text(
                                    'Just now',
                                    style: TextStyle(
                                      fontFamily: 'Sansation',
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Container(
                          padding: EdgeInsets.all(0),
                          child: ElevatedButton.icon(
                            icon: Image.asset('lib/assets/regis.png', width: 24, height: 24),
                            label: Text(
                              'Registered',
                              style: TextStyle(
                                fontFamily: 'Sansation',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF9AB6EA),
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                // Repeat for other cards
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
            Image.asset('lib/assets/profile.png', height: 30, width: 30, color: iconColor(3)),
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
              case 2:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Voting()),
                );
                break;
              case 3:
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
