import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:pawsupunf/Home.dart';
import 'package:pawsupunf/Events.dart';
import 'package:pawsupunf/Voting.dart';
import 'package:pawsupunf/changePass.dart';
import 'package:pawsupunf/locker.dart';
import 'package:pawsupunf/updateProf.dart';
import 'package:pawsupunf/SignIn.dart'; // Import SignIn.dart

class Profile extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<Profile> {
  int _page = 4;
  GlobalKey _bottomNavigationKey = GlobalKey();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? currentUser = FirebaseAuth.instance.currentUser;
  String firstName = '';
  String lastName = '';
  String department = '';
  String section = '';
  String profilePictureURL = '';

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future getUserData() async {
    var document = await _firestore.collection('users').doc(currentUser!.uid).get();
    var data = document.data();
    if (data != null) {
      firstName = data['firstName'] ?? '';
      lastName = data['lastName'] ?? '';
      department = data['department'] ?? '';
      section = data['section'] ?? '';
      profilePictureURL = data.containsKey('profilePictureURL') ? data['profilePictureURL'] : '';
      setState(() {});
    }
  }

  Future signOutUser() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SignIn()),
          (Route route) => false,
    );
  }

  Color iconColor(int index) {
    return _page == index ? Color(0xFFFFD700) : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Adjust the top value to move the text down
            Padding(
              padding: EdgeInsets.only(top: 100.0), // Adjust this value to move the text down
              child: Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'My Profile',
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
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 100,
                      backgroundImage: (profilePictureURL != null && profilePictureURL.isNotEmpty)
                          ? NetworkImage(profilePictureURL) as ImageProvider?
                          : AssetImage('lib/assets/blue.png'),
                    ),
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 0),
                          child: Text(
                            '$lastName, \n$firstName',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Text(
                          '$department',
                          style: TextStyle(
                            fontFamily: 'Sansation',
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 316,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => updateProf()),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xFF002365),
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                              child: Text(
                                'Profile Info',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: 'Inter',
                                  color: Color(0xFF002365),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          width: 316,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => changePass()),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xFF002365),
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: Center(
                                child: Text(
                                  'Change Password',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: 'Inter',
                                    color: Color(0xFF002365),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          width: 316,
                          child: InkWell(
                            onTap: signOutUser,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xFF002365),
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 118, vertical: 10),
                              child: Text(
                                'Logout',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: 'Inter',
                                  color: Color(0xFF002365),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        child: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: _page,
          height: 60.0,
          items: [
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
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
                break;
              case 1:
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Events()));
                break;
              case 2:
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Voting()));
                break;
              case 3:
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Locker()));
                break;
            }
          },
          letIndexChange: (index) => true,
        ),
      ),
    );
  }
}
