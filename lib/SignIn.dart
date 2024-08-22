import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pawsupunf/SignUp.dart';
import 'package:pawsupunf/Home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paws Up Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            if (snapshot.data != null) {
              return Home();
            } else {
              return SignIn();
            }
          }
        },
      ),
      routes: {
        '/SignUp': (context) => SignUp(),
        '/Home': (context) => Home(),
      },
    );
  }
}

class SignIn extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  FocusNode _focusNodeEmail = FocusNode();
  FocusNode _focusNodePassword = FocusNode();
  bool _rememberMe = false;
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadUserCredentials();
  }

  Future _loadUserCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');
    if (email != null && password != null) {
      setState(() {
        _emailController.text = email;
        _passwordController.text = password;
        _rememberMe = true;
      });
    }
  }

  Future _signInWithEmailAndPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        if (userCredential.user != null) {
          if (!userCredential.user!.emailVerified) {
            await userCredential.user!.sendEmailVerification();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Please verify your email before signing in. A verification link has been sent to your email.'),
                backgroundColor: Colors.red,
              ),
            );
            FirebaseAuth.instance.signOut();
          } else {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            if (_rememberMe) {
              await prefs.setString('email', _emailController.text.trim());
              await prefs.setString('password', _passwordController.text.trim());
            } else {
              await prefs.remove('email');
              await prefs.remove('password');
            }
            Navigator.of(context).pushNamed('/Home');
          }
        }
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        if (e.code == 'user-not-found') {
          errorMessage = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'The password is invalid.';
        } else if (e.code == 'too-many-requests') {
          errorMessage = 'Too many failed login attempts. Please try again later.';
        } else {
          errorMessage = e.message ?? 'An error occurred';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future _resetPassword() async {
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter your email to reset password.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    try {
      // Check if the user exists in the 'users' collection
      final userQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: _emailController.text.trim())
          .get();

      if (userQuery.docs.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No user found with this email in our records.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // If the user exists, proceed with password reset
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password reset email sent.'),
          backgroundColor: Colors.green,
        ),
      );
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'An error occurred'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('lib/assets/finlog.jpg', width: 350.0, height: 350.0),
                  TextFormField(
                    focusNode: _focusNodeEmail,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Colors.amber,
                    decoration: InputDecoration(
                      hintText: 'Enter School Email',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(color: Color(0xFF002363)),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      } else if (!value.endsWith('@students.nu-dasma.edu.ph')) {
                        return 'Email should end with @students.nu-dasma.edu.ph';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    focusNode: _focusNodePassword,
                    controller: _passwordController,
                    obscureText: _obscureText,
                    cursorColor: Colors.amber,
                    decoration: InputDecoration(
                      hintText: 'Enter Password',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(color: Color(0xFF002363)),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: _rememberMe,
                            onChanged: (bool? newValue) {
                              setState(() {
                                _rememberMe = newValue!;
                              });
                            },
                            activeColor: Color(0xFF002363),
                          ),
                          Text('Remember me'),
                        ],
                      ),
                      GestureDetector(
                        onTap: _resetPassword,
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Color(0xFF002363),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  _isLoading
                      ? CircularProgressIndicator(color: Color(0xFF002363))
                      : Container(
                    width: 315,
                    height: 59,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF002363),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                      ),
                      onPressed: _signInWithEmailAndPassword,
                      child: Text('SIGN IN', style: TextStyle(fontSize: 20)),
                    ),
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Text("Don't have an account? "),
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: [
                              TextSpan(
                                text: 'Register Here',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontStyle: FontStyle.italic,
                                  fontFamily: 'Inter',
                                  fontSize: 12.0,
                                  color: Color(0xFF002363),
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).pushNamed('/SignUp');

                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
