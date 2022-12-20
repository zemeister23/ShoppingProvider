
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/provider/3_sms_provider.dart';
import 'package:provider/provider.dart';

class TestScreen extends StatefulWidget {
  TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

late DateTime dtm1 ;
late DateTime dtm2 ;

class _TestScreenState extends State<TestScreen> with WidgetsBindingObserver {
 
   late int year ;
 late int month ;
  late int day ;
 late int minute ;
 late int seconds ; 
 late SmsProvider provider;
 @override
 void initState() {
      dtm1 =  DateTime.fromMillisecondsSinceEpoch(Timestamp.now().millisecondsSinceEpoch);
    provider =  Provider.of<SmsProvider>(context,listen: false);
provider.starttTimer(secund: 100);
    WidgetsBinding.instance.addObserver(this);
    
     
     

    super.initState();
  }
  
  
   void didChangeAppLifecycleState(AppLifecycleState state) async {
  
    if (state == AppLifecycleState.resumed) {
      provider.stopTimer();
      dtm1 = DateTime.fromMillisecondsSinceEpoch(Timestamp.now().millisecondsSinceEpoch);
      
      
     
      
      provider.starttTimer(secund: seconds - (dtm1.difference(dtm2).inSeconds));
 
 
    //  provider.stopTimer();
    //  provider.starttTimer(secund:100);

   //  }
      setState(() {}); 
    }
    if (state == AppLifecycleState.paused) {
      
        dtm2 = DateTime.fromMillisecondsSinceEpoch(Timestamp.now().millisecondsSinceEpoch);
        seconds = provider.seconds;
  //     GetStorageService.instance.box.write(GetStorageService.instance.firebaseYear,data.toString());
  //     GetStorageService.instance.box.write(GetStorageService.instance.firebaseMonth,data.month);
  //     GetStorageService.instance.box.write(GetStorageService.instance.firebaseDay,data.day);
  //     GetStorageService.instance.box.write(GetStorageService.instance.firebaseMinute,data.minute);
  //     GetStorageService.instance.box.write(GetStorageService.instance.firebaseSeconds,data.second);
  //  year = int.parse( GetStorageService.instance.box.read(GetStorageService.instance.firebaseYear).toString());
  // month = int.parse( GetStorageService.instance.box.read(GetStorageService.instance.firebaseMonth).toString());
  // day = int.parse( GetStorageService.instance.box.read(GetStorageService.instance.firebaseDay).toString());
  // minute = int.parse( GetStorageService.instance.box.read(GetStorageService.instance.firebaseMinute).toString());
  // seconds = int.parse( GetStorageService.instance.box.read(GetStorageService.instance.firebaseSeconds).toString());

  //     setState(() {}); 
    }

    super.didChangeAppLifecycleState(state);
  }
 
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      
      child: InkWell(
        child: Text("${context.watch<SmsProvider>().seconds}"),
        onTap: () {
        
        
        
        },
      ),
    ));
  }
}
