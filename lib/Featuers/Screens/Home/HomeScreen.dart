// Define your destination screens
import 'package:flutter/material.dart';
import 'package:travelplanner/Utils/Colors.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarcolor,
        title: Text("data"),
        actions: [Icon(Icons.logout)],
      ),
    );
  }
}
