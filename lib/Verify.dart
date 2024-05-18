import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'SignIn.dart'; // Import SignIn.dart file

class Verify extends StatefulWidget {
  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => SignIn()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 300,
              height: 300,
              child: Lottie.network(
                'https://lottie.host/27c0c44c-df30-4f6c-9c73-41f106f5fc6c/NtJSYsG3Ly.json',
              ),
            ),
            SizedBox(height: 20), // Add some space between lottie and text
            Text(
              'We\'ve sent a verification mail to your inbox. Please check it to verify your account.',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Playfair Display',
                fontWeight: FontWeight.w200,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
