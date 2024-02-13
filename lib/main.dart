import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travelplanner/Featuers/Models/UserModel.dart';
import 'package:travelplanner/Featuers/Screens/Auth/login.dart';
import 'package:travelplanner/Featuers/Screens/Home/MainHome.dart';
import 'package:travelplanner/Featuers/Screens/SpecialityPage/SpecialityPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:travelplanner/Utils/globalvar.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  Future<UserModel?> fetchUserData() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      try {
        DocumentSnapshot<Map<String, dynamic>> userSnapshot = await gfirestore
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();

        // Create a UserModel instance from the retrieved data
        UserModel currentUser = UserModel.fromMap(
          userSnapshot.data() as Map<String, dynamic>,
          FirebaseAuth.instance.currentUser!.uid,
        );
        return currentUser;
      } catch (e) {
        print('Error fetching user data: $e');
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel?>(
      future: fetchUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loader while waiting for the data
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          // Handle error
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: Text('Error: ${snapshot.error}'),
              ),
            ),
          );
        } else if (snapshot.data != null) {
          // User is logged in and data is available
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: MainScreen(),
          );
        } else {
          // User is not logged in or data couldn't be fetched
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: StartingScreen(),
          );
        }
      },
    );
  }
}

class StartingScreen extends StatelessWidget {
  const StartingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF6FBDC6), // Background color
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'MediConnect',
                style: TextStyle(
                  fontSize: 50.0,
                  fontFamily: 'Rockwell', // Set the font to Rockwell
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Set text color to white
                ),
              ),
              SizedBox(height: 20.0),
              Image.asset(
                'images/hospital.png', // Replace with the actual image path
                width: 300.0, // Adjust the width as needed
                height: 300.0, // Adjust the height as needed
              ),
              SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white, // Set button background color to white
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(30.0), // Set button border radius
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                      fontWeight:
                          FontWeight.bold, // Set button text color to black
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
