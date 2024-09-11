import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
      ),
      home: LargeLocker(),
    );
  }
}

class LargeLocker extends StatefulWidget {
  @override
  _LargeLockerState createState() => _LargeLockerState();
}

class _LargeLockerState extends State<LargeLocker> {
  final List<Locker> lockers = List.generate(60, (index) {
    String id = 'L${(index + 1).toString().padLeft(2, '0')}';
    LockerStatus status = LockerStatus.available;
    return Locker(id, status);
  });

  int currentPage = 0;
  static const int lockersPerPage = 12;

  @override
  void initState() {
    super.initState();
    _fetchApprovedLockers();
  }

  Future<void> _fetchApprovedLockers() async {
    try {
      // Fetch approved lockers from Firestore
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('approvedLockers').get();

      // Loop through the approved lockers and mark them as approved
      for (var doc in snapshot.docs) {
        String lockerId = doc['lockerId']; // Assuming approved lockers have a lockerId field
        int index = lockers.indexWhere((locker) => locker.id == lockerId);
        if (index != -1) {
          setState(() {
            lockers[index].status = LockerStatus.occupied;
            lockers[index].isApproved = true;
          });
        }
      }
    } catch (e) {
      print('Error fetching approved lockers: $e');
    }
  }

  void _nextPage() {
    setState(() {
      if ((currentPage + 1) * lockersPerPage < lockers.length) {
        currentPage++;
      }
    });
  }

  void _previousPage() {
    setState(() {
      if (currentPage > 0) {
        currentPage--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(''),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildChooseLockerSize(),
            SizedBox(height: 10),
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    top: -150,
                    child: _buildLockerGrid(),
                  ),
                  Positioned(
                    left: 0,
                    top: MediaQuery.of(context).size.height / 2.7 - 100,
                    child: _buildNavigationButton(Icons.arrow_back_ios, _previousPage, currentPage == 0),
                  ),
                  Positioned(
                    right: 0,
                    top: MediaQuery.of(context).size.height / 2.7 - 100,
                    child: _buildNavigationButton(Icons.arrow_forward_ios, _nextPage, (currentPage + 1) * lockersPerPage >= lockers.length),
                  ),
                  Positioned(
                    bottom: 130.0,
                    left: 0,
                    right: 0,
                    child: _buildLegend(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, top: 0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Locker (L)',
          style: TextStyle(
            fontFamily: "Inter",
            fontSize: 45.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF002365),
          ),
        ),
      ),
    );
  }

  Widget _buildChooseLockerSize() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
        decoration: BoxDecoration(
          color: Color(0xFFD5E0F5),
        ),
        child: Center(
          child: Text(
            'Choose locker position',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF002365),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLockerGrid() {
    int start = currentPage * lockersPerPage;
    int end = (start + lockersPerPage).clamp(0, lockers.length);
    List<Locker> currentLockers = lockers.sublist(start, end);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(4, (rowIndex) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (colIndex) {
                  int index = rowIndex * 3 + colIndex;
                  if (index < currentLockers.length) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: LockerWidget(currentLockers[index]),
                    );
                  } else {
                    return Container(width: 80, height: 100);
                  }
                }),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LegendItem(color: Color(0xFF002365), label: 'Available'),
        SizedBox(width: 16),
        LegendItem(color: Colors.amber, label: 'Occupied'),
      ],
    );
  }

  Widget _buildNavigationButton(IconData icon, VoidCallback onPressed, bool disabled) {
    return Container(
      width: 50,
      height: 100,
      alignment: Alignment.center,
      child: IconButton(
        icon: Icon(icon, size: 24.0),
        onPressed: disabled ? null : onPressed,
        color: disabled ? Colors.grey : Colors.black,
      ),
    );
  }
}

class Locker {
  final String id;
  LockerStatus status;
  bool isApproved; // Indicates if the locker is approved (and can't be reserved)

  Locker(this.id, this.status, {this.isApproved = false});
}

