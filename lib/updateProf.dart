import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:pawsupunf/Home.dart';
import 'package:pawsupunf/Events.dart';
import 'package:pawsupunf/locker.dart';
import 'package:image_picker/image_picker.dart';

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
  String studentId = '';
  String email = '';
  String department = '';
  String section = '';
  String school = '';
  String profilePictureURL = '';
  bool _isUploading = false;

  TextEditingController departmentController = TextEditingController();
  TextEditingController sectionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    var document = await _firestore.collection('users').doc(currentUser!.uid).get();
    var data = document.data();

    if (data != null) {
      setState(() {
        firstName = data['firstName'] ?? '';
        lastName = data['lastName'] ?? '';
        studentId = data['studentId'] ?? '';
        email = data['email'] ?? '';
        department = data['department'] ?? '';
        section = data['section'] ?? '';
        school = data['school'] ?? '';
        profilePictureURL = data.containsKey('profilePictureURL') ? data['profilePictureURL'] : '';
        departmentController.text = department;
        sectionController.text = section;
      });
    }
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

  void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Color iconColor(int index) {
    return _page == index ? Color(0xFFFFD700) : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null, // No title
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
    child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 50.0),
            Text(
              'My Profile',
              style: TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.w700,
                fontFamily: 'Inter',
                color: Color(0xFF002365),
              ),
            ),
            SizedBox(height: 20.0),
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 100,
                  backgroundImage: (profilePictureURL != null && profilePictureURL.isNotEmpty)
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 300,
                    child: TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        labelStyle: TextStyle(
                          fontFamily: 'Inter',
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      style: TextStyle(
                        fontFamily: 'Inter',
                      ),
                      controller: TextEditingController(text: '$lastName, $firstName'),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'ID Number',
                        labelStyle: TextStyle(
                          fontFamily: 'Inter',
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      style: TextStyle(
                        fontFamily: 'Inter',
                      ),
                      controller: TextEditingController(text: studentId),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'School Email',
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      controller: TextEditingController(text: email),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'School',
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      controller: TextEditingController(text: school),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Department',
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      controller: departmentController,
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Section',
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      controller: sectionController,
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: Container(
        child: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: _page,
          height: 60.0,
          items: <Widget>[
            Image.asset('lib/assets/homez.png', height: 30, width: 30, color: iconColor(0)),
            Image.asset('lib/assets/star.png', height: 30, width: 30, color: iconColor(1)),
            Image.asset('lib/assets/lockers.png', height: 30, width: 30, color: iconColor(2)),
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
                  MaterialPageRoute(builder: (context) => Locker()),
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