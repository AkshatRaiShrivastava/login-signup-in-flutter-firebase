import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/auth_file.dart';
import 'package:firebase_login/login.dart';
import 'package:flutter/material.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  String username = "";
  final _auth = AuthService();
  Future _getUserData() async{
    await FirebaseFirestore.instance.collection("users").doc(_auth.currentUserId()).get()
        .then((DocumentSnapshot documentSnapshot) {
          if(documentSnapshot.exists){
            // username = documentSnapshot.get("name").toString();
            username = documentSnapshot.get("name").toString();
            log(username);
          }
    });

  }
  @override
  Widget build(BuildContext context) {
    _getUserData();
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/background.png'),fit:BoxFit.cover)
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text("Welcome Back ${FirebaseAuth.instance.currentUser!.displayName}"),
        ),
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 100,left: 20),
              child: const Text("This is my flutter app",style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            )
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                  child:  Container(

                    child: CircleAvatar(
                      backgroundImage: NetworkImage("https://encrypted-tbn2.gstatic.com/licensed-image?q=tbn:ANd9GcTQI--x3RbpvD1MJNuWrYSNaHhD-SyOwXvvtP7VIg2GV8hANisvdJvBTUv2NGnpL7adzRNiM57DDW_7VVI"),
                    ),

                  ) ,

              ),
              ListTile(
                title: const Text("Logout"),
                leading: const Icon(Icons.logout),
                onTap: (){
                  _auth.signout();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const MyLogin()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
