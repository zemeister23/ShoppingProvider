import 'package:flutter/material.dart';
import 'package:hive_app_example/model/user_model.dart';
import 'package:hive_app_example/service/user_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox('usersBox');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Hive.box('usersBox').clear();
    ServiceUser().getUsers().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: Center(
          child: ValueListenableBuilder(
            valueListenable: Hive.box('usersBox').listenable(),
            builder: (context, Box box, widget) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  UserModel a = box.get(index);
                  return Text((a.name.toString()));
                },
                itemCount: box.length,
              );
            },
          ),
        ),
      ),
    );
  }
}
