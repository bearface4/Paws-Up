import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pawsupunf/Events.dart';
import 'package:pawsupunf/Home.dart';
import 'package:pawsupunf/Profile.dart';
import 'package:pawsupunf/SignIn.dart';
import 'package:pawsupunf/SignUp.dart';
import 'package:pawsupunf/Voting.dart';
import 'package:pawsupunf/VotingSheet.dart';
import 'package:pawsupunf/Verify.dart';
import 'package:pawsupunf/firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    home: SplashScreen(),
    routes: <String, WidgetBuilder>{
      '/SignIn': (BuildContext context) => SignIn(),
      '/SignUp': (context) => SignUp(),
      '/Home': (context) => Home(),
      '/Events': (context) => Events(),
      '/Voting': (context) => Voting(),
      '/Profile': (context) => Profile(),
      '/VotingSheet': (context) => VotingSheet(),
      '/Verify': (context) => Verify(),
    },
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () => Navigator.pushReplacementNamed(context, '/SignIn')); //Corrected route name
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('lib/assets/demolog.png'), // Ensure this asset path is correct
      ),
    );
  }
}