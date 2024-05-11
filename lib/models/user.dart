

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String email;
  final String username;
  final String bio;
  final String photoUrl;
  final List followers;
  final List following;

  const User({
    required this.uid,
    required this.email,
    required this.username,
    required this.bio,
    required this.photoUrl,
    required this.followers,
    required this.following,
  });


  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
      'bio': bio,
      'photoUrl': photoUrl,
      'followers': followers,
      'following': following,
    };
  }

  static User fromSnap( DocumentSnapshot snap){
    var data = snap.data() as Map<String, dynamic>;

    return User(
      uid: data['uid'],
      email: data['email'],
      username: data['username'],
      bio: data['bio'],
      photoUrl: data['photoUrl'],
      followers: List<String>.from(data['followers']),
      following: List<String>.from(data['following']),
    );
  }

}