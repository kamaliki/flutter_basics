import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class StorageMethod {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  //get userid from auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadImageToStorage(
    String path,
    Uint8List file,
    bool isPost,
  ) async {
    try {
      Reference ref = _storage.ref().child(path).child(
          '${isPost ? 'post' : 'profile'}_${_auth.currentUser!.uid}');
      if(isPost) {
        String id = const Uuid().v1();
        ref = ref.child(id);
      }

      final UploadTask uploadTask = ref.putData(file);

      final TaskSnapshot taskSnapshot = await uploadTask;

      return await taskSnapshot.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      debugPrint('Error: $e');
      return '';
    }
  }
}
