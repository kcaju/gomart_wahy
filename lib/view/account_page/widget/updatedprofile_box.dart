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
  TextEditingController confirmPassword = TextEditingController();
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
                Image.asset("assets/png/client-2.png"),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Drop your files here or",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "browse",
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                  ],
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
          Container(
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
                    Customtextformfield(hintText: "Email", controller: email),
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
                            hintText: "Email", controller: email)),
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
          Container(
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
        ],
      ),
    );
  }
}
