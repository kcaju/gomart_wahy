import 'package:flutter/material.dart';
import 'package:gomart_wahy/view/homescreen/widget/customtextformfield.dart';
import 'package:gomart_wahy/view/signin/signin_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final signupFormKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Determine screen type based on width
    bool isMobile = screenWidth < 600;
    bool isTablet = screenWidth >= 600 && screenWidth < 1024;
    bool isDesktop = screenWidth >= 1024;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white.withAlpha(240),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 120 : 35, vertical: isTablet ? 150 : 50),
        child: isDesktop
            ? Center(
                child: Container(
                  // height: 750,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Image.asset(
                              "assets/png/login.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Form(
                            key: signupFormKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Go",
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontSize: 50,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "mart",
                                      style: TextStyle(
                                          color: Color(0xFF03AC13),
                                          fontSize: 50,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Already have an account?",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SigninScreen(),
                                            ));
                                      },
                                      child: Text(
                                        "Sign in",
                                        style: TextStyle(
                                            color: Colors.orange,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Customtextformfield(
                                    controller: name, hintText: "Fullname"),
                                SizedBox(
                                  height: 15,
                                ),
                                Customtextformfield(
                                    controller: email,
                                    hintText: "Email address"),
                                SizedBox(
                                  height: 15,
                                ),
                                Customtextformfield(
                                    controller: mobile,
                                    hintText: "Mobile Number"),
                                SizedBox(
                                  height: 15,
                                ),
                                Customtextformfield(
                                  controller: password,
                                  hintText: "Password",
                                  isPassword: true,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                //create account button
                                GestureDetector(
                                  onTap: () {
                                    if (signupFormKey.currentState!
                                        .validate()) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SigninScreen(),
                                          ));
                                    }
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 240,
                                    child: Center(
                                      child: Text(
                                        "Create account",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Color(0xFF03AC13),
                                        borderRadius: BorderRadius.circular(5)),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),

                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "By signing up, I agree to",
                                        style: TextStyle(
                                            color: Colors.black.withAlpha(150),
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Terms of Use and Privacy Policy",
                                        style: TextStyle(
                                            color: Colors.black.withAlpha(150),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade200, offset: Offset(5, 5))
                      ],
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                ),
              )
            : //other devices
            Center(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  height: 650,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade200, offset: Offset(5, 5))
                      ],
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: SingleChildScrollView(
                    child: Form(
                      key: signupFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Go",
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "mart",
                                style: TextStyle(
                                    color: Color(0xFF03AC13),
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Text(
                                "Already have an account?",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SigninScreen(),
                                      ));
                                },
                                child: Text(
                                  "Sign in",
                                  style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Customtextformfield(
                              controller: name, hintText: "Fullname"),
                          SizedBox(
                            height: 15,
                          ),
                          Customtextformfield(
                              controller: email, hintText: "Email address"),
                          SizedBox(
                            height: 15,
                          ),
                          Customtextformfield(
                              controller: mobile, hintText: "Mobile Number"),
                          SizedBox(
                            height: 15,
                          ),
                          Customtextformfield(
                            controller: password,
                            hintText: "Password",
                            isPassword: true,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          //create account button
                          GestureDetector(
                            onTap: () {
                              if (signupFormKey.currentState!.validate()) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SigninScreen(),
                                    ));
                              }
                            },
                            child: Container(
                              height: isTablet ? 60 : 50,
                              width: isTablet ? 300 : double.infinity,
                              child: Center(
                                child: Text(
                                  "Create account",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: Color(0xFF03AC13),
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),

                          isTablet
                              ? Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "By signing up, I agree to",
                                        style: TextStyle(
                                            color: Colors.black.withAlpha(150),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Terms of Use and Privacy Policy",
                                        style: TextStyle(
                                            color: Colors.black.withAlpha(150),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                )
                              : Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        "By signing up, I agree to",
                                        style: TextStyle(
                                            color: Colors.black.withAlpha(150),
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        "Terms of Use and Privacy Policy",
                                        style: TextStyle(
                                            color: Colors.black.withAlpha(150),
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