enum LockerStatus { available, occupied }

class LockerWidget extends StatelessWidget {
  final Locker locker;

  LockerWidget(this.locker);

  Future<void> _showLockerDialog(BuildContext context) async {
    // Prevent action if the locker is approved
    if (locker.isApproved) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('This locker is already occupied.')),
      );
      return;
    }

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('You must be logged in to reserve a locker.')),
        );
      }
      return;
    }

    final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    if (!userDoc.exists) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User data not found.')),
        );
      }
      return;
    }

    final userData = userDoc.data()!;
    if (context.mounted) {
      final result = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            contentPadding: EdgeInsets.all(20.0),
            backgroundColor: Color(0xFFD5E0F5),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Locker ${locker.id}',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'is Available',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Reserve locker now?',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF002365),
                        onPrimary: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: Text('Yes'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Color(0xFF002365),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text('No'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );

      if (result == true) {
        _showReservationDetailsDialog(context, user, userData);
      }
    }
  }

  Future<void> _showReservationDetailsDialog(BuildContext context, User user, Map<String, dynamic> userData) async {
    if (context.mounted) {
      final proceed = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            contentPadding: EdgeInsets.all(20.0),
            backgroundColor: Color(0xFFD5E0F5),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Locker ${locker.id}',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Per locker dimensions: 32 x 11 inches',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Per academic year: ₱1300.00',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF002365),
                    onPrimary: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text('Avail Locker'),
                ),
              ],
            ),
          );
        },
      );

      if (proceed == true) {
        await _reserveLocker(context, user.uid, userData);
      }
    }
  }

  Future<void> _reserveLocker(BuildContext context, String userId, Map<String, dynamic> userData) async {
    try {
      Timestamp now = Timestamp.now();

      Map<String, dynamic> reservationData = {
        'LockerNum': locker.id,
        'firstName': userData['firstName'] ?? '',
        'lastName': userData['lastName'] ?? '',
        'department': userData['department'] ?? '',
        'profilePictureURL': userData['profilePictureURL'] ?? '',
        'reqDate': now,
        'status': 'Reserved',
      };

      await FirebaseFirestore.instance
          .collection('lockers')
          .doc('largeLockers')
          .collection(locker.id)
          .doc()
          .set(reservationData);

      if (context.mounted) {
        _showConfirmationDialog(context);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to reserve locker: $e')),
        );
      }
    }
  }

  void _showConfirmationDialog(BuildContext context) {
    if (context.mounted) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            contentPadding: EdgeInsets.all(20.0),
            backgroundColor: Color(0xFFD5E0F5),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.network(
                  'https://lottie.host/a27683f1-ebcd-46fd-9ee0-a7edec74fd1d/cdgXKPI98Y.json',
                  height: 64,
                  width: 64,
                  fit: BoxFit.contain,
                  repeat: false,
                  animate: true,
                ),
                SizedBox(height: 10),
                Text(
                  'Success',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Proceed to the Student Developments and Activity Office (Office) for agreement signing and payment stub. Also prepare a duplicate key of your lock.',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF002365),
                    onPrimary: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Color getStatusColor() {
      switch (locker.status) {
        case LockerStatus.available:
          return Color(0xFF002365);
        case LockerStatus.occupied:
          return Colors.amber;
      }
    }

    return GestureDetector(
      onTap: () => _showLockerDialog(context),
      child: Container(
        width: 80,
        height: 100,
        decoration: BoxDecoration(
          color: Color(0xFFf5deb3),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Color(0xFFd2b48c)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              padding: EdgeInsets.symmetric(vertical: 2.0),
              decoration: BoxDecoration(
                color: Color(0xFF9F907E),
              ),
              child: Center(
                child: Text(
                  locker.id,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            CircleAvatar(
              radius: 25,
              backgroundColor: getStatusColor(),
            ),
          ],
        ),
      ),
    );
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          color: color,
        ),
        SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 14)),
      ],
    );
  }
}
