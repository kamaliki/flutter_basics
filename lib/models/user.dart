

class User {
 final String uid;
  final String email;
  final String username;
  final String bio;
  final String photoUrl;
  final List<String> followers;
  final List<String> following;

  const User({
    required this.uid,
    required this.email,
    required this.username,
    required this.bio,
    required this.photoUrl,
    required this.followers,
    required this.following,
  });

  // factory User.fromMap(Map<String, dynamic> map) {
  //   return User(
  //     uid: map['uid'],
  //     email: map['email'],
  //     username: map['username'],
  //     bio: map['bio'],
  //     photoUrl: map['photoUrl'],
  //     followers: List<String>.from(map['followers']),
  //     following: List<String>.from(map['following']),
  //   );
  // }

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

}