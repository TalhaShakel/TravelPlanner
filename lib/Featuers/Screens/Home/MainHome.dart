import 'package:flutter/material.dart';
import 'package:travelplanner/Featuers/Screens/Home/HomeScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // Define your destinations
  final List<Map<String, dynamic>> destinations = [
    {'title': 'Home', 'icon': Icons.home},
    {'title': 'Reservation', 'icon': Icons.edit_calendar_outlined},
    {'title': 'Profile', 'icon': Icons.person_pin},
    {'title': 'About', 'icon': Icons.info_outline_rounded},
  ];

  // Pages corresponding to each destination
  final List<Widget> pages = [
    HomeScreen(),
    ReservationScreen(),
    ProfileScreen(),
    AboutScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: destinations.map((destination) {
          return BottomNavigationBarItem(
            icon: Icon(destination['icon']),
            label: destination['title'],
          );
        }).toList(),
        backgroundColor: Colors.black54, // Set the background color to grey
        selectedItemColor: Colors.black, // Set the selected item color to black
        unselectedItemColor: Colors.black54,
      ),
    );
  }
}

class ReservationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Reservation Screen'),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Profile Screen'),
    );
  }
}

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('About Screen'),
    );
  }
}
