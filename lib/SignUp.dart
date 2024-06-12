import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pawsupunf/Verify.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isObscurePassword = true;
  bool _isObscureConfirmPassword = true;
  bool _isRegistering = false;
  bool _isPasswordMatched = true;
  String? _selectedSchool;
  String? _selectedDepartment;
  String? _selectedSection;
  final Map<String, List<String>> _schoolAndDepartments = {
    'SECA': ['BS-CPE', 'BS-ARCH', 'BS-CE', 'BS CS-ML', 'BS IT-MWA'],
    'SASE': ['BS-PSY', 'BS-PED', 'AB-COMM'],
    'SBMA': ['BS-Accountancy', 'BS BA-MktgMgt', 'BS BA-FinMgt', 'BS-MA', 'BS-HM','BS-TM','MM'],
    'SHS': ['STEM', 'ABM', 'HUMMS'],
  };
  final Map<String, List<String>> _departmentAndSections = {
    'BS-CPE': ['CPE211', 'CPE221', 'CPE222', 'CPE231', 'CPE232', 'CPE233'],
    'BS-ARCH': ['ARC221', 'ARC222', 'ARC223', 'ARC224', 'ARC225', 'ARC226', 'ARC221A', 'ARC222A', 'ARC221P', 'ARC222P', 'ARC223P', 'ARC224P', 'ARC231', 'ARC232', 'ARC233', 'ARC234', 'ARC235', 'ARC231A', 'ARC232A', 'ARC233A', 'ARC231P', 'ARC232P', 'ARC233P', 'ARC234P'],
    'BS-CE': ['CIV211', 'CIV212', 'CIV213', 'CIV211P', 'CIV212P', 'CIV221', 'CIV222', 'CIV223', 'CIV224', 'CIV225', 'CIV226', 'CIV221P', 'CIV222P', 'CIV223P', 'CIV224P', 'CIV231', 'CIV232', 'CIV233', 'CIV234', 'CIV235', 'CIV236', 'CIV231P', 'CIV232P', 'CIV233P'],
    'BS CS-ML': ['COM221', 'COM231', 'COM232', 'COM233'],
    'BS IT-MWA': ['INF211', 'INF221', 'INF222', 'INF223', 'INF224', 'INF231', 'INF232', 'INF233', 'INF234', 'INF235', 'INF236'],
    'BS-PSY': ['PSY211', 'PSY221', 'PSY222', 'PSY223', 'PSY224', 'PSY225', 'PSY231', 'PSY232', 'PSY233', 'PSY234', 'PSY235', 'PSY236', 'PSY237','PSY238'],
    'BS-PED': ['BPE231'],
    'AB-COMM': ['ABC221', 'ABC231'],
    'BS-Accountancy': ['ACT211', 'ACT221', 'ACT222', 'ACT223', 'ACT224', 'ACT225', 'ACT226', 'ACT227', 'ACT228', 'ACT231', 'ACT232', 'ACT234', 'ACT235', 'ACT236', 'ACT237', 'ACT238'],
    'BS BA-MktgMgt': ['MAR211', 'MAR221', 'MAR222', 'MAR231', 'MAR232', 'MAR233', 'MAR234'],
    'BS BA-FinMgt': ['FIN211', 'FIN221', 'FIN222', 'FIN231', 'FIN232'],
    'BS-MA': ['MGA211', 'MGA221', 'MGA222'],
    'BS-HM': ['HMA221', 'HMA222', 'HMA223', 'HMA224', 'HMA221-1', 'HMA222-2', 'HMA-225-P', 'HMA231', 'HMA232', 'HMA233', 'HMA234', 'HMA235'],
    'BS-TM': ['TOU211', 'TOU212', 'TOU213P', 'TOU214P', 'TOU222', 'TOU223', 'TOU224', 'TOU225', 'TOU221-1', 'TOU221-2', 'TOU222-1', 'TOU222-2', 'TOU223-1', 'TOU223-2', 'TOU224-1', 'TOU224-2', 'TOU231', 'TOU232', 'TOU233', 'TOU234', 'TOU235', 'TOU236', 'TOU237'],
    'MM': ['MIM231'],
    'STEM': ['2301', '2302', '2303', '2304', '2305', '2306', '2201', '2202', '2203', '2204', '2205', '2206'],
    'ABM': ['2301', '2302', '2201', '2202'],
    'HUMMS': ['2301', '2302', '2201'],
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
        theme: ThemeData(
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.amber, // Set the cursor color to gold
          ),
        ),
        home: Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Register',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 50,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF002363),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF002363),
                        fontFamily: 'Inter',
                      ),
                      children: [
                        TextSpan(text: 'Create your account to access '),
                        TextSpan(
                          text: 'PAWS UP.',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32),
                  buildTextFormField(_firstNameController, 'First Name'),
                  SizedBox(height: 16),
                  buildTextFormField(_lastNameController, 'Last Name'),
                  SizedBox(height: 16),
                  buildTextFormField(_studentIdController, 'Student ID'),
                  SizedBox(height: 16),
                  buildTextFormField(_emailController, 'School Email'),
                  SizedBox(height: 16),
                  buildDropdownButtonFormField('School', _schoolAndDepartments.keys.toList()),
                  SizedBox(height: 16),
                  buildDropdownButtonFormField('Department', _selectedSchool == null ? [] : _schoolAndDepartments[_selectedSchool]!),
                  SizedBox(height: 16),
                  buildDropdownButtonFormField('Section', _selectedDepartment == null ? [] : _departmentAndSections[_selectedDepartment]!),
                  SizedBox(height: 16),
                  buildPasswordFormField(_passwordController, 'Password', _isObscurePassword),
                  SizedBox(height: 16),
                  buildPasswordFormField(_confirmPasswordController, 'Confirm Password', _isObscureConfirmPassword),
                  SizedBox(height: 32),
                  _isRegistering
                      ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Color(0xFF002363)),
                    ),
                  )
                      : Container(
                    width: 254.0,
                    child: ElevatedButton(
                      child: Text('Register Account'),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isRegistering = true;
                          });
                          await _registerUser();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF002363),
                        foregroundColor: Colors.white,
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
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

  TextFormField buildTextFormField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      maxLines: 1,
      decoration: InputDecoration(
        labelText: label,
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF002363)),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $label';
        }
        if (label == 'First Name' || label == 'Last Name') {
          final RegExp nameRegExp = RegExp(r'^[A-Z][a-z]+$');
          if (!nameRegExp.hasMatch(value)) {
            return 'Use proper name format';
          }
        } else if (label == 'Student ID') {
          final RegExp studentIdRegExp = RegExp(r'^\d{4}-\d{6}$');
          if (!studentIdRegExp.hasMatch(value)) {
            return 'Student ID format should be YYYY-123456';
          }
        } else if (label == 'School Email') {
          final RegExp emailRegExp = RegExp(r'^\S+@students\.nu-dasma\.edu\.ph$');
          if (!emailRegExp.hasMatch(value)) {
            return 'Should end with @students.nu-dasma.edu.ph';
          }
        }
        return null;
      },
    );
  }

  DropdownButtonFormField<String> buildDropdownButtonFormField(String label, List<String> items) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF002363)),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      value: label == 'School' ? _selectedSchool : (label == 'Department' ? _selectedDepartment : _selectedSection),
      items: items.map((item) {
        return DropdownMenuItem<String>(
          child: Text(item),
          value: item,
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          if (label == 'School') {
            _selectedSchool = newValue;
            _selectedDepartment = null;
            _selectedSection = null;
          } else if (label == 'Department') {
            _selectedDepartment = newValue;
            _selectedSection = _departmentAndSections[newValue]!.isNotEmpty ? _departmentAndSections[newValue]!.first : null;
          } else {
            _selectedSection = newValue;
          }
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select your $label';
        }
        return null;
      },
    );
  }

  TextFormField buildPasswordFormField(TextEditingController controller, String label, bool isObscure) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      maxLines: 1,
      decoration: InputDecoration(
        labelText: label,
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF002363)),
          borderRadius: BorderRadius.circular(15),
        ),
        suffixIcon: IconButton(
          icon: Icon(isObscure ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              if (label == 'Password') {
                _isObscurePassword = !_isObscurePassword;
              } else {
                _isObscureConfirmPassword = !_isObscureConfirmPassword;
              }
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a password';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters long';
        }
        return null;
      },
    );
  }

  Future<void> _registerUser() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _isPasswordMatched = false;
      });
      _formKey.currentState!.validate();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('The passwords do not match.'),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        _isRegistering = false;
      });
      return;
    } else {
      setState(() {
        _isPasswordMatched = true;
      });
      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
        await userCredential.user!.sendEmailVerification();
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'firstName': _firstNameController.text,
          'lastName': _lastNameController.text,
          'studentId': _studentIdController.text,
          'email': _emailController.text,
          'school': _selectedSchool,
          'department': _selectedDepartment,
          'section': _selectedSection,
          'timestamp': FieldValue.serverTimestamp(),
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration successful!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => Verify()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('The email address is already in use by another account.'),
              backgroundColor: Colors.red,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Registration failed: ${e.message}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() {
          _isRegistering = false;
        });
      }
    }
  }
}
