import 'package:flutter/material.dart';
import 'package:hive_app/model/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HOME PAGE"),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("GET TO PAGE"),
          onPressed: () {
            workWithHive();
          },
        ),
      ),
    );
  }

// flutter packages pub run build_runner build
  workWithHive() async {
    User user1 = User()
      ..id = 6
      ..name = "Sherzod";

    Box<User> userBox = await Hive.openBox('userBox');
    // await userBox.clear();
    // await userBox.add(user1);

    print("Name: ${userBox.getAt(0)!.name}");
  }
}
