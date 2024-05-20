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
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';

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
    return FlutterSplashScreen.scale(
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white,
          Colors.blue,
        ],
      ),
      childWidget: SizedBox(
        height: 450,
        width: 450,
        child: Image.asset("lib/assets/log2.png"),
      ),
      duration: const Duration(milliseconds: 1500),
      animationDuration: const Duration(milliseconds: 1000),
      onAnimationEnd: () => debugPrint("On Scale End"),
      nextScreen: SignIn(),
    );
  }
}
