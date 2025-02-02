import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gomart_wahy/view/homescreen/widget/customtextformfield.dart';

class UpdatedprofileBox extends StatefulWidget {
  const UpdatedprofileBox({super.key});

  @override
  State<UpdatedprofileBox> createState() => _UpdatedprofileBoxState();
}

class _UpdatedprofileBoxState extends State<UpdatedprofileBox> {
  TextEditingController fname = TextEditingController();
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController email1 = TextEditingController();
  TextEditingController image = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  String imageUrl = "assets/png/client-2.png"; // Default image

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Function to update user profile in Firestore
  Future<void> _updateUserProfile() async {
    try {
      User? user = _auth.currentUser; // Get the current user
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("No authenticated user found!")),
        );
        return;
      }

      String uid = user.uid; // Get the UID of the logged-in user

      await _firestore.collection("users").doc(uid).update({
        "name": fname.text,
        "email": email.text,
        "mobile": mobile.text,
        "imageUrl": imageUrl, // Update the image URL
        "userAddress": {
          "mobile": mobile.text,
          "email": email.text,
          "firstName": fname.text,
          'lastName': "",
          'address': "",
          "eirCode": "",
          "state": ""
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Profile Updated Successfully",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          )));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error updating profile: $e")),
      );
    }
  }

  void showImageInputDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Enter Image URL"),
          content: TextField(
            controller: image,
            decoration: InputDecoration(
              hintText: "Paste your image URL here",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Close dialog
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  imageUrl = image.text.isNotEmpty
                      ? image.text
                      : imageUrl; // Update image if URL is valid
                });
                image.clear();
                Navigator.pop(context); // Close dialog
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _changePassword() async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("No authenticated user found!")),
        );
        return;
      }

      if (newPassword.text != confirmPassword.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("New password and confirm password do not match!")),
        );
        return;
      }

      // Reauthenticate user before updating password
      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword.text, // Get current password from input
      );

      await user.reauthenticateWithCredential(credential); // Reauthenticate
      await user.updatePassword(newPassword.text); // Update password

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Password Updated Successfully",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          )));
      currentPassword.clear();
      email1.clear();
      newPassword.clear();
      confirmPassword.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error changing password: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Determine screen type based on width
    bool isMobile = screenWidth < 600;
    bool isTablet = screenWidth >= 600 && screenWidth <= 1024;
    bool isDesktop = screenWidth > 1024;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
          color: Colors.white, border: Border.all(color: Colors.grey.shade200)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Update Profile",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(
            height: 10,
          ),
          //upload image box
          Container(
            padding: EdgeInsets.symmetric(vertical: 40),
            alignment: Alignment.center,
            child: Column(
              children: [
                GestureDetector(
                  onTap: showImageInputDialog, // Open alert box,
                  child: Column(
                    children: [
                      Image.network(
                        imageUrl,
                        width: 100,
                        height: 100,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset("assets/png/client-2.png",
                              width: 100, height: 100);
                        },
                      ),
                      Text(
                        "Click here to input Image URL",
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      )
                    ],
                  ),
                ),
                Text(
                  textAlign: TextAlign.center,
                  "(Only *.jpeg and *.png images will be accepted)",
                  style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.normal,
                      fontSize: 18),
                ),
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade200)),
          ),
          //fields
          SizedBox(
            height: 15,
          ),
          Customtextformfield(hintText: "Full Name", controller: fname),
          SizedBox(
            height: 20,
          ),
          isMobile
              ? Column(
                  children: [
                    Customtextformfield(hintText: "Mobile", controller: mobile),
                    SizedBox(
                      height: 20,
                    ),
                    Customtextformfield(hintText: "Email", controller: email)
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                        child: Customtextformfield(
                            hintText: "Mobile", controller: mobile)),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: Customtextformfield(
                            hintText: "Email", controller: email)),
                  ],
                ),
          SizedBox(
            height: 20,
          ), //update button
          GestureDetector(
            onTap: () {
              _updateUserProfile();
            },
            child: Container(
              height: 50,
              width: 180,
              alignment: Alignment.center,
              child: Text(
                "Update Profile",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(5)),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            "Change Password",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(
            height: 15,
          ),
          isMobile
              ? Column(
                  children: [
                    Customtextformfield(hintText: "Email", controller: email1),
                    SizedBox(
                      height: 20,
                    ),
                    Customtextformfield(
                        hintText: "Current Password",
                        controller: currentPassword)
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                        child: Customtextformfield(
                            hintText: "Email", controller: email1)),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: Customtextformfield(
                            hintText: "Current Password",
                            controller: currentPassword)),
                  ],
                ),
          SizedBox(
            height: 20,
          ),
          isMobile
              ? Column(
                  children: [
                    Customtextformfield(
                        hintText: "New Password", controller: newPassword),
                    SizedBox(
                      height: 20,
                    ),
                    Customtextformfield(
                        hintText: "Confirm Password",
                        controller: confirmPassword)
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                        child: Customtextformfield(
                            hintText: "New Password", controller: newPassword)),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: Customtextformfield(
                            hintText: "Confirm Password",
                            controller: confirmPassword)),
                  ],
                ),
          SizedBox(
            height: 20,
          ),
          //change passwrd button
          GestureDetector(
            onTap: () {
              _changePassword();
            },
            child: Container(
              height: 50,
              width: 180,
              alignment: Alignment.center,
              child: Text(
                "Change Password",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(5)),
            ),
          ),
        ],
      ),
    );
  }
}
