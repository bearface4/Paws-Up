import 'package:flutter/material.dart';

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
    String id = 'S${(index + 1).toString().padLeft(2, '0')}';
    LockerStatus status = (index < 27) ? LockerStatus.occupied : LockerStatus.available;
    return Locker(id, status);
  });

  int currentPage = 0;
  static const int lockersPerPage = 12;

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
                    top: -150, // Move the locker grid up
                    child: _buildLockerGrid(),
                  ),
                  Positioned(
                    left: 0,
                    top: MediaQuery.of(context).size.height / 2.7 - 100, // Move arrows up
                    child: _buildNavigationButton(Icons.arrow_back_ios, _previousPage, currentPage == 0),
                  ),
                  Positioned(
                    right: 0,
                    top: MediaQuery.of(context).size.height / 2.7 - 100, // Move arrows up
                    child: _buildNavigationButton(Icons.arrow_forward_ios, _nextPage, (currentPage + 1) * lockersPerPage >= lockers.length),
                  ),
                  Positioned(
                    bottom: 130.0, // Position the legend independently
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
      padding: const EdgeInsets.only(left: 30.0, top: 20.0),
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
    int end = start + lockersPerPage;
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
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: LockerWidget(currentLockers[index]),
                  );
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
        LegendItem(color: Colors.blue, label: 'Available'),
        SizedBox(width: 16),
        LegendItem(color: Colors.amber, label: 'Occupied'),
      ],
    );
  }

  Widget _buildNavigationButton(IconData icon, VoidCallback onPressed, bool disabled) {
    return Container(
      width: 50, // Fixed width to prevent overflow
      height: 100,
      alignment: Alignment.center,
      child: IconButton(
        icon: Icon(icon, size: 24.0),
        onPressed: disabled ? null : onPressed,
        color: disabled ? Colors.grey : Colors.black, // Grey out if disabled
      ),
    );
  }
}

class Locker {
  final String id;
  final LockerStatus status;

  Locker(this.id, this.status);
}

enum LockerStatus { available, occupied }

class LockerWidget extends StatelessWidget {
  final Locker locker;

  LockerWidget(this.locker);

  @override
  Widget build(BuildContext context) {
    Color getStatusColor() {
      switch (locker.status) {
        case LockerStatus.available:
          return Colors.blue;
        case LockerStatus.occupied:
          return Colors.amber; // Gold color for occupied
      }
    }

    return Container(
      width: 80,
      height: 100,
      decoration: BoxDecoration(
        color: Color(0xFFf5deb3), // Light brown background
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Color(0xFFd2b48c)), // Border color
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80, // Adjusted width
            padding: EdgeInsets.symmetric(vertical: 2.0),
            decoration: BoxDecoration(
              color: Color(0xFF9F907E), // Beige background for text
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
            radius: 16,
            backgroundColor: getStatusColor(),
          ),
        ],
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
