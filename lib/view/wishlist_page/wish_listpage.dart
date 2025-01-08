import 'package:flutter/material.dart';
import 'package:gomart_wahy/view/floatingactionbutton/custom_floatingbutton.dart';
import 'package:gomart_wahy/view/homescreen/drawerscreen/drawer_screen.dart';
import 'package:gomart_wahy/view/homescreen/home_screen.dart';
import 'package:gomart_wahy/view/homescreen/widget/header_greencard.dart';
import 'package:gomart_wahy/view/homescreen/widget/header_whitebox.dart';

class WishListpage extends StatelessWidget {
  const WishListpage({super.key});

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
                            Center(
                              child: Text(
                                "Wishlist Page",
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
                                            builder: (context) => HomeScreen(),
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
                                    "Page >> Wishlist Page",
                                    style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontWeight: FontWeight.bold,
                                        fontSize: isMobile ? 14 : 16),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: isMobile ? 20 : 100,
                            ),
                            //container with favt items

                            isDesktop
                                ? Container(
                                    // height: 500,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colors.grey.shade200),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              child: Center(
                                                child: Text(
                                                  "Image",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              height: screenHeight * 0.085,
                                              width: screenWidth * 0.15,
                                              color: Colors.green.shade200,
                                            ),
                                            SizedBox(
                                              width: 1,
                                            ),
                                            Container(
                                              height: screenHeight * 0.085,
                                              width: screenWidth * 0.3,
                                              child: Center(
                                                child: Text(
                                                  "Product Name",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              color: Colors.green.shade200,
                                            ),
                                            SizedBox(
                                              width: 1,
                                            ),
                                            Container(
                                              height: screenHeight * 0.085,
                                              width: screenWidth * 0.15,
                                              child: Center(
                                                child: Text(
                                                  "Stock Status",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              color: Colors.green.shade200,
                                            ),
                                            SizedBox(
                                              width: 1,
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: screenHeight * 0.085,
                                                // width: screenWidth * 0.075,
                                                child: Center(
                                                  child: Text(
                                                    "Unit Price",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                color: Colors.green.shade200,
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                          height: 10,
                                        ),
                                        //list of favourite items
                                        ListView.builder(
                                          padding: EdgeInsets.only(
                                              top: 15, right: 10),
                                          itemCount: 2,
                                          physics: ScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                //image
                                                Container(
                                                  height: screenHeight * (0.2),
                                                  width: screenWidth * (0.165),
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          fit: BoxFit.contain,
                                                          image: NetworkImage(
                                                              "https://rukminim2.flixcart.com/image/850/1000/l1nwnm80/spice-masala/m/h/z/100-sambar-powder-1-pouch-kitchen-treasures-powder-original-imagd6knzpdyhnwp.jpeg?q=90&crop=false"))),
                                                ),
                                                //item name

                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Curry Powders",
                                                      style: TextStyle(
                                                          color: Colors.orange,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      "Sambar Powder 99gm",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(),

                                                //stockbox
                                                Container(
                                                  padding: EdgeInsets.all(5),
                                                  child: Center(
                                                    child: Text(
                                                      "In Stock",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade400,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                ),
                                                SizedBox(),

                                                //unit price row
                                                Row(
                                                  children: [
                                                    //price
                                                    Text(
                                                      "7.38",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),

                                                    //addtocart button
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      height: 35,
                                                      child: Text(
                                                        "Add to Cart",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      decoration: BoxDecoration(
                                                          color: Colors.orange,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Container(
                                                      height: 35,
                                                      width: 35,
                                                      child: Icon(
                                                        Icons.close,
                                                        color: Colors.black,
                                                      ),
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .grey.shade400,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 1,
                                                )
                                              ],
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  )
                                : //other devices

                                Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: isTablet ? 20 : 5),
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.grey.shade200)),
                                          child: ListView.builder(
                                            itemCount: 4,
                                            shrinkWrap: true,
                                            physics: ScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  //image
                                                  Container(
                                                    height: screenHeight * 0.2,
                                                    width: screenWidth *
                                                        (isTablet
                                                            ? 0.165
                                                            : 0.25),
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            fit: BoxFit.fill,
                                                            image: NetworkImage(
                                                                "https://rukminim2.flixcart.com/image/850/1000/l1nwnm80/spice-masala/m/h/z/100-sambar-powder-1-pouch-kitchen-treasures-powder-original-imagd6knzpdyhnwp.jpeg?q=90&crop=false"))),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "Curry Powders",
                                                    style: TextStyle(
                                                        color: Colors.orange,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    "Sambar Powder 99gm",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  //stockbox
                                                  Container(
                                                    width: 80,
                                                    padding: EdgeInsets.all(5),
                                                    child: Center(
                                                      child: Text(
                                                        "In Stock",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                        color: Colors
                                                            .grey.shade400,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  //unit price row
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      //price
                                                      Text(
                                                        "7.38",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),

                                                      //addtocart button
                                                      Container(
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        height: 35,
                                                        child: Text(
                                                          "Add to Cart",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        decoration: BoxDecoration(
                                                            color:
                                                                Colors.orange,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Container(
                                                        height: 35,
                                                        width: 35,
                                                        child: Icon(
                                                          Icons.close,
                                                          color: Colors.black,
                                                        ),
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .grey.shade400,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  )
                                                ],
                                              );
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),

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
                                    Container(
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
                                              bottomRight: Radius.circular(5))),
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
