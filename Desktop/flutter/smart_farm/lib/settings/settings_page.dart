import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:smart_farm/constants.dart';
import 'package:smart_farm/login/sign_in.dart';
import 'package:smart_farm/service/firebase_service.dart';
import 'package:smart_farm/settings/components/money_history.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.all(0.0),
                leading: const CircleAvatar(
                  child: Icon(
                    CupertinoIcons.person,
                    color: Colors.white,
                  ),
                ),
                title: const Text(
                  "Xaridor",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),
                ),
                subtitle: Text(
                  "${FirebaseService.auth.currentUser!.phoneNumber}",
                  style: TextStyle(fontSize: 14.0, color: Colors.black),
                ),
              ),
              const Spacer(flex: 20),
              Row(
                children: [
                  Expanded(
                    child: MoneyHistory(
                      image: "assets/images/card.png",
                      text: "Depozit",
                      callback: () {},
                    ),
                    flex: 8,
                  ),
                  const Spacer(flex: 1),
                  Expanded(
                    child: MoneyHistory(
                      image: "assets/images/clock.png",
                      text: "Xaridlar tarixi",
                      callback: () {},
                    ),
                    flex: 8,
                  ),
                ],
              ),
              const Spacer(flex: 1),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  border: Border.all(color: kPrimaryLightColor),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Text(
                  "Profilni tahrirlash",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
              const Spacer(flex: 1),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: kPrimaryLightColor),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    onTap: () {},
                    leading:
                        Image.asset("assets/images/internet.png", height: 22.0),
                    title: const Text(
                      "Tilni o'zgartirish",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 14.0,
                    ),
                  ),
                ),
                flex: 5,
              ),
              const Spacer(flex: 1),
              Expanded(
                child: Container(
                  width: double.infinity,
                  // padding: const EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.redAccent),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    onTap: () {
                      signOutAlertBottomSheet(context);
                    },
                    leading: const Icon(Icons.logout, color: Colors.redAccent),
                    title: const Text(
                      "Hisobdan chiqish",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.redAccent,
                      size: 14.0,
                    ),
                  ),
                ),
                flex: 5,
              ),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }

  Future<PersistentBottomSheetController<dynamic>> signOutAlertBottomSheet(
      BuildContext context) async {
    return showBottomSheet(
        constraints: BoxConstraints(minHeight: Get.height * 0.1),
        context: context,
        builder: (context) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                child: const Text("Ha"),
                onPressed: () async {
                  await FirebaseService.auth.signOut().then((value) =>
                      Get.off(SignIn(), transition: Transition.topLevel));
                },
                style: ElevatedButton.styleFrom(primary: Colors.red),
              ),
              ElevatedButton(
                child: const Text("Yo'q"),
                onPressed: () {
                  Get.back();
                },
                style: ElevatedButton.styleFrom(primary: kPrimaryColor),
              ),
            ],
          );
        });
  }
}
