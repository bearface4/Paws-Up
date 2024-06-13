import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:pawsupunf/Events.dart';
import 'package:pawsupunf/Voting.dart';
import 'package:pawsupunf/Profile.dart';
import 'package:intl/intl.dart';

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
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  TextEditingController _searchController = TextEditingController();
  String? _userName;
  String _searchQuery = "";
  String? _userDepartment;
  String? _userSchool;
  String _selectedFilter = "Newest to Oldest"; // Default filter

  @override
  void initState() {
    super.initState();
    _loadCurrentUserName();
    _loadUserDetails();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
    });
  }

  Future _loadCurrentUserName() async {
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

  Future _loadUserDetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        setState(() {
          _userDepartment = userDoc.get('department');
          _userSchool = userDoc.get('school');
        });
      }
    }
  }

  Stream<QuerySnapshot> fetchAnnouncements(String userDepartment, String userSchool) {
    return FirebaseFirestore.instance
        .collection('announcements')
        .where('filter', whereIn: [userDepartment, userSchool, 'Everyone'])
        .orderBy('timestamp', descending: _selectedFilter == "Newest to Oldest") // Order by timestamp based on selected filter
        .snapshots();
  }

  void _showFilterOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Image.asset('lib/assets/sortz.png'),
                title: Text('Newest to Oldest',
                  style: TextStyle(
                    color: Color(0xFF002365),
                  ),
                ),
                onTap: () {
                  setState(() {
                    _selectedFilter = "Newest to Oldest";
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Image.asset('lib/assets/sortz.png'),
                title: Text('Oldest to Newest',
                  style: TextStyle(
                    color: Color(0xFF002365),
                  ),
                ),
                onTap: () {
                  setState(() {
                    _selectedFilter = "Oldest to Newest";
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Close the keyboard when tapping outside the text field
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(color: Colors.white),
            Positioned(
              top: 80.0,
              left: 30.0,
              child: RichText(
                text: TextSpan(
                  children: [
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
              top: 200.0,
              left: 15.0,
              right: 10.0,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), spreadRadius: 1, blurRadius: 2, offset: Offset(0, 1))]),
                      child: TextFormField(
                        controller: _searchController,
                        cursorColor: Color(0xFFFFD700),
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
                    onPressed: () {
                      _showFilterOptions(context);
                    },
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              top: 280.0,
              left: 0,
              right: 0,
              child: StreamBuilder<QuerySnapshot>(
                stream: fetchAnnouncements(_userDepartment ?? '', _userSchool ?? ''),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final data = snapshot.data?.docs ?? [];
                  final filteredData = data.where((announcement) {
                    Map<String, dynamic> announcementData = announcement.data() as Map<String, dynamic>;
                    String description = announcementData['description'] ?? '';
                    return RegExp(_searchQuery, caseSensitive: false).hasMatch(description);
                  }).toList();
                  return SingleChildScrollView(
                    child: Column(
                      children: filteredData.map((announcement) {
                        Map<String, dynamic> announcementData = announcement.data() as Map<String, dynamic>;
                        String profileImage = announcementData['profileImage'] ?? 'default_profile_image_url';
                        String orgName = announcementData['orgName'] ?? 'Unknown Organization';
                        Timestamp timestamp = announcementData['timestamp'] ?? Timestamp.now();
                        String description = announcementData['description'] ?? 'No description available.';
                        List<dynamic>? imageUrls = announcementData['imageUrls'];
                        String? imageUrl = announcementData['imageUrl'];
                        return Padding(
                          padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 20.0),
                          child: Card(
                            color: Color(0xFFD2E1F1),
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(radius: 20.0, backgroundImage: NetworkImage(profileImage), backgroundColor: Colors.transparent),
                                      SizedBox(width: 8.0),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(orgName, style: TextStyle(fontFamily: 'Sansation', fontWeight: FontWeight.bold, fontSize: 16.0)),
                                          Text(DateFormat('MM-dd-yyyy hh:mm a').format(timestamp.toDate()), style: TextStyle(fontFamily: 'Sansation', color: Colors.grey, fontSize: 12.0)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.0),
                                  Text(description, style: TextStyle(fontSize: 14.0, fontFamily: 'Sansation')),
                                  SizedBox(height: 10.0),
                                  if (imageUrls != null)
                                    Container(
                                      height: 300,
                                      child: Swiper(
                                        itemBuilder: (BuildContext context, int index) {
                                          return GestureDetector(
                                            onTap: () => _showFullImage(context, imageUrls[index]),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(20.0),
                                              child: SizedBox(
                                                width: 300,
                                                height: 300,
                                                child: Image.network(
                                                  imageUrls[index],
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        itemCount: imageUrls.length,
                                        itemWidth: 300.0,
                                        itemHeight: 300.0,
                                        layout: SwiperLayout.STACK,
                                        loop: false,
                                        pagination: SwiperPagination(
                                          builder: DotSwiperPaginationBuilder(
                                            activeColor: Color(0xFFFFD700),
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (imageUrl != null)
                                    GestureDetector(
                                      onTap: () => _showFullImage(context, imageUrl),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20.0),
                                        child: SizedBox(
                                          width: 300,
                                          height: 300,
                                          child: Image.network(
                                            imageUrl,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          child: CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: 0,
            height: 60.0,
            items: [
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
      ),
    );
  }

  Color iconColor(int index) {
    return _page == index ? Color(0xFFFFD700) : Colors.white;
  }

  void _showFullImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            color: Colors.black,
            child: Image.network(imageUrl),
          ),
        );
      },
    );
  }
}