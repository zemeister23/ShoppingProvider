import 'package:dars67/screens/home/my_home_page.dart';
import 'package:dars67/services/api_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late ApiService _apiService;

  late List<User> users;

  @override
  void initState() {
    super.initState();
    _apiService = GetUsers();
    _apiService.fetchUser().then((v) => users = v);
    _apiService.isLogin().then((value) {
      if (value == 'loggedIn') {
        pushToHomePage();
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButton: getUserFloat(),
      body: Center(child: textFormField()),
    );
  }

  Padding textFormField() {
    return Padding(
      child: TextFormField(
        key: _apiService.usernameKey,
        controller: _apiService.usernameController,
        validator: (v) {
          if (v!.isEmpty) {
            return "Username Kiritilishi Shart !";
          }
        },
        decoration: const InputDecoration(
          hintText: "Username...",
          border: OutlineInputBorder(),
        ),
      ),
      padding: const EdgeInsets.all(12.0),
    );
  }

  Widget getUserFloat() {
    return FloatingActionButton(
      child: const Icon(Icons.arrow_forward_ios_outlined),
      onPressed: () async {
        if (_apiService.usernameKey.currentState!.validate()) {
          if (findByUsername()) {
            await _apiService.storage
                .write(key: 'judaMaxfiySoz', value: 'loggedIn');
            pushToHomePage();
          } else {
            snackBarForUserNotFound();
          }
        }
      },
    );
  }

  void pushToHomePage() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ),
        (route) => false);
  }

  bool findByUsername() {
    for (User user in users) {
      if (user.username == _apiService.usernameController.text) {
        return true;
      }
    }
    return false;
  }

  snackBarForUserNotFound() {
    return ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text(
          "Username topilmadi !",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
