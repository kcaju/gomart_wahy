import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gomart_wahy/dummy_db.dart';
import 'package:gomart_wahy/view/homescreen/drawerscreen/drawer_screen.dart';
import 'package:gomart_wahy/view/homescreen/widget/header_greencard.dart';
import 'package:gomart_wahy/view/homescreen/widget/header_whitebox.dart';
import 'package:gomart_wahy/view/homescreen/widget/shop_and_about_button.dart';
import 'package:gomart_wahy/view/homescreen/widget/topoffer_card.dart';
import 'package:gomart_wahy/view/homescreen/widget/trendingproducts_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
      endDrawer: DrawerScreen(),
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
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * (isDesktop ? 0.04 : 0.01),
                        vertical: screenHeight * (isDesktop ? 0.2 : 0.07)),
                    child: Column(
                      crossAxisAlignment: isDesktop
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.center,
                      children: [
                        //for desktop
                        isDesktop
                            ? Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Gomart",
                                          style: TextStyle(
                                              color: Color(0xFF03AC13),
                                              fontSize: 110,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          "Online Fresh",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 35,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "Vegetables",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 35,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          "Assertively target market-driven intellectual capital with worldwide human capital holistic.",
                                          style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            ShopAndAboutButton(
                                                text: "Shop Now",
                                                buttonColor: Colors.orange),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            ShopAndAboutButton(
                                                text: "About Us",
                                                buttonColor: Color(0xFF03AC13)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  //changing image
                                  Expanded(
                                    child: Image.asset(
                                      "assets/png/vegbag.png",
                                      height: 400,
                                    ),
                                  ),
                                ],
                              )
                            //for other devices
                            : Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      screenWidth * (isTablet ? 0.04 : 0.01),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Gomart",
                                      style: TextStyle(
                                          color: Color(0xFF03AC13),
                                          fontSize: 110,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "Online Fresh",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 35,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Vegetables",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 35,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "Assertively target market-driven intellectual capital with worldwide human capital holistic.",
                                      style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        ShopAndAboutButton(
                                            text: "Shop Now",
                                            buttonColor: Colors.orange),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        ShopAndAboutButton(
                                            text: "About Us",
                                            buttonColor: Color(0xFF03AC13)),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    isTablet
                                        ? Center(
                                            child: Image.asset(
                                              "assets/png/vegbag.png",
                                              height: 500,
                                            ),
                                          )
                                        : Image.asset(
                                            "assets/png/vegbag.png",
                                            height: 400,
                                          ),
                                  ],
                                ),
                              ),
                        SizedBox(
                          height: 100,
                        ),
                        //top category
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * (isTablet ? 0.04 : 0.01),
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 40),
                            child: Column(
                              children: [
                                Text(
                                  "Our Top Category",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CarouselSlider(
                                  items: List.generate(
                                    4,
                                    (index) {
                                      return SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: List.generate(
                                            5,
                                            (index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Container(
                                                  width: 250,
                                                  padding: EdgeInsets.all(20),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                              color:
                                                                  Colors.green,
                                                              width: 2),
                                                        ),
                                                        child: CircleAvatar(
                                                          radius: 70,
                                                          backgroundImage:
                                                              AssetImage(
                                                                  "assets/png/vegbag.png"),
                                                        ),
                                                      ),
                                                      Text(
                                                        "Vegetables",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Colors
                                                            .grey.shade300,
                                                      ),
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  options: CarouselOptions(
                                    height: 240,
                                    autoPlay: true,
                                    autoPlayInterval: Duration(seconds: 5),
                                    // aspectRatio: 2.0,
                                    viewportFraction: 1.0,
                                  ),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey.shade300,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        //most populAR brands
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * (isTablet ? 0.04 : 0.01),
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey.shade300,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "The Most Popular Brands",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                CarouselSlider(
                                  items: List.generate(
                                    4,
                                    (index) {
                                      return SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: List.generate(
                                            5,
                                            (index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Container(
                                                  width: 250,
                                                  padding: EdgeInsets.all(20),
                                                  child: Image.asset(
                                                    "assets/png/dh.png",
                                                  ),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Colors
                                                            .grey.shade300,
                                                      ),
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  options: CarouselOptions(
                                    height: 240,
                                    autoPlay: true,
                                    autoPlayInterval: Duration(seconds: 5),
                                    // aspectRatio: 2.0,
                                    viewportFraction: 1.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        //top trending products
                        Text(
                          "Top Trending Products",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        CarouselSlider(
                          items: List.generate(
                            4,
                            (index) {
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(
                                    5,
                                    (index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: TrendingproductsCard(
                                            count: "9",
                                            url:
                                                "https://rukminim2.flixcart.com/image/720/864/l1nwnm80/spice-masala/m/h/z/100-sambar-powder-1-pouch-kitchen-treasures-powder-original-imagd6knzpdyhnwp.jpeg?q=60&crop=false",
                                            title: "Fresh Oragnic",
                                            name: "Sambar Powder",
                                            oldRate: "\$ 3.55",
                                            newRate: "\$ 3.69"),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                          options: CarouselOptions(
                            height: 570,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 5),
                            // aspectRatio: 2.0,
                            viewportFraction: 1.0,
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        //fresh vegetables
                        Text(
                          "Fresh Vegetables",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        CarouselSlider(
                          items: List.generate(
                            4,
                            (index) {
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(
                                    5,
                                    (index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: TrendingproductsCard(
                                            url:
                                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdxHhS9OGZcFxxbP5-0Gfb-DMs3QKi9QaGRw&s",
                                            title: "Fresh Organic",
                                            name: "Brinjal",
                                            oldRate: "\$ 2.5",
                                            newRate: "\$ 3.08",
                                            count: "10"),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                          options: CarouselOptions(
                            height: 570,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 5),
                            // aspectRatio: 2.0,
                            viewportFraction: 1.0,
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        //fresh meats
                        Text(
                          "Fresh Meats",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        CarouselSlider(
                          items: List.generate(
                            4,
                            (index) {
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(
                                    5,
                                    (index) {
                                      return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 15),
                                          child: TrendingproductsCard(
                                              url:
                                                  "https://cdn.pixabay.com/photo/2010/12/10/08/chicken-1140_1280.jpg",
                                              title: "Fresh Organic",
                                              name: "Chicken",
                                              oldRate: "\$ 5.5",
                                              newRate: "\$ 6.77",
                                              count: "18"));
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                          options: CarouselOptions(
                            height: 570,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 5),
                            // aspectRatio: 2.0,
                            viewportFraction: 1.0,
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        //top & weekly offer
                        isDesktop
                            ? SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(
                                    DummyDb.items.length,
                                    (index) {
                                      return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 25),
                                          child: TopofferCard(
                                              offer: DummyDb.items[index]
                                                  ['offer'],
                                              url: DummyDb.items[index]
                                                  ['image'],
                                              color: DummyDb.items[index]
                                                  ['color']));
                                    },
                                  ),
                                ),
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  children: List.generate(
                                    DummyDb.items.length,
                                    (index) {
                                      return Column(
                                        children: [
                                          TopofferCard(
                                              offer: DummyDb.items[index]
                                                  ['offer'],
                                              url: DummyDb.items[index]
                                                  ['image'],
                                              color: DummyDb.items[index]
                                                  ['color']),
                                          SizedBox(
                                            height: 20,
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 100,
                        ),
                        //weekly best deals
                        isDesktop
                            ? SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 50),
                                          height: screenHeight * 0.5,
                                          width: screenWidth * 0.25,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "100% Oraginc Vegetables",
                                                style: TextStyle(
                                                    color: Colors.orange,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "Vegetable",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "Fresh & Healthy",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Text(
                                                "None",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              //shopnow button
                                              ShopAndAboutButton(
                                                  isWidth: true,
                                                  text: "Shop Now",
                                                  buttonColor:
                                                      Color(0xFF03AC13)),
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                              color: Colors.greenAccent,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                        Positioned(
                                            bottom: 0,
                                            right: 0,
                                            left: 0,
                                            child: Image.asset(
                                              "assets/png/vegie.png",
                                            ))
                                      ],
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    DottedBorder(
                                        strokeWidth: 2.0,
                                        strokeCap: StrokeCap.butt,
                                        radius: Radius.circular(20),
                                        color: Colors.orange,
                                        child: Container(
                                          width: screenWidth * 0.55,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Weekly Best Deals",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: Row(
                                                  children: List.generate(
                                                    4,
                                                    (index) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .orange)),
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                "00",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                              Text(
                                                                "Days",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )),
                                  ],
                                ),
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: [
                                    DottedBorder(
                                        strokeWidth: 2.0,
                                        strokeCap: StrokeCap.butt,
                                        radius: Radius.circular(20),
                                        color: Colors.orange,
                                        child: Container(
                                          width: screenWidth * 0.9,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 8),
                                          child: isMobile
                                              ? Column(
                                                  children: [
                                                    Text(
                                                      "Weekly Best Deals",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: List.generate(
                                                          4,
                                                          (index) {
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5.0),
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5),
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .orange)),
                                                                child: Column(
                                                                  children: [
                                                                    Text(
                                                                      "00",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              16),
                                                                    ),
                                                                    Text(
                                                                      "Days",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              14),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Weekly Best Deals",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      child: Row(
                                                        children: List.generate(
                                                          4,
                                                          (index) {
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5.0),
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5),
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .orange)),
                                                                child: Column(
                                                                  children: [
                                                                    Text(
                                                                      "00",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              16),
                                                                    ),
                                                                    Text(
                                                                      "Days",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              14),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                        )),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    //vegetable fresh healthy card
                                    Stack(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 50),
                                          height: isTablet
                                              ? screenHeight * 0.3
                                              : screenHeight * 0.5,
                                          width: double.infinity,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "100% Oraginc Vegetables",
                                                style: TextStyle(
                                                    color: Colors.orange,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "Vegetable",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "Fresh & Healthy",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Text(
                                                "None",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              //shopnow button
                                              ShopAndAboutButton(
                                                  isWidth: true,
                                                  text: "Shop Now",
                                                  buttonColor:
                                                      Color(0xFF03AC13)),
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                              color: Colors.greenAccent,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                        Positioned(
                                            bottom: 0,
                                            right: 0,
                                            left: 0,
                                            child: Image.asset(
                                              "assets/png/vegie.png",
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                        SizedBox(
                          height: 100,
                        ),
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
