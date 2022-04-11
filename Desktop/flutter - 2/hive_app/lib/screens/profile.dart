import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  var data;
  ProfilePage({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
    );
  }
}
