import 'package:dars67/screens/authentication/login_page.dart';
import 'package:dars67/services/api_service.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  String? username;
  MyHomePage({Key? key, this.username}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ApiService _apiService;

  @override
  void initState() {
    super.initState();
    _apiService = GetUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            onPressed: signOutAndDeleteCache,
          ),
        ],
      ),
      body: const Center(
        child: Text(
          "My Home Page",
        ),
      ),
    );
  }

  signOutAndDeleteCache() async {
    await _apiService.storage.delete(key: 'judaMaxfiySoz');
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
        (route) => false);
  }
}
