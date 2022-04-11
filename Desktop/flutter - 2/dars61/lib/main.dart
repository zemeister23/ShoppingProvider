import 'constants/import_packages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      routes: {
        "kirish": (context) =>  SignInPage(),
        "chat": (context) =>  ChatPage(),
        "imagepage": (context) =>  ImagePage(),
        "login": (context) => const LoginPage(),
      },
      initialRoute: "imagepage",
    );
  }
}
