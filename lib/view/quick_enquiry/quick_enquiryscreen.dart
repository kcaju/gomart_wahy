import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gomart_wahy/view/floatingactionbutton/custom_floatingbutton.dart';
import 'package:gomart_wahy/view/homescreen/drawerscreen/drawer_screen.dart';
import 'package:gomart_wahy/view/homescreen/home_screen.dart';
import 'package:gomart_wahy/view/homescreen/widget/header_greencard.dart';
import 'package:gomart_wahy/view/homescreen/widget/header_whitebox.dart';
import 'package:gomart_wahy/view/homescreen/widget/homepage.dart';

class QuickEnquiryscreen extends StatefulWidget {
  const QuickEnquiryscreen({super.key});

  @override
  State<QuickEnquiryscreen> createState() => _QuickEnquiryscreenState();
}

class _QuickEnquiryscreenState extends State<QuickEnquiryscreen> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController message = TextEditingController();
  final formkey = GlobalKey<FormState>();

  // Function to save enquiry to Firestore
  Future<void> submitEnquiry() async {
    if (formkey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection('enquiries').add({
          'firstName': firstName.text,
          'lastName': lastName.text,
          'email': email.text,
          'phone': phone.text,
          'message': message.text,
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Enquiry Submitted Successfully",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            )));

        // Clear text fields after submission
        firstName.clear();
        lastName.clear();
        email.clear();
        phone.clear();
        message.clear();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error submitting enquiry: $e")),
        );
      }
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
    return Scaffold(
      endDrawer: DrawerScreen(),
      floatingActionButton: CustomFloatingbutton(),
      body: Stack(
        children: [
          Column(
            children: [
              //green container
              isDesktop ? HeaderGreencard() : SizedBox(),
              //main body container
              Expanded(
                  // flex: 8,
                  child: Container(
                child: SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  screenWidth * (isDesktop ? 0.04 : 0.01),
                              vertical:
                                  screenHeight * (isDesktop ? 0.08 : 0.09)),
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  "Enquiry Page",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: isMobile ? 25 : 35),
                                ),
                              ),
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen(),
                                            ));
                                      },
                                      child: Text(
                                        "Home >>",
                                        style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontWeight: FontWeight.bold,
                                            fontSize: isMobile ? 14 : 16),
                                      ),
                                    ),
                                    Text(
                                      "Page >> Category",
                                      style: TextStyle(
                                          color: Colors.grey.shade500,
                                          fontWeight: FontWeight.bold,
                                          fontSize: isMobile ? 14 : 16),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 100,
                              ),
                              //need help and fields
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: isDesktop ? 0 : 20),
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Need Help ? Send Message",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: isMobile ? 23 : 30),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      //textfields
                                      Text(
                                        "First Name",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey.shade700,
                                            fontSize: 15),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 5),
                                        width: 500,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Colors.grey.shade200)),
                                        child: TextFormField(
                                          controller: firstName,
                                          validator: (value) {
                                            if (value != null &&
                                                value.isNotEmpty) {
                                              return null;
                                            } else {
                                              return "fill the field";
                                            }
                                          },
                                          decoration: InputDecoration(
                                              hintStyle: TextStyle(
                                                  color: Colors.grey.shade500,
                                                  fontSize: 16),
                                              hintText: "Saiful",
                                              border: InputBorder.none),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "Last Name",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey.shade700,
                                            fontSize: 15),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 5),
                                        width: 500,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Colors.grey.shade200)),
                                        child: TextFormField(
                                          controller: lastName,
                                          validator: (value) {
                                            if (value != null &&
                                                value.isNotEmpty) {
                                              return null;
                                            } else {
                                              return "fill the field";
                                            }
                                          },
                                          decoration: InputDecoration(
                                              hintStyle: TextStyle(
                                                  color: Colors.grey.shade500,
                                                  fontSize: 16),
                                              hintText: "Talukdar",
                                              border: InputBorder.none),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "Email",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey.shade700,
                                            fontSize: 15),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 5),
                                        width: 500,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Colors.grey.shade200)),
                                        child: TextFormField(
                                          controller: email,
                                          validator: (value) {
                                            if (value != null &&
                                                value.isNotEmpty) {
                                              return null;
                                            } else {
                                              return "fill the field";
                                            }
                                          },
                                          decoration: InputDecoration(
                                              hintStyle: TextStyle(
                                                  color: Colors.grey.shade500,
                                                  fontSize: 16),
                                              hintText: "Your Email",
                                              border: InputBorder.none),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "Phone",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey.shade700,
                                            fontSize: 15),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 5),
                                        width: 500,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Colors.grey.shade200)),
                                        child: TextFormField(
                                          controller: phone,
                                          validator: (value) {
                                            if (value != null &&
                                                value.isNotEmpty) {
                                              return null;
                                            } else {
                                              return "fill the field";
                                            }
                                          },
                                          decoration: InputDecoration(
                                              hintStyle: TextStyle(
                                                  color: Colors.grey.shade500,
                                                  fontSize: 16),
                                              hintText: "Your Phone",
                                              border: InputBorder.none),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "Message",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey.shade700,
                                            fontSize: 15),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 5),
                                        width: 700,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Colors.grey.shade200)),
                                        child: TextFormField(
                                          controller: message,
                                          validator: (value) {
                                            if (value != null &&
                                                value.isNotEmpty) {
                                              return null;
                                            } else {
                                              return "fill the field";
                                            }
                                          },
                                          maxLines: 8,
                                          decoration: InputDecoration(
                                              hintStyle: TextStyle(
                                                  color: Colors.grey.shade500,
                                                  fontSize: 16),
                                              hintText: "Write your message",
                                              border: InputBorder.none),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (formkey.currentState!
                                              .validate()) {
                                            submitEnquiry();
                                          }
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 150,
                                          child: Center(
                                            child: Text(
                                              "Send Message",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Color(0xFF03AC13)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Colors.grey.shade200),
                                      color: Colors.white.withAlpha(90)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //footer part
                        SizedBox(
                          height: 80,
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: isTablet ? 30 : 5, vertical: 35),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                isMobile
                                    ? Column(
                                        children: [
                                          Text(
                                            "Subscribe to the GOMART",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "New Arrivals",
                                            style: TextStyle(
                                                color: Colors.orange,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Subscribe to the GOMART",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "New Arrivals",
                                            style: TextStyle(
                                                color: Colors.orange,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "& Other information.",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  width: isTablet ? double.infinity : 500,
                                  height: 55,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              hintText: "Enter Email Address",
                                              fillColor: Colors.white,
                                              filled: true,
                                              border: InputBorder.none),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    Homepage(),
                                              ));
                                        },
                                        child: Container(
                                          width: 150,
                                          child: Center(
                                            child: Text(
                                              "Subscribe Now",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(5),
                                                  bottomRight:
                                                      Radius.circular(5))),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Divider(
                                  color: Colors.white.withAlpha(80),
                                ),
                                SizedBox(
                                  height: 100,
                                ),
                                Divider(
                                  color: Colors.white.withAlpha(80),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 25),
                                  child: Row(
                                    children: [
                                      Text(
                                        "All rights reserved Made by",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "GoMart",
                                        style: TextStyle(
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      isDesktop
                                          ? SizedBox(
                                              width: 400,
                                            )
                                          : SizedBox(),
                                      isDesktop
                                          ? Row(
                                              children: [
                                                Text(
                                                  "Go",
                                                  style: TextStyle(
                                                      color: Colors.orange,
                                                      fontSize: 40,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  "mart",
                                                  style: TextStyle(
                                                      color: Color(0xFF03AC13),
                                                      fontSize: 40,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            )
                                          : SizedBox(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                color: Colors.white,
              ))
            ],
          ),
          //small container (appbar)
          Positioned(
            left: 0,
            right: 0,
            top: isDesktop ? screenHeight * (isMobile ? 0.06 : 0.05) : 0,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * (isDesktop ? 0.04 : 0)),
              child: HeaderWhitebox(),
            ),
          )
        ],
      ),
    );
  }
}
