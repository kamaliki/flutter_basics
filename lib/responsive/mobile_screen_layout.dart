import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();

}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  String username = '';

  @override
  void initState() {
    super.initState
    ();
    getUsername();
  }

  void getUsername() async{
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      username = (snap.data() as Map<String, dynamic>)['username'];
    });
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Screen Layout'),
      ),
      body: Center(
        child: Text(
          'Welcome to flutter basics',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }


}