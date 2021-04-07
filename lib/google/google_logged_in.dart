import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLoggedIn extends StatelessWidget {
  final googleSignIn = GoogleSignIn();

  void _signOutGoogle() async {
    // sign out from google
    await googleSignIn.disconnect();
    // sign out from Firebase
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    // user from firebase
    final user = FirebaseAuth.instance.currentUser;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CircleAvatar(
          maxRadius: 25,
          backgroundImage: NetworkImage(user.photoURL),
        ),
        Center(
            child: Text(
          'Name: ${user.displayName}',
        )),
        Text(
          'Email: ' + user.email,
        ),
        Center(
            child: TextButton(
          child: Text("Log out"),
          onPressed: () => {_signOutGoogle()},
        ))
      ],
    );
  }
}
