import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providers/core/constants/decoration_consts.dart';
import 'package:providers/provider/drop_provider.dart';
import 'package:providers/provider/sign_in_provider.dart';
import 'package:providers/provider/theme_mode_provider.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var _context = context.watch<SignInProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Theme Changer",
          style: ThemeData().textTheme.headline6!.copyWith(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Form(
              key: _context.formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      controller: _context.usernameController,
                      validator: (v) {
                        if (v!.length <= 3) return "ERROR USERNAME";
                      },
                      decoration: DecoConst().inputDecoration("Username"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      controller: _context.passwordController,
                      validator: (v) {
                        if (v!.length <= 3) return "ERROR PASSWORD";
                      },
                      decoration: DecoConst().inputDecoration("Password"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      controller: _context.verifyPasswordController,
                      validator: (v) {
                        if (v!.length <= 3) return "ERROR VERIFY";
                      },
                      decoration:
                          DecoConst().inputDecoration("Verify Password"),
                    ),
                  ),
                  ElevatedButton(
                    child: const Text("Check The Fields"),
                    onPressed: () {
                      context.read<SignInProvider>().checkFields();
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: Column(
            children: [
              CupertinoSwitch(
                value: context.watch<ThemeChangerProvider>().isLight,
                onChanged: (v) {
                  context.read<ThemeChangerProvider>().changeTheme(v);
                },
              ),
              DropdownButton(
                items: const [
                  DropdownMenuItem(
                    child: Text("1"),
                    value: '1',
                  ),
                  DropdownMenuItem(
                    child: Text("2"),
                    value: '2',
                  ),
                  DropdownMenuItem(
                    child: Text("3"),
                    value: '3',
                  ),
                ],
                onChanged: (v) {
                  context.read<DropProvider>().changeValue(v);
                },
                value: context.watch<DropProvider>().value,
              ),
            ],
          ))
        ],
      ),
    );
  }
}
