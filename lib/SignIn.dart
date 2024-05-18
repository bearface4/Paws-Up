  import 'package:flutter/gestures.dart';
  import 'package:flutter/material.dart';
  import 'package:firebase_core/firebase_core.dart';
  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Added for secure storage
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
        home: SignIn(),
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
    final storage = FlutterSecureStorage(); // Instance of FlutterSecureStorage

    @override
    void initState() {
      super.initState();
      _loadUserCredentials();
    }

    Future<void> _loadUserCredentials() async {
      String? email = await storage.read(key: 'email');
      String? password = await storage.read(key: 'password');
      if (email != null && password != null) {
        setState(() {
          _emailController.text = email;
          _passwordController.text = password;
          _rememberMe = true;
        });
      }
    }

    Future<void> _signInWithEmailAndPassword() async {
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
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please verify your email before signing in.'),
                    backgroundColor: Colors.red,
                  )
              );
              FirebaseAuth.instance.signOut();
            } else {
              if (_rememberMe) {
                await storage.write(key: 'email', value: _emailController.text.trim());
                await storage.write(key: 'password', value: _passwordController.text.trim());
              } else {
                await storage.delete(key: 'email');
                await storage.delete(key: 'password');
              }
              Navigator.of(context).pushNamed('/Home');
            }
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == 'wrong-password') {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Wrong password provided for that user.'),
                  backgroundColor: Colors.red,
                )
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(e.message ?? 'An error occurred'),
                  backgroundColor: Colors.red,
                )
            );
          }
        } finally {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('lib/assets/finlog.jpg', width: 350.0, height: 350.0),
                  TextFormField(
                    focusNode: _focusNodeEmail,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
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
                  SizedBox(height: 24),
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
                  SizedBox(height: 24),
                  _isLoading
                      ? CircularProgressIndicator(color: Color(0xFF002363))
                      : Container(
                    width: 315,
                    height: 59,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF002363),
                        onPrimary: Colors.white,
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
                            children: <TextSpan>[
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
      );
    }
  }
