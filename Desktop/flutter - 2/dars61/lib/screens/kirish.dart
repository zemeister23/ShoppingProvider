import '../constants/import_packages.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key? key}) : super(key: key);
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AnimationController? _animationController;

  final _authUser = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      lowerBound: 1,
      upperBound: 160,
    );

    _animationController!
        .forward(from: 1)
        .then((value) => _animationController!.reverse(from: 160))
        .then((value) => _animationController!.forward());
    _animationController!.addListener(() {
      setState(() {});
      debugPrint(_animationController!.value.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Expanded(
                  child: SvgPicture.asset(
                    'assets/icon.svg',
                    height: _animationController!.value,
                    alignment: Alignment.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Telegrogram\nChat",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.08),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                          TextFormField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.green),
                                child: const Text("Sign In"),
                                onPressed: _signInFireStore,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.brown),
                                child: const Text("Sign Up"),
                                onPressed: _signUpFireStore,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _signInFireStore() async {
    await _authUser.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );
    if (_authUser.currentUser != null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ChatPage(userEmail: _authUser.currentUser!.email),
          ),
          (route) => false);
    }
  }

  _signUpFireStore() async {
    await _authUser.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );
    if (_authUser.currentUser != null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ChatPage(userEmail: _authUser.currentUser!.email),
          ),
          (route) => false);
    }
  }
}
