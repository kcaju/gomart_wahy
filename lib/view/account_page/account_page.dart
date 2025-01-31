import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gomart_wahy/view/account_page/widget/address_box.dart';
import 'package:gomart_wahy/view/account_page/widget/orderhistory_box.dart';
import 'package:gomart_wahy/view/account_page/widget/ordertracking_box.dart';
import 'package:gomart_wahy/view/account_page/widget/profiledeatils_box.dart';
import 'package:gomart_wahy/view/account_page/widget/updatedprofile_box.dart';
import 'package:gomart_wahy/view/floatingactionbutton/custom_floatingbutton.dart';
import 'package:gomart_wahy/view/homescreen/drawerscreen/drawer_screen.dart';
import 'package:gomart_wahy/view/homescreen/widget/header_greencard.dart';
import 'package:gomart_wahy/view/homescreen/widget/header_whitebox.dart';
import 'package:gomart_wahy/view/homescreen/widget/homepage.dart';
import 'package:gomart_wahy/view/signin/signin_screen.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool isDashboard = true;
  bool isOrderHistory = false;
  bool isUpdatedProfile = false;
  bool isOrderTracking = false;
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
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * (isDesktop ? 0.04 : 0.01),
                            vertical: screenHeight * (isDesktop ? 0.08 : 0.09)),
                        child: Column(
                          children: [
                            //profile details box
                            Container(
                              child: ProfiledeatilsBox(),
                              //end of first box
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Colors.grey.shade200)),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            //manage account box section
                            isDesktop
                                ? Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //manage account box
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 10),
                                        width: 250,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Manage My Account",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            //dashboard
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  isDashboard = true;
                                                  isOrderTracking = false;
                                                  isOrderHistory = false;
                                                  isUpdatedProfile = false;
                                                });
                                              },
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.menu,
                                                    color: isDashboard
                                                        ? Colors.green
                                                        : Colors.grey.shade600,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "Dashboard",
                                                    style: TextStyle(
                                                        color: isDashboard
                                                            ? Colors.green
                                                            : Colors
                                                                .grey.shade600,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 18),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            //order history
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  isOrderHistory = true;
                                                  isUpdatedProfile = false;
                                                  isOrderTracking = false;
                                                  isDashboard = false;
                                                });
                                              },
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.view_list_outlined,
                                                    color: isOrderHistory
                                                        ? Colors.green
                                                        : Colors.grey.shade600,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "Order History",
                                                    style: TextStyle(
                                                        color: isOrderHistory
                                                            ? Colors.green
                                                            : Colors
                                                                .grey.shade600,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 18),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),

                                            //updated profile
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  isUpdatedProfile = true;
                                                  isOrderHistory = false;
                                                  isOrderTracking = false;
                                                  isDashboard = false;
                                                });
                                              },
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.grid_view_outlined,
                                                    color: isUpdatedProfile
                                                        ? Colors.green
                                                        : Colors.grey.shade600,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "Updated Profile",
                                                    style: TextStyle(
                                                        color: isUpdatedProfile
                                                            ? Colors.green
                                                            : Colors
                                                                .grey.shade600,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 18),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),

                                            //order tracking
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  isOrderTracking = true;
                                                  isOrderHistory = false;
                                                  isUpdatedProfile = false;
                                                  isDashboard = false;
                                                });
                                              },
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.grid_view_outlined,
                                                    color: isOrderTracking
                                                        ? Colors.green
                                                        : Colors.grey.shade600,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "Order Tracking",
                                                    style: TextStyle(
                                                        color: isOrderTracking
                                                            ? Colors.green
                                                            : Colors
                                                                .grey.shade600,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 18),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),

                                            //logout
                                            GestureDetector(
                                              onTap: () async {
                                                await FirebaseAuth.instance
                                                    .signOut();
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        backgroundColor:
                                                            Colors.green,
                                                        content: Text(
                                                          "Signed Out Successfully",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 18),
                                                        )));
                                                Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        SigninScreen(),
                                                  ),
                                                  (route) => false,
                                                );
                                              },
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.grid_view,
                                                    color: Colors.grey.shade600,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "Logout",
                                                    style: TextStyle(
                                                        color: Colors
                                                            .grey.shade600,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 18),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.grey.shade200)),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      //address book box
                                      Expanded(
                                          child: isOrderTracking
                                              ? OrdertrackingBox()
                                              : isUpdatedProfile
                                                  ? UpdatedprofileBox()
                                                  : isOrderHistory
                                                      ? OrderhistoryBox()
                                                      : AddressBox())
                                    ],
                                  )
                                : //other devices
                                Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: isTablet ? 20 : 5),
                                    child: Column(
                                      children: [
                                        //manage account
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 10),
                                          width: double.infinity,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Manage My Account",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              //dashboard
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    isDashboard = true;
                                                    isOrderTracking = false;
                                                    isOrderHistory = false;
                                                    isUpdatedProfile = false;
                                                  });
                                                },
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.menu,
                                                      color: isDashboard
                                                          ? Colors.green
                                                          : Colors
                                                              .grey.shade600,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      "Dashboard",
                                                      style: TextStyle(
                                                          color: isDashboard
                                                              ? Colors.green
                                                              : Colors.grey
                                                                  .shade600,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 18),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              //order history
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    isOrderHistory = true;
                                                    isUpdatedProfile = false;
                                                    isOrderTracking = false;
                                                    isDashboard = false;
                                                  });
                                                },
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.view_list_outlined,
                                                      color: isOrderHistory
                                                          ? Colors.green
                                                          : Colors
                                                              .grey.shade600,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      "Order History",
                                                      style: TextStyle(
                                                          color: isOrderHistory
                                                              ? Colors.green
                                                              : Colors.grey
                                                                  .shade600,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 18),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),

                                              //updated profile
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    isUpdatedProfile = true;
                                                    isOrderHistory = false;
                                                    isOrderTracking = false;
                                                    isDashboard = false;
                                                  });
                                                },
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.grid_view_outlined,
                                                      color: isUpdatedProfile
                                                          ? Colors.green
                                                          : Colors
                                                              .grey.shade600,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      "Updated Profile",
                                                      style: TextStyle(
                                                          color:
                                                              isUpdatedProfile
                                                                  ? Colors.green
                                                                  : Colors.grey
                                                                      .shade600,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 18),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),

                                              //order tracking
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    isOrderTracking = true;
                                                    isOrderHistory = false;
                                                    isUpdatedProfile = false;
                                                    isDashboard = false;
                                                  });
                                                },
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.grid_view_outlined,
                                                      color: isOrderTracking
                                                          ? Colors.green
                                                          : Colors
                                                              .grey.shade600,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      "Order Tracking",
                                                      style: TextStyle(
                                                          color: isOrderTracking
                                                              ? Colors.green
                                                              : Colors.grey
                                                                  .shade600,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 18),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),

                                              //logout
                                              GestureDetector(
                                                onTap: () async {
                                                  await FirebaseAuth.instance
                                                      .signOut();
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          backgroundColor:
                                                              Colors.green,
                                                          content: Text(
                                                            "Signed Out Successfully",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18),
                                                          )));
                                                  Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          SigninScreen(),
                                                    ),
                                                    (route) => false,
                                                  );
                                                },
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.grid_view,
                                                      color:
                                                          Colors.grey.shade600,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      "Logout",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .grey.shade600,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 18),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.grey.shade200)),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        isDashboard
                                            ? AddressBox()
                                            : isOrderHistory
                                                ? OrderhistoryBox()
                                                : isUpdatedProfile
                                                    ? UpdatedprofileBox()
                                                    : OrdertrackingBox()
                                      ],
                                    ),
                                  )

                            //end of main part
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
                                              builder: (context) => Homepage(),
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
