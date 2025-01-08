import 'package:flutter/material.dart';
import 'package:gomart_wahy/view/homescreen/home_screen.dart';
import 'package:gomart_wahy/view/homescreen/widget/customtextformfield.dart';
import 'package:gomart_wahy/view/sign_up/signup_screen.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final signinFormKey = GlobalKey<FormState>();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
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
      backgroundColor: Colors.white.withAlpha(240),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 120 : 35, vertical: isTablet ? 150 : 50),
        child: isDesktop
            ? Center(
                child: Container(
                  // height: 350,
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 25),
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
                              key: signinFormKey,
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
                                    height: 12,
                                  ),
                                  Text(
                                    "Hey there!",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Welcome back",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Gomart",
                                        style: TextStyle(
                                            color: Colors.orange,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Email",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Customtextformfield(
                                      controller: email,
                                      hintText: "Enter your Email"),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Password",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Customtextformfield(
                                    controller: password,
                                    hintText: "Password",
                                    isPassword: true,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Forgot Password",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  //sign in button
                                  GestureDetector(
                                    onTap: () {
                                      if (signinFormKey.currentState!
                                          .validate()) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen(),
                                            ));
                                      }
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 200,
                                      child: Center(
                                        child: Text(
                                          "Sign In",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Color(0xFF03AC13),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Don't have an Account?",
                                        style: TextStyle(
                                            color: Colors.black.withAlpha(150),
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SignupScreen(),
                                              ));
                                        },
                                        child: Text(
                                          "Sign Up",
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
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
            Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                height: 550,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade200, offset: Offset(5, 5))
                    ],
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Form(
                  key: signinFormKey,
                  child: SingleChildScrollView(
                    child: Column(
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
                          height: 12,
                        ),
                        Text(
                          "Hey there!",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Welcome back",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Gomart",
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Email",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Customtextformfield(
                            controller: email, hintText: "Enter your Email"),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Password",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Customtextformfield(
                          controller: password,
                          hintText: "Password",
                          isPassword: true,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Forgot Password",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //sign in button
                        GestureDetector(
                          onTap: () {
                            if (signinFormKey.currentState!.validate()) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ));
                            }
                          },
                          child: Container(
                            height: isTablet ? 60 : 50,
                            width: isTablet ? 300 : double.infinity,
                            child: Center(
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: isTablet ? 16 : 15,
                                    fontWeight: FontWeight.bold),
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
                        Row(
                          children: [
                            Text(
                              "Don't have an Account?",
                              style: TextStyle(
                                  color: Colors.black.withAlpha(150),
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignupScreen(),
                                    ));
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
