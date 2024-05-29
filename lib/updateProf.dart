import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:pawsupunf/Home.dart';
import 'package:pawsupunf/Events.dart';
import 'package:pawsupunf/Voting.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pawsupunf/SignIn.dart'; // Import SignIn.dart

class updateProf extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<updateProf> {
  int _page = 3;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? currentUser = FirebaseAuth.instance.currentUser;
  String firstName = '';
  String lastName = '';
  String department = '';
  String section = '';
  String profilePictureURL = '';
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    var document = await _firestore.collection('users').doc(currentUser!.uid).get();
    firstName = document['firstName'];
    lastName = document['lastName'];
    department = document['department'];
    section = document['section'];
    profilePictureURL = document['profilePictureURL'] ?? '';
    setState(() {});
  }

  Future<void> uploadProfilePicture() async {
    setState(() {
      _isUploading = true;
    });

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final ref = FirebaseStorage.instance.ref().child("profilePictures/${currentUser!.uid}");
      await ref.putFile(File(pickedFile.path));
      final downloadURL = await ref.getDownloadURL();
      await currentUser!.updatePhotoURL(downloadURL);

      // Store the profile picture URL in Firestore
      await _firestore.collection('users').doc(currentUser!.uid).update({
        'profilePictureURL': downloadURL,
      });

      setState(() {
        profilePictureURL = downloadURL;
        _isUploading = false;
      });
    } else {
      setState(() {
        _isUploading = false;
      });
    }
  }

  // Add signOutUser function
  Future<void> signOutUser() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SignIn()),
          (Route<dynamic> route) => false,
    );
  }

  Color iconColor(int index) {
    return _page == index ? Color(0xFFFFD700) : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 90.0,
            left: 90.0,
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
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
          Padding(
            padding: EdgeInsets.only(top: 120.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 100,
                        backgroundImage: profilePictureURL.isNotEmpty
                            ? NetworkImage(profilePictureURL) as ImageProvider<Object>?
                            : AssetImage('lib/assets/blue.png'),
                        child: _isUploading
                            ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF002365)),
                        )
                            : null,
                      ),
                      Positioned(
                        bottom: -5,
                        right: 75,
                        child: IconButton(
                          icon: Icon(Icons.camera_alt),
                          onPressed: () {
                            uploadProfilePicture();
                            setState(() {
                              _isUploading = true;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
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
                  // Add new widgets here
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // Example of new widget
                      SizedBox(
                        width: 316,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFF002365),
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 119, vertical: 10),
                          child: Text(
                            'New Widget 1',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'Inter',
                              color: Color(0xFF002365),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: 316,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFF002365),
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 114, vertical: 10),
                          child: Text(
                            'New Widget 2',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'Inter',
                              color: Color(0xFF002365),
                            ),
                          ),
                        ),
                      ),
                      // Add more widgets as needed
                    ],
                  ),
                ],
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
              case 1:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Events()),
                );
                break;
              case 2:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Voting()),
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