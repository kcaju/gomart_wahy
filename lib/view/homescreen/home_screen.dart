import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gomart_wahy/dummy_db.dart';
import 'package:gomart_wahy/view/about_us_page/aboutus_page.dart';
import 'package:gomart_wahy/view/account_page/account_page.dart';
import 'package:gomart_wahy/view/all_products/all_productscreen.dart';
import 'package:gomart_wahy/view/cartpage/cartitems_page.dart';
import 'package:gomart_wahy/view/floatingactionbutton/custom_floatingbutton.dart';
import 'package:gomart_wahy/view/homescreen/drawerscreen/category_drawerscreen.dart';
import 'package:gomart_wahy/view/homescreen/drawerscreen/drawer_screen.dart';
import 'package:gomart_wahy/view/homescreen/widget/header_greencard.dart';
import 'package:gomart_wahy/view/homescreen/widget/header_whitebox.dart';
import 'package:gomart_wahy/view/homescreen/widget/homepage.dart';
import 'package:gomart_wahy/view/homescreen/widget/new_and_organic_items_card.dart';
import 'package:gomart_wahy/view/homescreen/widget/shop_and_about_button.dart';
import 'package:gomart_wahy/view/homescreen/widget/topoffer_card.dart';
import 'package:gomart_wahy/view/homescreen/widget/trendingproducts_card.dart';
import 'package:gomart_wahy/view/product_details/product_detailspage.dart';
import 'package:gomart_wahy/view/shopbycategory_screen/category_screen.dart';
import 'package:gomart_wahy/view/wishlist_page/wish_listpage.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Determine screen type based on width
    bool isMobile = screenWidth < 600;
    bool isTablet = screenWidth >= 600 && screenWidth <= 1024;
    bool isDesktop = screenWidth > 1024;

    // Get Firestore instance
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    return Scaffold(
      drawer: CategoryDrawerscreen(),
      endDrawer: DrawerScreen(),
      floatingActionButton: isMobile
          ? Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomFloatingbutton(),
                SizedBox(
                  height: 60,
                )
              ],
            )
          : CustomFloatingbutton(),
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
                                              "Online Home",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 35,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "Requirements",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 35,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              "Empower global human capital with innovative, market-focused solutions for seamless home requirements.",
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
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              AllProductscreen(),
                                                        ));
                                                  },
                                                  child: ShopAndAboutButton(
                                                      text: "Shop Now",
                                                      buttonColor:
                                                          Colors.orange),
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    //to about us page
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              AboutusPage(),
                                                        ));
                                                  },
                                                  child: ShopAndAboutButton(
                                                      text: "About Us",
                                                      buttonColor:
                                                          Color(0xFF03AC13)),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      //changing image
                                      Expanded(
                                        child: Image.asset(
                                          "assets/png/home-appliances.jpg",
                                          height: 400,
                                        ),
                                      ),
                                    ],
                                  )
                                //for other devices
                                : Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth *
                                          (isTablet ? 0.04 : 0.01),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Gomart",
                                          style: TextStyle(
                                              color: Color(0xFF03AC13),
                                              fontSize: isMobile ? 100 : 110,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          "Online Home",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 35,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "Requirements",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 35,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          "Empower global human capital with innovative, market-focused solutions for seamless home requirements.",
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
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          AllProductscreen(),
                                                    ));
                                              },
                                              child: ShopAndAboutButton(
                                                  text: "Shop Now",
                                                  buttonColor: Colors.orange),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                //to about us page
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          AboutusPage(),
                                                    ));
                                              },
                                              child: ShopAndAboutButton(
                                                  text: "About Us",
                                                  buttonColor:
                                                      Color(0xFF03AC13)),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        isTablet
                                            ? Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Image.asset(
                                                    "assets/png/home-appliances.jpg",
                                                    height: 500,
                                                  ),
                                                ),
                                              )
                                            : Image.asset(
                                                "assets/png/home-appliances.jpg",
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
                                horizontal:
                                    screenWidth * (isTablet ? 0.04 : 0.01),
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
                                    isMobile
                                        ? StreamBuilder<QuerySnapshot>(
                                            stream: firestore
                                                .collection("Categories")
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return const Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              }

                                              if (!snapshot.hasData ||
                                                  snapshot.data!.docs.isEmpty) {
                                                return const Center(
                                                    child: Text(
                                                        "No Categories found."));
                                              }

                                              final List<QueryDocumentSnapshot>
                                                  documents =
                                                  snapshot.data!.docs;

                                              return CarouselSlider(
                                                items: documents
                                                    .map((categoryDoc) {
                                                  final categoryName =
                                                      categoryDoc[
                                                          'categoryName'];
                                                  final categoryUrl =
                                                      categoryDoc[
                                                          'categoryUrl'];
                                                  final products =
                                                      categoryDoc['products'];

                                                  return GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              CategoryScreen(
                                                            products: products,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      width: 250,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              20),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors
                                                                .grey.shade300),
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8),
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .green,
                                                                  width: 2),
                                                            ),
                                                            child: CircleAvatar(
                                                              radius: 70,
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                      categoryUrl),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 10),
                                                          Text(
                                                            categoryName,
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                                options: CarouselOptions(
                                                  height: 300,
                                                  autoPlay: true,
                                                  autoPlayInterval:
                                                      const Duration(
                                                          seconds: 5),
                                                  viewportFraction:
                                                      0.8, // Adjust to show part of the next item
                                                  enlargeCenterPage:
                                                      true, // Makes the focused item larger
                                                ),
                                              );
                                            },
                                          )
                                        : StreamBuilder<QuerySnapshot>(
                                            stream: firestore
                                                .collection("Categories")
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return const Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              }

                                              if (!snapshot.hasData ||
                                                  snapshot.data!.docs.isEmpty) {
                                                return const Center(
                                                    child: Text(
                                                        "No Categories found."));
                                              }

                                              final List<QueryDocumentSnapshot>
                                                  documents =
                                                  snapshot.data!.docs;

                                              return CarouselSlider(
                                                items: List.generate(
                                                  documents
                                                      .length, // Change this to documents.length to display all items
                                                  (index) {
                                                    final categories =
                                                        documents[index];
                                                    final products =
                                                        categories['products'];
                                                    return SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: Row(
                                                        children: List.generate(
                                                          documents.length,
                                                          (index) {
                                                            final categories =
                                                                documents[
                                                                    index];
                                                            final products =
                                                                categories[
                                                                    'products'];
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      right:
                                                                          15),
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              CategoryScreen(
                                                                        products:
                                                                            products,
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 250,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              20),
                                                                  child: Column(
                                                                    children: [
                                                                      Container(
                                                                        padding:
                                                                            EdgeInsets.all(8),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          shape:
                                                                              BoxShape.circle,
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Colors.green,
                                                                            width:
                                                                                2,
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            CircleAvatar(
                                                                          radius:
                                                                              70,
                                                                          backgroundImage:
                                                                              NetworkImage(
                                                                            categories['categoryUrl'],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        categories[
                                                                            'categoryName'],
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade300,
                                                                    ),
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                ),
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
                                                  autoPlayInterval:
                                                      Duration(seconds: 5),
                                                  viewportFraction: 1.0,
                                                ),
                                              );
                                            },
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
                                horizontal:
                                    screenWidth * (isTablet ? 0.04 : 0.01),
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
                                    StreamBuilder<QuerySnapshot>(
                                      stream: firestore
                                          .collection("Brands")
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }

                                        if (!snapshot.hasData ||
                                            snapshot.data!.docs.isEmpty) {
                                          return const Center(
                                              child: Text("No Brands found."));
                                        }

                                        final List<QueryDocumentSnapshot>
                                            documents = snapshot.data!.docs;
                                        return CarouselSlider(
                                          items: List.generate(
                                            4,
                                            (index) {
                                              return SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  children: List.generate(
                                                    documents.length,
                                                    (index) {
                                                      final brands =
                                                          documents[index];
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right: 15),
                                                        child: Container(
                                                          width: 250,
                                                          padding:
                                                              EdgeInsets.all(
                                                                  20),
                                                          child: Image.network(
                                                            brands['brandUrl'],
                                                            height: 150,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade300,
                                                                  ),
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
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
                                            autoPlayInterval:
                                                Duration(seconds: 5),
                                            // aspectRatio: 2.0,
                                            viewportFraction: 1.0,
                                          ),
                                        );
                                      },
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
                            StreamBuilder<QuerySnapshot>(
                              stream:
                                  firestore.collection("Products").snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }

                                if (!snapshot.hasData ||
                                    snapshot.data!.docs.isEmpty) {
                                  return const Center(
                                      child: Text("No Brands found."));
                                }

                                final List<QueryDocumentSnapshot> documents =
                                    snapshot.data!.docs;
                                return CarouselSlider(
                                  items: List.generate(
                                    4,
                                    (index) {
                                      return SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: List.generate(
                                            documents.length,
                                            (index) {
                                              final product = documents[index];
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              ProductDetailspage(
                                                            products: product,
                                                          ),
                                                        ));
                                                  },
                                                  child: TrendingproductsCard(
                                                      addToFavourite: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  WishListpage(),
                                                            ));
                                                      },
                                                      isProducts: true,
                                                      url:
                                                          product['productUrl'],
                                                      maxcount:
                                                          product['openstock'],
                                                      title: product[
                                                          'productName'],
                                                      name: product['category'],
                                                      oldRate: product[
                                                          'originalPrice'],
                                                      newRate:
                                                          product['ourPrice'],
                                                      count: product[
                                                          'currentstock']),
                                                ),
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
                                );
                              },
                            ),
                            SizedBox(
                              height: 100,
                            ),
                            //our products
                            Text(
                              "Our Products",
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
                            StreamBuilder<QuerySnapshot>(
                              stream:
                                  firestore.collection("Products").snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }

                                if (!snapshot.hasData ||
                                    snapshot.data!.docs.isEmpty) {
                                  return const Center(
                                      child: Text("No Products found."));
                                }

                                final List<QueryDocumentSnapshot> documents =
                                    snapshot.data!.docs;
                                return CarouselSlider(
                                  items: List.generate(
                                    4,
                                    (index) {
                                      return SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: List.generate(
                                            documents.length,
                                            (index) {
                                              final product = documents[index];
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              ProductDetailspage(
                                                            products: product,
                                                          ),
                                                        ));
                                                  },
                                                  child: TrendingproductsCard(
                                                      addToFavourite: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  WishListpage(),
                                                            ));
                                                      },
                                                      isProducts: true,
                                                      url:
                                                          product['productUrl'],
                                                      maxcount:
                                                          product['openstock'],
                                                      title: product[
                                                          'productName'],
                                                      name: product['category'],
                                                      oldRate: product[
                                                          'originalPrice'],
                                                      newRate:
                                                          product['ourPrice'],
                                                      count: product[
                                                          'currentstock']),
                                                ),
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
                                );
                              },
                            ),
                            SizedBox(
                              height: 100,
                            ),
                            //random products
                            Text(
                              "Random Products",
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
                            StreamBuilder<QuerySnapshot>(
                              stream:
                                  firestore.collection("Products").snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }

                                if (!snapshot.hasData ||
                                    snapshot.data!.docs.isEmpty) {
                                  return const Center(
                                      child: Text("No products found."));
                                }

                                final List<QueryDocumentSnapshot> documents =
                                    snapshot.data!.docs;
                                return CarouselSlider(
                                  items: List.generate(
                                    4,
                                    (index) {
                                      return SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: List.generate(
                                            documents.length,
                                            (index) {
                                              final product = documents[index];
                                              return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 15),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                ProductDetailspage(
                                                              products: product,
                                                            ),
                                                          ));
                                                    },
                                                    child: TrendingproductsCard(
                                                        addToFavourite: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        WishListpage(),
                                                              ));
                                                        },
                                                        isProducts: true,
                                                        url: product[
                                                            'productUrl'],
                                                        maxcount: product[
                                                            'openstock'],
                                                        title: product[
                                                            'productName'],
                                                        name:
                                                            product['category'],
                                                        oldRate: product[
                                                            'originalPrice'],
                                                        newRate:
                                                            product['ourPrice'],
                                                        count: product[
                                                            'currentstock']),
                                                  ));
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
                                );
                              },
                            ),
                            SizedBox(
                              height: 100,
                            ),
                            //top & weekly offer
                            isDesktop
                                ? SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        StreamBuilder<QuerySnapshot>(
                                          stream: firestore
                                              .collection("Poster1")
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            }

                                            if (!snapshot.hasData ||
                                                snapshot.data!.docs.isEmpty) {
                                              return const Center(
                                                  child:
                                                      Text("No poster found."));
                                            }

                                            final poster =
                                                snapshot.data!.docs.first;
                                            return TopofferCard(
                                                heading1: poster['heading1'],
                                                heading2: poster['heading2'],
                                                offer: "Top offers",
                                                url: poster['posterUrl'],
                                                color: Colors.orange);
                                          },
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        StreamBuilder<QuerySnapshot>(
                                          stream: firestore
                                              .collection("Poster2")
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            }

                                            if (!snapshot.hasData ||
                                                snapshot.data!.docs.isEmpty) {
                                              return const Center(
                                                  child:
                                                      Text("No poster found."));
                                            }

                                            final poster =
                                                snapshot.data!.docs.first;
                                            return TopofferCard(
                                                heading1: poster['heading1'],
                                                heading2: poster['heading2'],
                                                offer: "Weekly offers",
                                                url: poster['posterUrl'],
                                                color: Colors.green);
                                          },
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        StreamBuilder<QuerySnapshot>(
                                          stream: firestore
                                              .collection("Poster3")
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            }

                                            if (!snapshot.hasData ||
                                                snapshot.data!.docs.isEmpty) {
                                              return const Center(
                                                  child:
                                                      Text("No poster found."));
                                            }

                                            final poster =
                                                snapshot.data!.docs.first;
                                            return TopofferCard(
                                                heading1: poster['heading1'],
                                                heading2: poster['heading2'],
                                                offer: "Top offers",
                                                url: poster['posterUrl'],
                                                color: Colors.red);
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                                //other devices
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Column(
                                      children: [
                                        StreamBuilder<QuerySnapshot>(
                                          stream: firestore
                                              .collection("Poster1")
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            }

                                            if (!snapshot.hasData ||
                                                snapshot.data!.docs.isEmpty) {
                                              return const Center(
                                                  child:
                                                      Text("No poster found."));
                                            }

                                            final poster =
                                                snapshot.data!.docs.first;
                                            return TopofferCard(
                                                heading1: poster['heading1'],
                                                heading2: poster['heading2'],
                                                offer: "Top offers",
                                                url: poster['posterUrl'],
                                                color: Colors.orange);
                                          },
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        StreamBuilder<QuerySnapshot>(
                                          stream: firestore
                                              .collection("Poster2")
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            }

                                            if (!snapshot.hasData ||
                                                snapshot.data!.docs.isEmpty) {
                                              return const Center(
                                                  child:
                                                      Text("No poster found."));
                                            }

                                            final poster =
                                                snapshot.data!.docs.first;
                                            return TopofferCard(
                                                heading1: poster['heading1'],
                                                heading2: poster['heading2'],
                                                offer: "Weekly offers",
                                                url: poster['posterUrl'],
                                                color: Colors.green);
                                          },
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        StreamBuilder<QuerySnapshot>(
                                          stream: firestore
                                              .collection("Poster3")
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            }

                                            if (!snapshot.hasData ||
                                                snapshot.data!.docs.isEmpty) {
                                              return const Center(
                                                  child:
                                                      Text("No poster found."));
                                            }

                                            final poster =
                                                snapshot.data!.docs.first;
                                            return TopofferCard(
                                                heading1: poster['heading1'],
                                                heading2: poster['heading2'],
                                                offer: "Top offers",
                                                url: poster['posterUrl'],
                                                color: Colors.red);
                                          },
                                        ),
                                      ],
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
                                        StreamBuilder<QuerySnapshot>(
                                          stream: firestore
                                              .collection("Poster4")
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            }

                                            if (!snapshot.hasData ||
                                                snapshot.data!.docs.isEmpty) {
                                              return const Center(
                                                  child:
                                                      Text("No poster found."));
                                            }

                                            final poster =
                                                snapshot.data!.docs.first;
                                            return Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 50),
                                              height: screenHeight * 0.5,
                                              width: screenWidth * 0.25,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    poster['subtitle'],
                                                    style: TextStyle(
                                                        color: Colors.orange,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    poster['heading1'],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    poster['heading2'],
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
                                                  GestureDetector(
                                                    onTap: () {
                                                      // Navigator.push(
                                                      //     context,
                                                      //     MaterialPageRoute(
                                                      //       builder: (context) =>
                                                      //           CategoryScreen(),
                                                      //     ));
                                                    },
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        // Navigator.push(
                                                        //     context,
                                                        //     MaterialPageRoute(
                                                        //       builder: (context) =>
                                                        //           CategoryScreen(),
                                                        //     ));
                                                      },
                                                      child: ShopAndAboutButton(
                                                          isWidth: true,
                                                          text: "Show Now",
                                                          buttonColor: Color(
                                                              0xFF03AC13)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              decoration: BoxDecoration(
                                                  color: Colors.greenAccent,
                                                  image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: NetworkImage(
                                                          poster['posterUrl'])),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            );
                                          },
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
                                                                  EdgeInsets
                                                                      .all(10),
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
                                : //other devices
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
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
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children:
                                                                List.generate(
                                                              4,
                                                              (index) {
                                                                return Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          5.0),
                                                                  child:
                                                                      Container(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            10),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                5),
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.orange)),
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Text(
                                                                          "00",
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 16),
                                                                        ),
                                                                        Text(
                                                                          "Days",
                                                                          style: TextStyle(
                                                                              color: Colors.grey,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 14),
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
                                                    ) //tablet
                                                  : Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Weekly Best Deals",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          child: Row(
                                                            children:
                                                                List.generate(
                                                              4,
                                                              (index) {
                                                                return Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          5.0),
                                                                  child:
                                                                      Container(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            10),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                5),
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.orange)),
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Text(
                                                                          "00",
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 16),
                                                                        ),
                                                                        Text(
                                                                          "Days",
                                                                          style: TextStyle(
                                                                              color: Colors.grey,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 14),
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
                                        StreamBuilder<QuerySnapshot>(
                                          stream: firestore
                                              .collection("Poster4")
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            }

                                            if (!snapshot.hasData ||
                                                snapshot.data!.docs.isEmpty) {
                                              return const Center(
                                                  child:
                                                      Text("No poster found."));
                                            }

                                            final poster =
                                                snapshot.data!.docs.first;
                                            return Container(
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
                                                    poster['subtitle'],
                                                    style: TextStyle(
                                                        color: Colors.orange,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    poster['heading1'],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    poster['heading2'],
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
                                                  GestureDetector(
                                                    onTap: () {
                                                      // Navigator.push(
                                                      //     context,
                                                      //     MaterialPageRoute(
                                                      //       builder: (context) =>
                                                      //           CategoryScreen(),
                                                      //     ));
                                                    },
                                                    child: ShopAndAboutButton(
                                                        isWidth: true,
                                                        text: "Show Now",
                                                        buttonColor:
                                                            Color(0xFF03AC13)),
                                                  ),
                                                ],
                                              ),
                                              decoration: BoxDecoration(
                                                  color: Colors.greenAccent,
                                                  image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: NetworkImage(
                                                          poster['posterUrl'])),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                            SizedBox(
                              height: 80,
                            ),
                            //dum biriyani ad
                            isDesktop
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      StreamBuilder<QuerySnapshot>(
                                        stream: firestore
                                            .collection("Poster5")
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          }

                                          if (!snapshot.hasData ||
                                              snapshot.data!.docs.isEmpty) {
                                            return const Center(
                                                child:
                                                    Text("No poster found."));
                                          }

                                          final poster =
                                              snapshot.data!.docs.first;
                                          return Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 30, vertical: 50),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    // Navigator.push(
                                                    //     context,
                                                    //     MaterialPageRoute(
                                                    //       builder: (context) =>
                                                    //           CategoryScreen(),
                                                    //     ));
                                                  },
                                                  child: ShopAndAboutButton(
                                                    text: "Shop Now",
                                                    buttonColor: Colors.orange,
                                                    isWidth: true,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            height: screenHeight * 0.4,
                                            width: screenWidth * 0.6,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                      poster['posterUrl'])),
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        width: 25,
                                      ),
                                      //ads box
                                      StreamBuilder<QuerySnapshot>(
                                        stream: firestore
                                            .collection("Poster6")
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          }

                                          if (!snapshot.hasData ||
                                              snapshot.data!.docs.isEmpty) {
                                            return const Center(
                                                child:
                                                    Text("No poster found."));
                                          }

                                          final poster =
                                              snapshot.data!.docs.first;
                                          return Container(
                                            height: screenHeight * 0.4,
                                            width: screenWidth * 0.25,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey.shade400),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      poster['posterUrl'])),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  )
                                : //for other devices
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Column(
                                      children: [
                                        //dum biriani card
                                        StreamBuilder<QuerySnapshot>(
                                          stream: firestore
                                              .collection("Poster5")
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            }

                                            if (!snapshot.hasData ||
                                                snapshot.data!.docs.isEmpty) {
                                              return const Center(
                                                  child:
                                                      Text("No poster found."));
                                            }

                                            final poster =
                                                snapshot.data!.docs.first;
                                            return Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 30, vertical: 50),
                                              child: //shopnow button
                                                  Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      // Navigator.push(
                                                      //     context,
                                                      //     MaterialPageRoute(
                                                      //       builder: (context) =>
                                                      //           CategoryScreen(),
                                                      //     ));
                                                    },
                                                    child: ShopAndAboutButton(
                                                      text: "Shop Now",
                                                      buttonColor:
                                                          Colors.orange,
                                                      isWidth: true,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              height: screenHeight *
                                                  (isTablet ? 0.25 : 0.3),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        poster['posterUrl'])),
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            );
                                          },
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        //gulab jamun ads box
                                        StreamBuilder<QuerySnapshot>(
                                          stream: firestore
                                              .collection("Poster6")
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            }

                                            if (!snapshot.hasData ||
                                                snapshot.data!.docs.isEmpty) {
                                              return const Center(
                                                  child:
                                                      Text("No poster found."));
                                            }

                                            final poster =
                                                snapshot.data!.docs.first;
                                            return Container(
                                              height: screenHeight *
                                                  (isTablet ? 0.25 : 0.3),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        Colors.grey.shade400),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        poster['posterUrl'])),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                            SizedBox(
                              height: 80,
                            ),
                            //what our clients say

                            Center(
                              child: Text(
                                "What Our Clients Say",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                              ),
                            ),

                            CarouselSlider(
                              items: List.generate(
                                DummyDb.clientsimage.length,
                                (index) {
                                  return CircleAvatar(
                                    radius: screenWidth * 0.1,
                                    child: Image.asset(
                                      DummyDb.clientsimage[index],
                                    ),
                                  );
                                },
                              ),
                              options: CarouselOptions(
                                height: isMobile
                                    ? screenHeight * 0.3
                                    : screenHeight * 0.2,
                                reverse: true,
                                autoPlay: true,
                                scrollPhysics: ClampingScrollPhysics(),
                                enlargeCenterPage: true,
                                autoPlayInterval: Duration(seconds: 3),
                                // aspectRatio: 16 / 9,
                                viewportFraction: isMobile
                                    ? 0.2
                                    : isTablet
                                        ? 0.1
                                        : 0.05,
                              ),
                            ),
                            //clients review slider
                            CarouselSlider(
                              items: List.generate(
                                5,
                                (index) {
                                  return Column(
                                    children: [
                                      Text(
                                        textAlign: TextAlign.center,
                                        "\"Distinctively unleash business technologies without backend metrics. Conveniently network distributed core competencies. Continually integrate backward-compatible information and backward-compatible.\"",
                                        style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Rasmus Geisler",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.black),
                                      )
                                    ],
                                  );
                                },
                              ),
                              options: CarouselOptions(
                                height: isMobile
                                    ? screenHeight * 0.3
                                    : screenHeight * 0.2,
                                autoPlay: true,
                                enlargeCenterPage: true,
                                scrollPhysics: ClampingScrollPhysics(),
                                autoPlayInterval: Duration(seconds: 3),
                                // aspectRatio: 16 / 9,
                                viewportFraction: 1.0,
                              ),
                            ),

                            //newproducts &  best seller
                            SizedBox(
                              height: 80,
                            ),

                            isDesktop
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //new products
                                      Container(
                                        width: screenWidth * 0.3,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 20),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  "New Products",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Spacer(),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              AllProductscreen(),
                                                        ));
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "View More",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.orange,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Icon(
                                                        Icons.arrow_forward,
                                                        color: Colors.orange,
                                                        size: 20,
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            StreamBuilder<QuerySnapshot>(
                                              stream: firestore
                                                  .collection("Products")
                                                  .limit(3)
                                                  .snapshots(),
                                              builder: (context, snapshot) {
                                                // Fetch only the first 3 products
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return const Center(
                                                      child:
                                                          CircularProgressIndicator());
                                                }

                                                if (!snapshot.hasData ||
                                                    snapshot
                                                        .data!.docs.isEmpty) {
                                                  return const Center(
                                                      child: Text(
                                                          "No products available."));
                                                }

                                                final products =
                                                    snapshot.data!.docs;
                                                return ListView.separated(
                                                    shrinkWrap: true,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    itemBuilder:
                                                        (context, index) {
                                                      final product =
                                                          products[index];
                                                      return GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        ProductDetailspage(
                                                                  products:
                                                                      product,
                                                                ),
                                                              ));
                                                        },
                                                        child:
                                                            NewAndOrganicItemsCard(
                                                                addToFavourite:
                                                                    () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                WishListpage(),
                                                                      ));
                                                                },
                                                                oldrate: product[
                                                                    'originalPrice'],
                                                                url: product[
                                                                    'productUrl'],
                                                                title: product[
                                                                    'productName'],
                                                                rate: product[
                                                                    'ourPrice']),
                                                      );
                                                    },
                                                    separatorBuilder:
                                                        (context, index) =>
                                                            SizedBox(
                                                              height: 8,
                                                            ),
                                                    itemCount: products.length);
                                              },
                                            )
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey.shade200)),
                                      ),
                                      //organic best seller
                                      Container(
                                        width: screenWidth * 0.3,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 20),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  "Bestseller",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Spacer(),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              AllProductscreen(),
                                                        ));
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "View More",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.orange,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Icon(
                                                        Icons.arrow_forward,
                                                        color: Colors.orange,
                                                        size: 20,
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            StreamBuilder<QuerySnapshot>(
                                              stream: firestore
                                                  .collection("Products")
                                                  .limit(3)
                                                  .snapshots(),
                                              builder: (context, snapshot) {
                                                // Fetch only the first 3 products
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return const Center(
                                                      child:
                                                          CircularProgressIndicator());
                                                }

                                                if (!snapshot.hasData ||
                                                    snapshot
                                                        .data!.docs.isEmpty) {
                                                  return const Center(
                                                      child: Text(
                                                          "No products available."));
                                                }

                                                final products =
                                                    snapshot.data!.docs;
                                                return ListView.separated(
                                                    shrinkWrap: true,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    itemBuilder:
                                                        (context, index) {
                                                      final product =
                                                          products[index];
                                                      return GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        ProductDetailspage(
                                                                  products:
                                                                      product,
                                                                ),
                                                              ));
                                                        },
                                                        child:
                                                            NewAndOrganicItemsCard(
                                                                addToFavourite:
                                                                    () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                WishListpage(),
                                                                      ));
                                                                },
                                                                oldrate: product[
                                                                    'originalPrice'],
                                                                url: product[
                                                                    'productUrl'],
                                                                title: product[
                                                                    'productName'],
                                                                rate: product[
                                                                    'ourPrice']),
                                                      );
                                                    },
                                                    separatorBuilder:
                                                        (context, index) =>
                                                            SizedBox(
                                                              height: 8,
                                                            ),
                                                    itemCount: products.length);
                                              },
                                            )
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey.shade200)),
                                      ),
                                      //vaccumclnr
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          StreamBuilder<QuerySnapshot>(
                                            stream: firestore
                                                .collection("Poster7")
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return const Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              }

                                              if (!snapshot.hasData ||
                                                  snapshot.data!.docs.isEmpty) {
                                                return const Center(
                                                    child: Text(
                                                        "No poster found."));
                                              }

                                              final poster =
                                                  snapshot.data!.docs.first;
                                              return Container(
                                                width: screenWidth * 0.2,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 15,
                                                      vertical: 15),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        poster['category'],
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            height: 30,
                                                            width: 50,
                                                            child: Center(
                                                              child: Text(
                                                                "Top",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    Colors.red,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            "30% Off",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontSize: 30,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          // Navigator.push(
                                                          //     context,
                                                          //     MaterialPageRoute(
                                                          //       builder:
                                                          //           (context) =>
                                                          //               CategoryScreen(),
                                                          //     ));
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              "Shop Now",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .green,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .arrow_forward,
                                                              size: 18,
                                                              color:
                                                                  Colors.green,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Container(
                                                        height: 150,
                                                        width: double.infinity,
                                                        decoration: BoxDecoration(
                                                            color: Colors.amber,
                                                            image: DecorationImage(
                                                                fit:
                                                                    BoxFit.fill,
                                                                image: NetworkImage(
                                                                    poster[
                                                                        'posterUrl'])),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade200),
                                                  color: Colors.white,
                                                ),
                                              );
                                            },
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          //product count
                                          Container(
                                            width: screenWidth * 0.2,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      height: 60,
                                                      width: 60,
                                                      child: Image.asset(
                                                          "assets/png/box.png"),
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .pink.shade50,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "6k+",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          "Total Products",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      height: 60,
                                                      width: 60,
                                                      child: Image.asset(
                                                          "assets/png/like.png"),
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .green.shade100,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                    ),
                                                    SizedBox(
                                                      width: 15,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "1M+",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          "Customer",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          "Satisfaction",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        Colors.grey.shade200),
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                : //other devices
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Column(
                                      children: [
                                        //new products
                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 20),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    "New Products",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Spacer(),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                AllProductscreen(),
                                                          ));
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "View More",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.orange,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Icon(
                                                          Icons.arrow_forward,
                                                          color: Colors.orange,
                                                          size: 20,
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              StreamBuilder<QuerySnapshot>(
                                                stream: firestore
                                                    .collection("Products")
                                                    .limit(3)
                                                    .snapshots(),
                                                builder: (context, snapshot) {
                                                  // Fetch only the first 3 products
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return const Center(
                                                        child:
                                                            CircularProgressIndicator());
                                                  }

                                                  if (!snapshot.hasData ||
                                                      snapshot
                                                          .data!.docs.isEmpty) {
                                                    return const Center(
                                                        child: Text(
                                                            "No products available."));
                                                  }

                                                  final products =
                                                      snapshot.data!.docs;
                                                  return ListView.separated(
                                                      shrinkWrap: true,
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      itemBuilder:
                                                          (context, index) {
                                                        final product =
                                                            products[index];
                                                        return GestureDetector(
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          ProductDetailspage(
                                                                    products:
                                                                        product,
                                                                  ),
                                                                ));
                                                          },
                                                          child:
                                                              NewAndOrganicItemsCard(
                                                                  addToFavourite:
                                                                      () {
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              WishListpage(),
                                                                        ));
                                                                  },
                                                                  oldrate: product[
                                                                      'originalPrice'],
                                                                  url: product[
                                                                      'productUrl'],
                                                                  title: product[
                                                                      'productName'],
                                                                  rate: product[
                                                                      'ourPrice']),
                                                        );
                                                      },
                                                      separatorBuilder:
                                                          (context, index) =>
                                                              SizedBox(
                                                                height: 8,
                                                              ),
                                                      itemCount:
                                                          products.length);
                                                },
                                              )
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey.shade200)),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        // best seller
                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 20),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    "Bestseller",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Spacer(),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                AllProductscreen(),
                                                          ));
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "View More",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.orange,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Icon(
                                                          Icons.arrow_forward,
                                                          color: Colors.orange,
                                                          size: 20,
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              StreamBuilder<QuerySnapshot>(
                                                stream: firestore
                                                    .collection("Products")
                                                    .limit(3)
                                                    .snapshots(),
                                                builder: (context, snapshot) {
                                                  // Fetch only the first 3 products
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return const Center(
                                                        child:
                                                            CircularProgressIndicator());
                                                  }

                                                  if (!snapshot.hasData ||
                                                      snapshot
                                                          .data!.docs.isEmpty) {
                                                    return const Center(
                                                        child: Text(
                                                            "No products available."));
                                                  }

                                                  final products =
                                                      snapshot.data!.docs;
                                                  return ListView.separated(
                                                      shrinkWrap: true,
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      itemBuilder:
                                                          (context, index) {
                                                        final product =
                                                            products[index];
                                                        return GestureDetector(
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          ProductDetailspage(
                                                                    products:
                                                                        product,
                                                                  ),
                                                                ));
                                                          },
                                                          child:
                                                              NewAndOrganicItemsCard(
                                                                  addToFavourite:
                                                                      () {
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              WishListpage(),
                                                                        ));
                                                                  },
                                                                  oldrate: product[
                                                                      'originalPrice'],
                                                                  url: product[
                                                                      'productUrl'],
                                                                  title: product[
                                                                      'productName'],
                                                                  rate: product[
                                                                      'ourPrice']),
                                                        );
                                                      },
                                                      separatorBuilder:
                                                          (context, index) =>
                                                              SizedBox(
                                                                height: 8,
                                                              ),
                                                      itemCount:
                                                          products.length);
                                                },
                                              )
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey.shade200)),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        //vaccumclnr
                                        StreamBuilder<QuerySnapshot>(
                                          stream: firestore
                                              .collection("Poster7")
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            }

                                            if (!snapshot.hasData ||
                                                snapshot.data!.docs.isEmpty) {
                                              return const Center(
                                                  child:
                                                      Text("No poster found."));
                                            }

                                            final poster =
                                                snapshot.data!.docs.first;
                                            return Container(
                                              width: screenWidth *
                                                  (isMobile ? 0.8 : 0.5),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15,
                                                        vertical: 15),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      poster['category'],
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          height: 30,
                                                          width: 50,
                                                          child: Center(
                                                            child: Text(
                                                              "Top",
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          decoration: BoxDecoration(
                                                              color: Colors.red,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          "30% Off",
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 30,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        // Navigator.push(
                                                        //     context,
                                                        //     MaterialPageRoute(
                                                        //       builder: (context) =>
                                                        //           CategoryScreen(),
                                                        //     ));
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "Shop Now",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .green,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Icon(
                                                            Icons.arrow_forward,
                                                            size: 18,
                                                            color: Colors.green,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Container(
                                                      height:
                                                          isMobile ? 150 : 200,
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                          color: Colors.amber,
                                                          image: DecorationImage(
                                                              fit: BoxFit.fill,
                                                              image: NetworkImage(
                                                                  poster[
                                                                      'posterUrl'])),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        Colors.grey.shade200),
                                                color: Colors.white,
                                              ),
                                            );
                                          },
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        //product count
                                        Container(
                                          width: screenWidth *
                                              (isMobile ? 0.8 : 0.5),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: 60,
                                                    width: 60,
                                                    child: Image.asset(
                                                        "assets/png/box.png"),
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Colors.pink.shade50,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "6k+",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        "Total Products",
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: 60,
                                                    width: 60,
                                                    child: Image.asset(
                                                        "assets/png/like.png"),
                                                    decoration: BoxDecoration(
                                                        color: Colors
                                                            .green.shade100,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "1M+",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        "Customer Satisfaction ",
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey.shade200),
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                      ],
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
                                    //subscribe button
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
          ),
          //mobile bottom tabbar
          isMobile
              ? Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    height: 70,
                    decoration: BoxDecoration(color: Colors.grey.shade200),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Builder(builder: (context) {
                          return GestureDetector(
                            onTap: () {
                              //open drawer
                              Scaffold.of(context).openDrawer();
                            },
                            child: Column(
                              children: [
                                Icon(
                                  Icons.menu,
                                  size: 25,
                                  color: Colors.black,
                                ),
                                Text(
                                  "Category",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12),
                                )
                              ],
                            ),
                          );
                        }),
                        PopupMenuButton<int>(
                          position: PopupMenuPosition.over,
                          icon: Column(
                            children: [
                              Icon(
                                Icons.search,
                                size: 25,
                                color: Colors.black,
                              ),
                              Text(
                                "Search",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12),
                              )
                            ],
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
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 5),
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
                                      width: screenWidth * 0.09,
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
                          offset: Offset(50, 50), // Adjusts the popup position
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AccountPage(),
                                ));
                          },
                          child: Column(
                            children: [
                              Icon(
                                Icons.person_outline,
                                size: 25,
                                color: Colors.black,
                              ),
                              Text(
                                "Account",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            //open cart
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CartitemsPage(),
                                ));
                          },
                          child: Column(
                            children: [
                              Icon(
                                Icons.shopping_bag_outlined,
                                size: 25,
                                color: Colors.black,
                              ),
                              Text(
                                "Cart",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
