import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:pawsupunf/Home.dart';
import 'package:pawsupunf/Profile.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:intl/intl.dart';
import 'package:pawsupunf/locker.dart';
import 'package:url_launcher/url_launcher.dart';

class Events extends StatefulWidget {
  @override
  _EventsState createState() => _EventsState();
}

Future<bool> isUserRegistered(String eventDocumentId) async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('events')
        .doc(eventDocumentId)
        .collection('registered_users')
        .where('email', isEqualTo: user.email)
        .get();
    return querySnapshot.docs.isNotEmpty;
  } else {
    throw Exception('No user is currently signed in.');
  }
}

Future<Map<String, dynamic>> getCurrentUserDetails() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    // Assuming you have stored additional user details in Firestore
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    return userDoc.data() as Map<String, dynamic>;
  } else {
    throw Exception('No user is currently signed in.');
  }
}

Future<List<QueryDocumentSnapshot>> fetchEvents(String userDepartment, String userSchool) async {
  List<QueryDocumentSnapshot> events = [];

  // Fetch events where the filter matches the user's department
  QuerySnapshot departmentEvents = await FirebaseFirestore.instance
      .collection('events')
      .where('filter', isEqualTo: userDepartment)
      .get();
  events.addAll(departmentEvents.docs);

  // Fetch events where the filter matches the user's school
  QuerySnapshot schoolEvents = await FirebaseFirestore.instance
      .collection('events')
      .where('filter', isEqualTo: userSchool)
      .get();
  events.addAll(schoolEvents.docs);

  // Fetch events open to everyone
  QuerySnapshot everyoneEvents = await FirebaseFirestore.instance
      .collection('events')
      .where('filter', isEqualTo: 'Everyone')
      .get();
  events.addAll(everyoneEvents.docs);

  // Remove duplicate events
  final uniqueEvents = events.toSet().toList();

  return uniqueEvents;
}

class _EventsState extends State<Events> {
  int _page = 1; // Set the initial page to Events (0-based index)
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isNewestFirst = true; // Default to showing newest events first

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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

