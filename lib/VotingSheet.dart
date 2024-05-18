import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Government Election Ballot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: VotingSheet(),
    );
  }
}

class VotingSheet extends StatefulWidget {
  @override
  _VotingSheetState createState() => _VotingSheetState();
}

class _VotingSheetState extends State<VotingSheet> {
  String? selectedPresident;
  String? selectedVicePresidentInternal;
  int count = 0;

  void updateSelection(String? candidate) {
    setState(() {
      if (candidate != null) {
        count++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Student \nGovernment',
              style: TextStyle(
                color: Color(0xFF002365),
                fontFamily: 'Playfair Display',
                fontWeight: FontWeight.w700,
                decoration: TextDecoration.underline,
                fontSize: 50.0,
              ),
            ),
          ),
          _buildPositionSection('President', [
            _buildCandidateTile('Batumbakal, Johannahaa', 'lib/assets/batumbakal_johanna.jpg', 'Party List', 'president'),
            _buildCandidateTile('Alfredo, Maica Marie', 'lib/assets/alfredo_maica_marie.jpg', 'Party List', 'president'),
            _buildCandidateTile('Bacoor, Louisa Jayne', 'lib/assets/bacoor_louisa_jayne.jpg', 'Party List', 'president'),
          ]),
          _buildPositionSection('Vice President Internal', [
            _buildCandidateTile('Dela Cruz, Janna Mae', 'lib/assets/dela_cruz_janna_mae.jpg', 'Party List', 'vice_president_internal'),
            _buildCandidateTile('Buenaventura, Bert', 'lib/assets/buenaventura_bert.jpg', 'Party List', 'vice_president_internal'),
            // Add more candidates as needed
          ]),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) => Icon(
                Icons.circle,
                color: index < count ? Colors.yellow : Colors.grey,
              )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPositionSection(String positionTitle, List<Widget> candidateTiles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            positionTitle,
            style: TextStyle(
              fontFamily: 'Playfair Display',
              fontWeight: FontWeight.w700,
              fontSize: 20.0,
              color: Color(0xFF002365),
            ),
          ),
        ),
        ...candidateTiles,
      ],
    );
  }

  Widget _buildCandidateTile(String name, String assetName, String party, String position) {
    return ListTile(
      leading: CircleAvatar(
        radius: 40,
        backgroundImage: AssetImage(assetName),
      ),
      title: Text(name, style: TextStyle(color: Color(0xFF002365), fontFamily: 'Playfair Display')),
      subtitle: Text(party, style: TextStyle(color: Color(0x80002365), fontFamily: 'Playfair Display', fontStyle: FontStyle.italic)),
      trailing: Radio(
        value: name,
        groupValue: position == 'president' ? selectedPresident : selectedVicePresidentInternal,
        onChanged: (String? value) {
          setState(() {
            if (position == 'president') {
              selectedPresident = value;
            } else {
              selectedVicePresidentInternal = value;
            }
            updateSelection(value);
          });
        },
      ),
    );
  }
}