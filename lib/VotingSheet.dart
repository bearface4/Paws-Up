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
  String? selectedVicePresident;
  String? selectedVicePresidentExt;
  String? selectedSecretary;
  String? selectedAuditor;
  String? selectedTreasurer;
  String? selectedPRO;
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
      body: Center(
        child: Expanded(
          child: Card(
            color: Color(0xFFAFC4EC),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(
                shrinkWrap: true,
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
                          fontSize: 50.0, //change the size as you need
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        'President',
                        style: TextStyle(
                          fontFamily: 'Playfair Display',
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Color(0xFF002365),
                        )
                    ),
                  ),
                  // Candidate 1
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('lib/assets/jen.jpg'),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(text: 'Candidate 1',
                                        style: TextStyle(
                                          fontFamily: 'Playfair Display',
                                          fontSize: 15.0,
                                          color: Color(0xFF002365),
                                        )
                                    ),
                                    TextSpan(text: '\n[Party List]',
                                        style: TextStyle(
                                          fontFamily: 'Playfair Display',
                                          fontStyle: FontStyle.italic,
                                          fontSize: 15.0,
                                          color: Color(0x80002365),
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        MyRadioButton(
                          isSelected: selectedPresident == 'Candidate 1',
                          onSelect: () {
                            setState(() {
                              selectedPresident = 'Candidate 1';
                              updateSelection(selectedPresident);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  // Candidate 2
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('lib/assets/rose.jpg'),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(text: 'Candidate 2',
                                        style: TextStyle(
                                          fontFamily: 'Playfair Display',
                                          fontSize: 15.0,
                                          color: Color(0xFF002365),
                                        )
                                    ),
                                    TextSpan(text: '\n[Party List]',
                                        style: TextStyle(
                                          fontFamily: 'Playfair Display',
                                          fontStyle: FontStyle.italic,
                                          fontSize: 15.0,
                                          color: Color(0x80002365),
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        MyRadioButton(
                          isSelected: selectedPresident == 'Candidate 2',
                          onSelect: () {
                            setState(() {
                              selectedPresident = 'Candidate 2';
                              updateSelection(selectedPresident);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  // Candidate 3
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('lib/assets/lisa.jpg'),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(text: 'Candidate 3',
                                        style: TextStyle(
                                          fontFamily: 'Playfair Display',
                                          fontSize: 15.0,
                                          color: Color(0xFF002365),
                                        )
                                    ),
                                    TextSpan(text: '\n[Party List]',
                                        style: TextStyle(
                                          fontFamily: 'Playfair Display',
                                          fontStyle: FontStyle.italic,
                                          fontSize: 15.0,
                                          color: Color(0x80002365),
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        MyRadioButton(
                          isSelected: selectedPresident == 'Candidate 3',
                          onSelect: () {
                            setState(() {
                              selectedPresident = 'Candidate 3';
                              updateSelection(selectedPresident);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        'Vice President Internal',
                        style: TextStyle(
                          fontFamily: 'Playfair Display',
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Color(0xFF002365),
                        )
                    ),
                  ),
                  // Candidate 1
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('lib/assets/kar.jpg'),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(text: 'Candidate 1',
                                        style: TextStyle(
                                          fontFamily: 'Playfair Display',
                                          fontSize: 15.0,
                                          color: Color(0xFF002365),
                                        )
                                    ),
                                    TextSpan(text: '\n[Party List]',
                                        style: TextStyle(
                                          fontFamily: 'Playfair Display',
                                          fontStyle: FontStyle.italic,
                                          fontSize: 15.0,
                                          color: Color(0x80002365),
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        MyRadioButton(
                          isSelected: selectedVicePresident == 'Candidate 1',
                          onSelect: () {
                            setState(() {
                              selectedVicePresident = 'Candidate 1';
                              updateSelection(selectedVicePresident);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  // Candidate 2
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('lib/assets/irene.jpg'),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(text: 'Candidate 2',
                                        style: TextStyle(
                                          fontFamily: 'Playfair Display',
                                          fontSize: 15.0,
                                          color: Color(0xFF002365),
                                        )
                                    ),
                                    TextSpan(text: '\n[Party List]',
                                        style: TextStyle(
                                          fontFamily: 'Playfair Display',
                                          fontStyle: FontStyle.italic,
                                          fontSize: 15.0,
                                          color: Color(0x80002365),
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        MyRadioButton(
                          isSelected: selectedVicePresident == 'Candidate 2',
                          onSelect: () {
                            setState(() {
                              selectedVicePresident = 'Candidate 2';
                              updateSelection(selectedVicePresident);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  // Candidate 3
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('lib/assets/jihyo.jpg'),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(text: 'Candidate 3',
                                        style: TextStyle(
                                          fontFamily: 'Playfair Display',
                                          fontSize: 15.0,
                                          color: Color(0xFF002365),
                                        )
                                    ),
                                    TextSpan(text: '\n[Party List]',
                                        style: TextStyle(
                                          fontFamily: 'Playfair Display',
                                          fontStyle: FontStyle.italic,
                                          fontSize: 15.0,
                                          color: Color(0x80002365),
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        MyRadioButton(
                          isSelected: selectedVicePresident == 'Candidate 3',
                          onSelect: () {
                            setState(() {
                              selectedVicePresident = 'Candidate 3';
                              updateSelection(selectedVicePresident);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        'Vice President External',
                        style: TextStyle(
                          fontFamily: 'Playfair Display',
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Color(0xFF002365),
                        )
                    ),
                  ),
                  // Candidate 1
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('lib/assets/kirk.jpg'),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(text: 'Candidate 1',
                                        style: TextStyle(
                                          fontFamily: 'Playfair Display',
                                          fontSize: 15.0,
                                          color: Color(0xFF002365),
                                        )
                                    ),
                                    TextSpan(text: '\n[Party List]',
                                        style: TextStyle(
                                          fontFamily: 'Playfair Display',
                                          fontStyle: FontStyle.italic,
                                          fontSize: 15.0,
                                          color: Color(0x80002365),
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        MyRadioButton(
                          isSelected: selectedVicePresidentExt == 'Candidate 1',
                          onSelect: () {
                            setState(() {
                              selectedVicePresidentExt = 'Candidate 1';
                              updateSelection(selectedVicePresidentExt);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  // Candidate 2
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('lib/assets/vic.jpg'),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(text: 'Candidate 2',
                                        style: TextStyle(
                                          fontFamily: 'Playfair Display',
                                          fontSize: 15.0,
                                          color: Color(0xFF002365),
                                        )
                                    ),
                                    TextSpan(text: '\n[Party List]',
                                        style: TextStyle(
                                          fontFamily: 'Playfair Display',
                                          fontStyle: FontStyle.italic,
                                          fontSize: 15.0,
                                          color: Color(0x80002365),
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        MyRadioButton(
                          isSelected: selectedVicePresidentExt == 'Candidate 2',
                          onSelect: () {
                            setState(() {
                              selectedVicePresidentExt = 'Candidate 2';
                              updateSelection(selectedVicePresidentExt);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  // Candidate 3
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('lib/assets/ken.jpg'),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(text: 'Candidate 3',
                                        style: TextStyle(
                                          fontFamily: 'Playfair Display',
                                          fontSize: 15.0,
                                          color: Color(0xFF002365),
                                        )
                                    ),
                                    TextSpan(text: '\n[Party List]',
                                        style: TextStyle(
                                          fontFamily: 'Playfair Display',
                                          fontStyle: FontStyle.italic,
                                          fontSize: 15.0,
                                          color: Color(0x80002365),
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        MyRadioButton(
                          isSelected: selectedVicePresidentExt == 'Candidate 3',
                          onSelect: () {
                            setState(() {
                              selectedVicePresidentExt = 'Candidate 3';
                              updateSelection(selectedVicePresidentExt);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        'Secretary',
                        style: TextStyle(
                          fontFamily: 'Playfair Display',
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Color(0xFF002365),
                        )
                    ),
                  ),
                  // Candidate 1
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('lib/assets/djp.jpg'),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(text: 'Candidate 1',
                                        style: TextStyle(
                                          fontFamily: 'Playfair Display',
                                          fontSize: 15.0,
                                          color: Color(0xFF002365),
                                        )
                                    ),
                                    TextSpan(text: '\n[Party List]',
                                        style: TextStyle(
                                          fontFamily: 'Playfair Display',
                                          fontStyle: FontStyle.italic,
                                          fontSize: 15.0,
                                          color: Color(0x80002365),
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        MyRadioButton(
                          isSelected: selectedSecretary == 'Candidate 1',
                          onSelect: () {
                            setState(() {
                              selectedSecretary = 'Candidate 1';
                              updateSelection(selectedSecretary);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  // Candidate 2
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('lib/assets/eng.jpg'),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(text: 'Candidate 2',
                                        style: TextStyle(
                                          fontFamily: 'Playfair Display',
                                          fontSize: 15.0,
                                          color: Color(0xFF002365),
                                        )
                                    ),
                                    TextSpan(text: '\n[Party List]',
                                        style: TextStyle(
                                          fontFamily: 'Playfair Display',
                                          fontStyle: FontStyle.italic,
                                          fontSize: 15.0,
                                          color: Color(0x80002365),
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        MyRadioButton(
                          isSelected: selectedSecretary == 'Candidate 2',
                          onSelect: () {
                            setState(() {
                              selectedSecretary = 'Candidate 2';
                              updateSelection(selectedSecretary);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  // Candidate 3
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('lib/assets/paulkle.jpg'),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(text: 'Candidate 3',
                                        style: TextStyle(
                                          fontFamily: 'Playfair Display',
                                          fontSize: 15.0,
                                          color: Color(0xFF002365),
                                        )
                                    ),
                                    TextSpan(text: '\n[Party List]',
                                        style: TextStyle(
                                          fontFamily: 'Playfair Display',
                                          fontStyle: FontStyle.italic,
                                          fontSize: 15.0,
                                          color: Color(0x80002365),
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        MyRadioButton(
                          isSelected: selectedSecretary == 'Candidate 3',
                          onSelect: () {
                            setState(() {
                              selectedSecretary = 'Candidate 3';
                              updateSelection(selectedSecretary);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        'Auditor',
                        style: TextStyle(
                          fontFamily: 'Playfair Display',
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Color(0xFF002365),
                        )
                    ),
                  ),
                  // Candidate 1
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('lib/assets/char.jpg'),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(text: 'Candidate 1',
                                        style: TextStyle(
                                          fontFamily: 'Playfair Display',
                                          fontSize: 15.0,
                                          color: Color(0xFF002365),
                                        )
                                    ),
                                    TextSpan(text: '\n[Party List]',
                                        style: TextStyle(
                                          fontFamily: 'Playfair Display',
                                          fontStyle: FontStyle.italic,
                                          fontSize: 15.0,
                                          color: Color(0x80002365),
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        MyRadioButton(
                          isSelected: selectedAuditor == 'Candidate 1',
                          onSelect: () {
                            setState(() {
                              selectedAuditor = 'Candidate 1';
                              updateSelection(selectedAuditor);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  // Candidate 2
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('lib/assets/jake.jpg'),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(text: 'Candidate 2',
                                        style: TextStyle(
                                          fontFamily: 'Playfair Display',
                                          fontSize: 15.0,
                                          color: Color(0xFF002365),
                                        )
                                    ),
                                    TextSpan(text: '\n[Party List]',
                                        style: TextStyle(
                                          fontFamily: 'Playfair Display',
                                          fontStyle: FontStyle.italic,
                                          fontSize: 15.0,
                                          color: Color(0x80002365),
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        MyRadioButton(
                          isSelected: selectedAuditor == 'Candidate 2',
                          onSelect: () {
                            setState(() {
                              selectedAuditor = 'Candidate 2';
                              updateSelection(selectedAuditor);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  // Candidate 3
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('lib/assets/aiza.jpg'),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(text: 'Candidate 3',
                                        style: TextStyle(
                                          fontFamily: 'Playfair Display',
                                          fontSize: 15.0,
                                          color: Color(0xFF002365),
                                        )
                                    ),
                                    TextSpan(text: '\n[Party List]',
                                        style: TextStyle(
                                          fontFamily: 'Playfair Display',
                                          fontStyle: FontStyle.italic,
                                          fontSize: 15.0,
                                          color: Color(0x80002365),
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        MyRadioButton(
                          isSelected: selectedAuditor == 'Candidate 3',
                          onSelect: () {
                            setState(() {
                              selectedAuditor = 'Candidate 3';
                              updateSelection(selectedAuditor);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        'Treasurer',
                        style: TextStyle(
                          fontFamily: 'Playfair Display',
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Color(0xFF002365),
                        )
                    ),
                  ),
                  // Candidate 1
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('lib/assets/mikha.jpg'),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(text: 'Candidate 1',
                                        style: TextStyle(
                                          fontFamily: 'Playfair Display',
                                          fontSize: 15.0,
                                          color: Color(0xFF002365),
                                        )
                                    ),
                                    TextSpan(text: '\n[Party List]',
                                        style: TextStyle(
                                          fontFamily: 'Playfair Display',
                                          fontStyle: FontStyle.italic,
                                          fontSize: 15.0,
                                          color: Color(0x80002365),
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        MyRadioButton(
                          isSelected: selectedTreasurer == 'Candidate 1',
                          onSelect: () {
                            setState(() {
                              selectedTreasurer = 'Candidate 1';
                              updateSelection(selectedTreasurer);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  // Candidate 2
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('lib/assets/maloi.jpg'),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(text: 'Candidate 2',
                                        style: TextStyle(
                                          fontFamily: 'Playfair Display',
                                          fontSize: 15.0,
                                          color: Color(0xFF002365),
                                        )
                                    ),
                                    TextSpan(text: '\n[Party List]',
                                        style: TextStyle(
                                          fontFamily: 'Playfair Display',
                                          fontStyle: FontStyle.italic,
                                          fontSize: 15.0,
                                          color: Color(0x80002365),
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        MyRadioButton(
                          isSelected: selectedTreasurer == 'Candidate 2',
                          onSelect: () {
                            setState(() {
                              selectedTreasurer = 'Candidate 2';
                              updateSelection(selectedTreasurer);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  // Candidate 3
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('lib/assets/cole.jpg'),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(text: 'Candidate 3',
                                        style: TextStyle(
                                          fontFamily: 'Playfair Display',
                                          fontSize: 15.0,
                                          color: Color(0xFF002365),
                                        )
                                    ),
                                    TextSpan(text: '\n[Party List]',
                                        style: TextStyle(
                                          fontFamily: 'Playfair Display',
                                          fontStyle: FontStyle.italic,
                                          fontSize: 15.0,
                                          color: Color(0x80002365),
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        MyRadioButton(
                          isSelected: selectedTreasurer == 'Candidate 3',
                          onSelect: () {
                            setState(() {
                              selectedTreasurer = 'Candidate 3';
                              updateSelection(selectedTreasurer);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        'P.R.O',
                        style: TextStyle(
                          fontFamily: 'Playfair Display',
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Color(0xFF002365),
                        )
                    ),
                  ),
                  // Candidate 1
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('lib/assets/diw.jpeg'),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(text: 'Candidate 1',
                                        style: TextStyle(
                                          fontFamily: 'Playfair Display',
                                          fontSize: 15.0,
                                          color: Color(0xFF002365),
                                        )
                                    ),
                                    TextSpan(text: '\n[Party List]',
                                        style: TextStyle(
                                          fontFamily: 'Playfair Display',
                                          fontStyle: FontStyle.italic,
                                          fontSize: 15.0,
                                          color: Color(0x80002365),
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        MyRadioButton(
                          isSelected: selectedPRO == 'Candidate 1',
                          onSelect: () {
                            setState(() {
                              selectedPRO = 'Candidate 1';
                              updateSelection(selectedPRO);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  // Candidate 2
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('lib/assets/diw.jpeg'),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(text: 'Candidate 2',
                                        style: TextStyle(
                                          fontFamily: 'Playfair Display',
                                          fontSize: 15.0,
                                          color: Color(0xFF002365),
                                        )
                                    ),
                                    TextSpan(text: '\n[Party List]',
                                        style: TextStyle(
                                          fontFamily: 'Playfair Display',
                                          fontStyle: FontStyle.italic,
                                          fontSize: 15.0,
                                          color: Color(0x80002365),
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        MyRadioButton(
                          isSelected: selectedPRO == 'Candidate 2',
                          onSelect: () {
                            setState(() {
                              selectedPRO = 'Candidate 2';
                              updateSelection(selectedPRO);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  // Candidate 3
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('lib/assets/otl.jpg'),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(text: 'Candidate 3',
                                        style: TextStyle(
                                          fontFamily: 'Playfair Display',
                                          fontSize: 15.0,
                                          color: Color(0xFF002365),
                                        )
                                    ),
                                    TextSpan(text: '\n[Party List]',
                                        style: TextStyle(
                                          fontFamily: 'Playfair Display',
                                          fontStyle: FontStyle.italic,
                                          fontSize: 15.0,
                                          color: Color(0x80002365),
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        MyRadioButton(
                          isSelected: selectedPRO == 'Candidate 3',
                          onSelect: () {
                            setState(() {
                              selectedPRO = 'Candidate 3';
                              updateSelection(selectedPRO);
                            });
                          },
                        ),
                      ],
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Voted: ${count}/7',
                          style: TextStyle(fontSize: 24),
                        ),
                        Container(
                          width: 100, // adjust the width as you need
                          height: 50, // adjust the height as you need
                          child: ElevatedButton(
                            onPressed: () {
                              // Submit the votes
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Vote Submitted'),
                                    content: Text('Thank you for voting!'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('OK'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text('Submit'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.yellow,
                              foregroundColor: Colors.black,
                              shape: StadiumBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyRadioButton extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onSelect;

  const MyRadioButton({
    Key? key,
    required this.isSelected,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelect,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.transparent : Colors.transparent,
          border: Border.all(
            color: isSelected ? Colors.yellow : Color(0xFF002365),
            width: 2,
          ),
        ),
        child: isSelected
            ? Icon(Icons.check, color: Colors.yellow)
            : null,
      ),
    );
  }
}

