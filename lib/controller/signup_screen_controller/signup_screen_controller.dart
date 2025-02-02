import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gomart_wahy/view/signin/signin_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupScreenController with ChangeNotifier {
  bool isLoading = false;
  toSignUp(
      {required String email,
      required String password,
      required String mobile,
      required String name,
      required BuildContext context}) async {
    isLoading = true;
    notifyListeners();
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      //navigate to HomePage
      if (credential.user?.uid != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Signed Up Successfully",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            )));
        String userid = credential.user!.uid;

        // Save user details in Firestore
        FirebaseFirestore.instance.collection('users').doc(userid).set({
          'email': email,
          'name': name,
          'mobile': mobile,
          'uid': credential.user!.uid,
          "cartItems": [],
          'lastLogin': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));

        // Store credentials in SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', email);
        await prefs.setString('name', name);
        await prefs.setString('uid', credential.user!.uid);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SigninScreen(),
            ));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "The password provided is too weak.",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            )));
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "The account already exists for that email.",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            )));
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
    notifyListeners();
  }
}
