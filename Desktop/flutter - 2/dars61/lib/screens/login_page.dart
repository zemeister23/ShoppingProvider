import '../constants/import_packages.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Login",
          style: TextStyle(fontSize: 25.0),
        ),
      ),
    );
  }
}