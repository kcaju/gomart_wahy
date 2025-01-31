import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gomart_wahy/view/homescreen/home_screen.dart';

class SigninScreenController with ChangeNotifier {
  bool isLoading = false;
  onSignIn(
      {required String email,
      required String pass,
      required BuildContext context}) async {
    isLoading = true;
    notifyListeners();
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      if (credential.user?.uid != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Signed In successfully",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            )));

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        print('No user found for that email.');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "No user found for that email.",
              style: TextStyle(color: Colors.white),
            )));
      }
    }
    isLoading = false;
    notifyListeners();
  }
}
