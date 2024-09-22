import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/home.dart';
import 'package:firebase_login/login.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});



  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigateToHome();
  }

  _navigateToHome()async{
    await Future.delayed(const Duration(milliseconds: 2000),(){});
    if(FirebaseAuth.instance.currentUser?.uid == null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const MyLogin()));
    }
    else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const MyHome()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 300,
          width: 300,
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/splash_screen_logo.png'),)
          ),
        ),
      ),
    );
  }
}
