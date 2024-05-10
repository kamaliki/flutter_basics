import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_basics/models/user.dart' as model;
import 'package:flutter_basics/resources/storage_method.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future <model.User?> getUserDetails() async {
    User? user = _auth.currentUser!;
    if (user != null) {
      DocumentSnapshot snap = await _firestore.collection('users').doc(user.uid).get();
      return model.User.fromSnap(snap);
    }
    return null;
  }

  Future<String> loginUser(
      {required String email, required String password}) async {
    try {
      //make sure all the fields are filled
      if (email.isEmpty || password.isEmpty) {
        return 'Please fill all the fields';
      }

      await _auth.signInWithEmailAndPassword(email: email, password: password);

      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    } catch (e) {
      return e.toString();
    }
    return '';
  }

  //sign up  email, bio, username, password, photo create user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List? file,
  }) async {
    try {
      //make sure all the fields are filled
      if (email.isEmpty ||
          password.isEmpty ||
          username.isEmpty ||
          bio.isEmpty ||
          file == null) {
        return 'Please fill all the fields';
      }
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      String photoUrl =
          await StorageMethod().uploadImageToStorage('profile', file, false);

      model.User user = model.User(
          uid: userCredential.user!.uid,
          email: email,
          username: username,
          bio: bio,
          photoUrl: photoUrl,
          followers: [],
          following: []
      );

      //store user data in firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set(user.toJson(), );

      return "Success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        return 'Incorrect email format';
      }
    } catch (e) {
      return e.toString();
    }
    return '';
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
