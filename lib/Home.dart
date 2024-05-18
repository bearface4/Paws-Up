import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pawsupunf/Events.dart';
import 'package:pawsupunf/Voting.dart';
import 'package:pawsupunf/Profile.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  TextEditingController _searchController = TextEditingController();
  String? _userName;

  @override
  void initState() {
    super.initState();
    _loadCurrentUserName();
  }

  Future<void> _loadCurrentUserName() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        setState(() {
          _userName = userDoc.get('firstName');
        });
      }
    }
  }

  Color iconColor(int index) {
    return _page == index ? Color(0xFFFFD700) : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(color: Colors.white),
          Positioned(
            top: 80.0,
            left: 30.0,
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: 'Hello, \n',
                    style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, fontFamily: 'Inter', color: Color(0xFF002365)),
                  ),
                  TextSpan(
                    text: _userName ?? '',
                    style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold, fontFamily: 'Playfair Display', color: Color(0xFF002365)),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 57.0,
            right: 10.0,
            child: Image.asset('lib/assets/log2.png', height: 140, width: 140),
          ),
          Positioned(
            top: 200.0,
            left: 15.0,
            right: 10.0,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), spreadRadius: 1, blurRadius: 2, offset: Offset(0, 1))]),
                    child: TextFormField(controller: _searchController, decoration: InputDecoration(border: InputBorder.none, suffixIcon: Padding(padding: EdgeInsets.only(right: 0), child: Icon(Icons.search)))),
                  ),
                ),
                IconButton(icon: Image.asset('lib/assets/setting2.png'), onPressed: () {}),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            top: 280.0,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Card(
                      color: Color(0xFFD2E1F1),
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                CircleAvatar(radius: 20.0, backgroundImage: AssetImage('lib/assets/sgpic.jpg'), backgroundColor: Colors.transparent),
                                SizedBox(width: 8.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Student Government', style: TextStyle(fontFamily: 'Sansation', fontWeight: FontWeight.bold, fontSize: 16.0)),
                                    Text('Just Now', style: TextStyle(fontFamily: 'Sansation', color: Colors.grey, fontSize: 12.0)),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0),
                            Text('SDAO ADVISORY', style: TextStyle(fontFamily: 'Sansation', fontWeight: FontWeight.bold, fontSize: 18.0)),
                            SizedBox(height: 10.0),
                            Text(
                              'As communicated by the Student Discipline Office (SDO), students are permitted to wear civilian attire on Thursday (April 11) and Friday (April 12), but it is limited to any NU merchandise (including NSTP shirts, PE uniforms, and organization shirts) and must adhere to the University\'s dress code.',
                              style: TextStyle(fontSize: 14.0, fontFamily: 'Sansation'),
                            ),
                            SizedBox(height: 10.0),
                            Text('Furthermore, ALL students are required to wear their Prescribed Uniform starting April 15, 2024.', style: TextStyle(fontFamily: 'Sansation', fontSize: 14.0)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Please adhere to these guidelines accordingly.', style: TextStyle(fontFamily: 'Sansation', fontSize: 14.0)),
                                SizedBox(height: 10.0),
                                Image.asset('lib/assets/testpic.jpg'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        child: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
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
              case 3:
                Navigator.push(
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
