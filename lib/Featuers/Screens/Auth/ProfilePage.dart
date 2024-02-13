import 'package:flutter/material.dart';
import 'package:travelplanner/Featuers/Models/UserModel.dart';

class ProfilePage extends StatefulWidget {
  UserModel userdata;
  ProfilePage({super.key, required this.userdata});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.userdata.name),
      ),
    );
  }
}
