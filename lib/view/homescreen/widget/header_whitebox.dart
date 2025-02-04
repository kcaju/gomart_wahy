import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gomart_wahy/view/account_page/account_page.dart';
import 'package:gomart_wahy/view/all_products/all_productscreen.dart';
import 'package:gomart_wahy/view/cartpage/cartitems_page.dart';
import 'package:gomart_wahy/view/homescreen/widget/category_popup.dart';
import 'package:gomart_wahy/view/homescreen/widget/homepage.dart';
import 'package:gomart_wahy/view/quick_enquiry/quick_enquiryscreen.dart';
import 'package:gomart_wahy/view/signin/signin_screen.dart';
import 'package:gomart_wahy/view/wishlist_page/wish_listpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HeaderWhitebox extends StatelessWidget {
  const HeaderWhitebox({super.key});

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Determine screen type based on width
    bool isMobile = screenWidth < 600;
    bool isTablet = screenWidth >= 600 && screenWidth < 1024;
    bool isDesktop = screenWidth >= 1024;
    return Container(
      padding: EdgeInsets.only(left: screenWidth * 0.015),
      child: Row(
        children: [
          Row(
            children: [
              Text(
                "Go",
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: isMobile ? 35 : 40,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "mart",
                style: TextStyle(
                    color: Color(0xFF03AC13),
                    fontSize: isMobile ? 35 : 40,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Spacer(),
          isMobile ? SizedBox() : CategoryPopup(),
          isMobile
              ? SizedBox()
              : SizedBox(
                  width: screenWidth * 0.01,
                ),
          isDesktop
              ? GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Homepage(),
                        ));
                  },
                  child: Text(
                    "Home",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                )
              : SizedBox(),
          isDesktop
              ? SizedBox(
                  width: screenWidth * 0.01,
                )
              : SizedBox(),
          isDesktop
              ? PopupMenuButton<int>(
                  child: Row(
                    children: [
                      Text(
                        "Products",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  onSelected: (value) {
                    // Handle any selection if required
                    if (value == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AllProductscreen()),
                      );
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: Text(
                        "All Products",
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                  offset: Offset(0, 50), // Adjusts the popup position
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                )
              : SizedBox(),

          isDesktop
              ? SizedBox(
                  width: screenWidth * 0.01,
                )
              : SizedBox(),
          isDesktop
              ? GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuickEnquiryscreen(),
                        ));
                  },
                  child: Text(
                    "Quick Enquiry",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                )
              : SizedBox(),
          isDesktop
              ? SizedBox(
                  width: screenWidth * 0.01,
                )
              : SizedBox(),
          isMobile
              ? SizedBox()
              : PopupMenuButton<int>(
                  icon: Icon(
                    Icons.search,
                    color: Colors.grey,
                    size: isDesktop ? 25 : 30,
                  ),
                  onSelected: (value) {
                    // Handle any selection if required
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: Container(
                        width: 200,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    hintText: "Search Products..",
                                    hintStyle: TextStyle(
                                        color: Colors.grey.shade300,
                                        fontSize: 16),
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: InputBorder.none),
                              ),
                            ),
                            Container(
                              width: screenWidth * 0.04,
                              // height: screenHeight * 0.07,
                              child: Center(
                                child: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(5),
                                      bottomRight: Radius.circular(5))),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                  offset: Offset(0, 50), // Adjusts the popup position
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

          isMobile
              ? SizedBox()
              : SizedBox(
                  width: screenWidth * 0.01,
                ),
          isMobile
              ? SizedBox()
              : PopupMenuButton<int>(
                  child: Icon(
                    Icons.person_outlined,
                    size: isDesktop ? 25 : 30,
                    color: Colors.grey,
                  ),
                  onSelected: (value) async {
                    // Handle any selection if required
                    if (value == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AccountPage()),
                      );
                    } else if (value == 2) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CartitemsPage()),
                      );
                    } else if (value == 3) {
                      //logout
                      await FirebaseAuth.instance.signOut();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.green,
                          content: Text(
                            "Signed Out Successfully",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          )));
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SigninScreen(),
                        ),
                        (route) => false,
                      );
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "My Account",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: Row(
                        children: [
                          Icon(
                            Icons.sell,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "My Cart",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 3,
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Sign Out",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                  offset: Offset(0, 50), // Adjusts the popup position
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

          isMobile
              ? SizedBox()
              : SizedBox(
                  width: screenWidth * 0.01,
                ),
          isMobile
              ? SizedBox()
              : GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartitemsPage(),
                        ));
                  },
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.grey,
                    size: isDesktop ? 25 : 30,
                  ),
                ),
          isMobile
              ? SizedBox()
              : SizedBox(
                  width: screenWidth * 0.01,
                ),
          isDesktop
              ? CircleAvatar(
                  radius: 25,
                  child: Icon(
                    Icons.phone_outlined,
                    color: Colors.orange,
                  ),
                  backgroundColor: Colors.pink.shade50,
                )
              : SizedBox(),
          isDesktop
              ? SizedBox(
                  width: screenWidth * 0.01,
                )
              : SizedBox(),
          isDesktop
              ? Text(
                  "Phone & Telephone",
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.normal),
                )
              : SizedBox(),
          isDesktop
              ? SizedBox(
                  width: screenWidth * 0.01,
                )
              : SizedBox(),
          //end drawer open button
          Builder(builder: (context) {
            return GestureDetector(
              onTap: () {
                Scaffold.of(context).openEndDrawer();
              },
              child: Container(
                height: screenHeight * 0.7,
                padding: EdgeInsets.all(15),
                child: Icon(
                  Icons.apps,
                  color: Colors.white,
                  size: 35,
                ),
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(5)),
              ),
            );
          })
        ],
      ),
      height: screenHeight * 0.08,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(isDesktop ? 5 : 0)),
    );
  }
}
