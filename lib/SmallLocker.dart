import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Locker App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
      ),
      home: SmallLocker(),
    );
  }
}

class SmallLocker extends StatelessWidget {
  final List<Locker> lockers = List.generate(12, (index) {
    String id = 'S${(index + 1).toString().padLeft(2, '0')}';
    LockerStatus status = LockerStatus.values[index % 3]; // Cycle through statuses
    return Locker(id, status);
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildChooseLockerSize(),
            Expanded(
              child: _buildLockerGrid(),
            ),
            _buildLegend(),
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
          'Locker',
          style: TextStyle(
            fontSize: 50.0,
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
                    child: LockerWidget(lockers[index]),
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LegendItem(color: Colors.blue, label: 'Available'),
          SizedBox(width: 16),
          LegendItem(color: Colors.red, label: 'Occupied'),
          SizedBox(width: 16),
          LegendItem(color: Colors.yellow, label: 'Reserved'),
        ],
      ),
    );
  }
}

class Locker {
  final String id;
  final LockerStatus status;

  Locker(this.id, this.status);
}

enum LockerStatus { available, reserved, occupied }

class LockerWidget extends StatelessWidget {
  final Locker locker;

  LockerWidget(this.locker);

  @override
  Widget build(BuildContext context) {
    Color getStatusColor() {
      switch (locker.status) {
        case LockerStatus.available:
          return Colors.blue;
        case LockerStatus.reserved:
          return Colors.yellow;
        case LockerStatus.occupied:
          return Colors.red;
      }
    }

    return Container(
      width: 80,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            locker.id,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
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
