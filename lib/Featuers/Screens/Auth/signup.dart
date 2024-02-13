import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travelplanner/Featuers/Screens/Auth/login.dart';

import '../../../main.dart';
import '../../Models/UserModel.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  GlobalKey<FormState> _key = GlobalKey();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _validate = false;

  String errorMessag = "";

  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF6FBDC6),
        height: double.maxFinite,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.clear),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StartingScreen()),
                        );
                      },
                    ),
                  ],
                ),
                Text(
                  'MediConnect',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Image.asset(
                  'images/login.png',
                  height: 150,
                  width: 150,
                ),
                SizedBox(height: 20),
                Text(
                  'Signup',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Form(
                  key: _key,
                  // autovalidateMode: ,
                  child: FormUI(_key),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget FormUI(key) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        TextFormField(
          controller: nameController,
          decoration: InputDecoration(
            hintText: 'Full Name',
            hintStyle: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: 20,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            contentPadding: const EdgeInsets.all(20),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your full name';
            }
            return null;
          },
          onSaved: (String? val) {
            nameController.text = val ?? '';
          },
        ),
        SizedBox(height: 15),
        TextFormField(
          controller: usernameController,
          decoration: InputDecoration(
            hintText: 'Username',
            hintStyle: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: 20,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            contentPadding: const EdgeInsets.all(20),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a username';
            }
            return null;
          },
          onSaved: (String? val) {
            usernameController.text = val ?? '';
          },
        ),
        SizedBox(height: 15),
        TextFormField(
          controller: emailController,
          decoration: InputDecoration(
            hintText: 'Email ID',
            hintStyle: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: 20,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            contentPadding: const EdgeInsets.all(20),
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            } else if (!RegExp(
                    r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
                .hasMatch(value)) {
              return 'Please enter a valid email address';
            }
            return null;
          },
          onSaved: (String? val) {
            emailController.text = val ?? '';
          },
        ),
        SizedBox(height: 15),
        TextFormField(
          controller: passwordController,
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          decoration: InputDecoration(
            hintText: 'Password',
            hintStyle: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: 20,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            contentPadding: const EdgeInsets.all(20),
          ),
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a password';
            } else if (value.length < 6) {
              return 'Password must be at least 6 characters long';
            }
            return null;
          },
          onSaved: (String? val) {
            passwordController.text = val ?? '';
          },
        ),
        SizedBox(height: 15),
        TextFormField(
          controller: phoneController,
          decoration: InputDecoration(
            hintText: 'Phone Number',
            hintStyle: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: 20,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            contentPadding: const EdgeInsets.all(20),
          ),
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your phone number';
            } else if (!RegExp(r"^[0-9]{10}$").hasMatch(value)) {
              return 'Please enter a valid 10-digit phone number';
            }
            return null;
          },
          onSaved: (String? val) {
            phoneController.text = val ?? '';
          },
        ),
        SizedBox(height: 15),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Colors.black,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                20.0,
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Text(
              'Signup',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          onPressed: () => _sendToServer(key),
        ),
      ],
    );
  }

  _sendToServer(key) async {
    if (key.currentState.validate()) {
      _key.currentState?.save();

      try {
        // String hashedPassword =
        //     sha256.convert(utf8.encode(password)).toString();

        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        print('Signup successful for user ID: ${userCredential.user?.uid}');

        UserModel newUser = UserModel(
          uid: userCredential.user!.uid,
          name: nameController.text.trim(),
          username: usernameController.text.trim(),
          email: emailController.text.trim(),
          phoneNumber: phoneController.text.trim(),
          hashedPassword: passwordController.text.trim(),
        );

        await _firestore
            .collection('users')
            .doc(newUser.uid)
            .set(newUser.toMap());

        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } catch (e) {
        print('Signup failed: $e');
        setState(() {
          errorMessage = 'Signup failed: $e';
        });
      }
    } else {
      setState(() {
        _validate = true;
      });
    }
  }
}