  void _showRegisterDialog(BuildContext context, String eventDocumentId, String? link) async {
    if (link != null) {
      _showLinkDialog(context, link);
    } else {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Register',
              style: TextStyle(color: Color(0xFF002365), fontFamily: 'Inter'),
            ),
            content: Text('Do you want to register for this event?'),
            actions: <Widget>[
              TextButton(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.check_circle, color: Colors.green),
                    SizedBox(width: 8),
                    Text(
                      'Register',
                      style: TextStyle(color: Colors.black, fontFamily: 'Inter'),
                    ),
                  ],
                ),
                onPressed: () async {
                  try {
                    // Get current user details
                    Map<String, dynamic> userDetails = await getCurrentUserDetails();

                    // Add registration details to the subcollection
                    await FirebaseFirestore.instance
                        .collection('events')
                        .doc(eventDocumentId) // Use the specific event document ID
                        .collection('registered_users')
                        .add({
                      'firstName': userDetails['firstName'],
                      'lastName': userDetails['lastName'],
                      'section': userDetails['section'],
                      'department': userDetails['department'],
                      'email': userDetails['email'],
                      'studentId': userDetails['studentId'],
                      'timestamp': FieldValue.serverTimestamp(),
                    });

                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Registered successfully!'),
                        backgroundColor: Color(0xFFFFD700), // Sets the Snackbar color to gold
                      ),
                    );
                    setState(() {}); // Update the state to reflect the registration status

                  } catch (e) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Registration failed: $e'),
                          backgroundColor: Colors.red,
                        ));
                  }
                },
              ),
              TextButton(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.cancel, color: Colors.red),
                    SizedBox(width: 8),
                    Text(
                      'Cancel',
                      style: TextStyle(color: Colors.black, fontFamily: 'Inter'),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _showLinkDialog(BuildContext context, String link) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('External Link',
            style: TextStyle(
              color: Color(0xFF002365),
            ),
          ),
          content: Text('Do you want to visit the registration page?'),
          actions: <Widget>[
            TextButton(
              child: Text('Yes',
                style: TextStyle(
                  color: Color(0xFF002365),
                ),
              ),
              onPressed: () async {
                final Uri _url = Uri.parse(link);
                if (!await launchUrl(_url)) {
                  throw Exception('Could not launch $_url');
                }
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('No',
                style: TextStyle(
                  color: Color(0xFF002365),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showFilterOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                    _isNewestFirst = true;
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
                    _isNewestFirst = false;
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
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(color: Colors.white),
            _buildHeader(),
            _buildSearchBar(),
            _buildEventList(),
          ],
        ),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
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
    );
  }

  Widget _buildSearchBar() {
    return Positioned(
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
                controller: _searchController,
                cursorColor: Color(0xFFFFD700), // Set the cursor color to gold
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
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
    );
  }

  Widget _buildEventList() {
    return Positioned(
      top: 220.0,
      left: 15.0,
      right: 10.0,
      bottom: 0.0,
      child: FutureBuilder<Map<String, dynamic>>(
        future: getCurrentUserDetails(),
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (userSnapshot.hasError) {
            return Center(child: Text('Error: ${userSnapshot.error}'));
          } else if (!userSnapshot.hasData) {
            return Center(child: Text('No user data found'));
          } else {
            Map<String, dynamic> userDetails = userSnapshot.data!;
            String userDepartment = userDetails['department'];
            String userSchool = userDetails['school'];

            return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('events')
                  .where('filter', whereIn: [userDepartment, userSchool, 'Everyone'])
                  .orderBy('timestamp', descending: _isNewestFirst)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No events found'));
                } else {
                  List<QueryDocumentSnapshot> events = snapshot.data!.docs;
                  String searchQuery = _searchQuery.toLowerCase();
                  RegExp regExp = RegExp(searchQuery, caseSensitive: false);

                  List<QueryDocumentSnapshot> filteredEvents = events.where((eventDoc) {
                    Map<String, dynamic> event = eventDoc.data() as Map<String, dynamic>;
                    String title = event['title']?.toLowerCase() ?? '';
                    String description = event['description']?.toLowerCase() ?? '';
                    return regExp.hasMatch(title) || regExp.hasMatch(description);
                  }).toList();

                  return SingleChildScrollView(
                    child: Column(
                      children: filteredEvents.map((eventDoc) {
                        Map<String, dynamic> event = eventDoc.data() as Map<String, dynamic>;
                        return Column(
                          children: [
                            _buildEventCard(event, eventDoc.id),
                            SizedBox(height: 20), // Add space between event cards
                          ],
                        );
                      }).toList(),
                    ),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildEventCard(Map<String, dynamic> event, String eventDocumentId) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Color(0xFFD2E1F1),
        ),
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEventHeader(event),
            if (event['imageUrl'] != null) _buildEventImage(event['imageUrl']),
            if (event['imageUrls'] != null) _buildEventImageSwiper(event['imageUrls']),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildRegisterButton(eventDocumentId, event['link']),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventHeader(Map<String, dynamic> event) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 20.0,
          backgroundImage: event['profileImage'] != null && event['profileImage'].isNotEmpty
              ? NetworkImage(event['profileImage'])
              : AssetImage('lib/assets/blue.png') as ImageProvider,
          backgroundColor: Colors.transparent,
        ),
        SizedBox(width: 10), // Space between CircleAvatar and Text
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    event['orgName'] ?? 'Unknown Organization',
                    style: TextStyle(
                      fontFamily: 'Sansation',
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'lib/assets/group.png', // Replace with your filter icon path
                        width: 20,
                        height: 20,
                      ),
                      SizedBox(width: 5), // Space between icon and text
                      Text(
                        event['filter'] ?? 'No filter',
                        style: TextStyle(
                          fontFamily: 'Sansation',
                          fontSize: 14.0,
                          color: Color(0xFF002365),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                event['timestamp'] != null
                    ? DateFormat('MM/dd/yyyy, hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(event['timestamp'].seconds * 1000))
                    : 'No timestamp',
                style: TextStyle(
                  fontFamily: 'Sansation',
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 5), // Space between timestamp and title
              Text(
                event['title'] ?? 'No title', // Fetch and display the title
                style: TextStyle(
                  fontFamily: 'Sansation',
                  fontWeight: FontWeight.bold, // Make the title bold
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 5), // Space between title and description
              Text(
                event['description'] ?? 'No description',
                style: TextStyle(
                  fontFamily: 'Sansation',
                  fontSize: 14.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }


  Widget _buildEventImage(String imageUrl) {
    return Container(
      width: 300,
      height: 300,
      margin: EdgeInsets.only(top: 10),
      child: GestureDetector(
        onTap: () => _showFullImage(context, imageUrl),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildEventImageSwiper(List<dynamic> imageUrls) {
    return Container(
      height: 300,
      margin: EdgeInsets.only(top: 10),
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
        loop: false, // Disable looping
        pagination: SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            activeColor: Color(0xFFFFD700), // Active bullet color
            color: Colors.grey, // Inactive bullet color
          ),
        ), // Add pagination bullets with custom colors
      ),
    );
  }

  Widget _buildRegisterButton(String eventDocumentId, String? link) {
    return FutureBuilder<bool>(
        future: isUserRegistered(eventDocumentId),
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return CircularProgressIndicator();
    } else if (snapshot.hasError) {
    return Text('Error: ${snapshot.error}');
    } else if (snapshot.hasData && snapshot.data == true) {
    return ElevatedButton.icon(
      icon: Image.asset('lib/assets/regis.png', width: 24, height: 24),
      label: Text(
        'Registered',
        style: TextStyle(
          fontFamily: 'Sansation',
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      onPressed: null, // Disable the button
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF5A8DEA), // This color is ignored because the button is disabled
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      ).copyWith(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return Color(0xFF5A8DEA); // Set the disabled background color to blue
            }
            return Color(0xFF5A8DEA); // Default color
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors.white; // Set the disabled foreground color
            }
            return Colors.white; // Default color
          },
        ),
      ),
    );
    } else {
      return ElevatedButton.icon(
        icon: Image.asset('lib/assets/regis.png', width: 24, height: 24),
        label: Text(
          'Register',
          style: TextStyle(
            fontFamily: 'Sansation',
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        onPressed: () {
          _showRegisterDialog(context, eventDocumentId, link);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF002365),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        ),
      );
    }
    },
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
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
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Locker()),
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
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Events(),
  ));
}