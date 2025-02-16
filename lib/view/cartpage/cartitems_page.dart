import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gomart_wahy/controller/cartitem_controller/cartitem_controller.dart';
import 'package:gomart_wahy/view/all_products/all_productscreen.dart';
import 'package:gomart_wahy/view/checkout/checkout_page.dart';
import 'package:gomart_wahy/view/floatingactionbutton/custom_floatingbutton.dart';
import 'package:gomart_wahy/view/homescreen/drawerscreen/drawer_screen.dart';
import 'package:gomart_wahy/view/homescreen/home_screen.dart';
import 'package:gomart_wahy/view/homescreen/widget/header_greencard.dart';
import 'package:gomart_wahy/view/homescreen/widget/header_whitebox.dart';
import 'package:gomart_wahy/view/homescreen/widget/homepage.dart';
import 'package:provider/provider.dart';

class CartitemsPage extends StatelessWidget {
  const CartitemsPage({super.key});

  // // Function to get current user's ID
  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Determine screen type based on width
    bool isMobile = screenWidth < 600;
    bool isTablet = screenWidth >= 600 && screenWidth <= 1024;
    bool isDesktop = screenWidth > 1024;
    final cartController = Provider.of<CartitemController>(context);
    return SafeArea(
      child: Scaffold(
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
                              horizontal:
                                  screenWidth * (isDesktop ? 0.04 : 0.01),
                              vertical:
                                  screenHeight * (isDesktop ? 0.08 : 0.09)),
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  "Shopping Cart",
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
                                      "Page >> Cart Page",
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
                              isDesktop
                                  ? FutureBuilder<String?>(
                                      future: cartController.getCurrentUserId(),
                                      builder: (context, userIdSnapshot) {
                                        if (userIdSnapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }

                                        if (userIdSnapshot.hasError ||
                                            userIdSnapshot.data == null) {
                                          return Center(
                                              child: Text("No user logged in"));
                                        }

                                        // User ID successfully fetched, use it to get cart items
                                        String userId = userIdSnapshot.data!;
                                        return StreamBuilder<DocumentSnapshot>(
                                          stream: FirebaseFirestore.instance
                                              .collection(
                                                  'users') // users collection
                                              .doc(
                                                  userId) // Document ID will be the user's UID
                                              .snapshots(),
                                          builder: (context, cartSnapshot) {
                                            if (cartSnapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            }

                                            if (!cartSnapshot.hasData ||
                                                cartSnapshot.data == null) {
                                              return Center(
                                                  child: Text(
                                                      "No data available"));
                                            }

                                            // 🔍 Print the data for debugging
                                            print(
                                                "Firestore Data: ${cartSnapshot.data!.data()}");

                                            if (cartSnapshot.data!.data() ==
                                                null) {
                                              return Center(
                                                  child: Text(
                                                      "Your cart is empty"));
                                            }
                                            0.0;
                                            Map<String, dynamic> userData =
                                                cartSnapshot.data!.data()
                                                    as Map<String, dynamic>;
                                            List<dynamic> cartItems =
                                                userData['cartItems'] ?? [];
                                            num totalPrice =
                                                userData['totalPrice'] ?? 0.0;

                                            if (cartItems == [] ||
                                                cartItems.isEmpty) {
                                              return Center(
                                                  child: Text(
                                                      "Your cart is empty"));
                                            }

                                            return Column(
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                //cart items box
                                                Container(
                                                  // height: 500,
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            height:
                                                                screenHeight *
                                                                    0.085,
                                                            width: screenWidth *
                                                                0.05,
                                                            color: Colors
                                                                .green.shade200,
                                                          ),
                                                          Container(
                                                            child: Center(
                                                              child: Text(
                                                                "Image",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            height:
                                                                screenHeight *
                                                                    0.085,
                                                            width: screenWidth *
                                                                0.19,
                                                            color: Colors
                                                                .green.shade200,
                                                          ),
                                                          Container(
                                                            height:
                                                                screenHeight *
                                                                    0.085,
                                                            width: screenWidth *
                                                                0.18,
                                                            child: Center(
                                                              child: Text(
                                                                "Product Name",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            color: Colors
                                                                .green.shade200,
                                                          ),
                                                          Container(
                                                            height:
                                                                screenHeight *
                                                                    0.085,
                                                            width: screenWidth *
                                                                0.15,
                                                            child: Center(
                                                              child: Text(
                                                                "Quantity",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            color: Colors
                                                                .green.shade200,
                                                          ),
                                                          Container(
                                                            height:
                                                                screenHeight *
                                                                    0.085,
                                                            width: screenWidth *
                                                                0.078,
                                                            child: Center(
                                                              child: Text(
                                                                "Unit Price",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            color: Colors
                                                                .green.shade200,
                                                          ),
                                                          Container(
                                                            height:
                                                                screenHeight *
                                                                    0.085,
                                                            width: screenWidth *
                                                                0.12,
                                                            child: Center(
                                                              child: Text(
                                                                "Deal Price",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            color: Colors
                                                                .green.shade200,
                                                          ),
                                                          Container(
                                                            height:
                                                                screenHeight *
                                                                    0.085,
                                                            width: screenWidth *
                                                                0.075,
                                                            child: Center(
                                                              child: Text(
                                                                "Price",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            color: Colors
                                                                .green.shade200,
                                                          ),
                                                          Container(
                                                            height:
                                                                screenHeight *
                                                                    0.085,
                                                            width: screenWidth *
                                                                0.06,
                                                            color: Colors
                                                                .green.shade200,
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      ListView.builder(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 15,
                                                                right: 10),
                                                        itemCount:
                                                            cartItems.length,
                                                        physics:
                                                            ScrollPhysics(),
                                                        shrinkWrap: true,
                                                        itemBuilder:
                                                            (context, index) {
                                                          var item =
                                                              cartItems[index];
                                                          return Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              SizedBox(),
                                                              //checkbox
                                                              Container(
                                                                height: 12,
                                                                width: 12,
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .rectangle,
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .grey)),
                                                              ),

                                                              //image
                                                              Container(
                                                                height: screenHeight *
                                                                    (isDesktop
                                                                        ? 0.2
                                                                        : 0.1),
                                                                width: screenWidth *
                                                                    (isDesktop
                                                                        ? 0.165
                                                                        : 0.05),
                                                                decoration: BoxDecoration(
                                                                    image: DecorationImage(
                                                                        fit: BoxFit
                                                                            .fill,
                                                                        image: NetworkImage(
                                                                            item['productUrl']))),
                                                              ),

                                                              Text(
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                item[
                                                                    'productName'],
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),

                                                              //quantity button
                                                              Container(
                                                                child: Row(
                                                                  children: [
                                                                    InkWell(
                                                                      onTap:
                                                                          () async {
                                                                        await cartController.updateCartQuantity(
                                                                            item['productId'],
                                                                            -1);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          border:
                                                                              Border.all(color: Colors.grey.shade200),
                                                                        ),
                                                                        padding:
                                                                            EdgeInsets.all(5),
                                                                        height:
                                                                            50,
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                        padding:
                                                                            EdgeInsets.all(
                                                                                10),
                                                                        height:
                                                                            50,
                                                                        child:
                                                                            Text(
                                                                          item['quantity']
                                                                              .toString(),
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.bold),
                                                                        )),
                                                                    InkWell(
                                                                      onTap:
                                                                          () async {
                                                                        await cartController.updateCartQuantity(
                                                                            item['productId'],
                                                                            1);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        padding:
                                                                            EdgeInsets.all(5),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          border:
                                                                              Border.all(color: Colors.grey.shade200),
                                                                        ),
                                                                        height:
                                                                            50,
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .add,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade200),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 1,
                                                              ),

                                                              //unitprice
                                                              Text(
                                                                "₹${item['ourPrice'] * item['quantity']}",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),

                                                              //dealprice
                                                              Text(
                                                                "Not Applicable",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),

                                                              //price
                                                              Text(
                                                                "₹${item['ourPrice'] * item['quantity']}",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),

                                                              //remove button
                                                              GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  // Remove the item from the cart
                                                                  await cartController
                                                                      .removeCartItem(
                                                                          item[
                                                                              'productId']);
                                                                },
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              8),
                                                                  height: 40,
                                                                  child: Text(
                                                                    "Remove",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .red,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5)),
                                                                ),
                                                              ),
                                                              // SizedBox(
                                                              //   width: 1,
                                                              // )
                                                            ],
                                                          );
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: Colors
                                                              .grey.shade200),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                //total section
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 5,
                                                      horizontal: 5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10,
                                                                vertical: 8),
                                                        width:
                                                            screenWidth * 0.35,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  "Subtotal",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                                Text(
                                                                  "₹${totalPrice.toStringAsFixed(2)}",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                              ],
                                                            ),
                                                            Divider(
                                                              color: Colors.grey
                                                                  .shade200,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  "Total",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                                Text(
                                                                  "₹${totalPrice.toStringAsFixed(2)}",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 15,
                                                            ),
                                                            Text(
                                                              "Shipping options will be updated during checkout.",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            SizedBox(
                                                              height: 15,
                                                            ),
                                                            Row(
                                                              children: [
                                                                //confirm button
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              CheckoutPage(
                                                                            totalPrice:
                                                                                totalPrice,
                                                                            cartItems:
                                                                                cartItems,
                                                                          ),
                                                                        ));
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      "Confirm Order",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    height:
                                                                        screenHeight *
                                                                            0.06,
                                                                    width:
                                                                        screenWidth *
                                                                            0.09,
                                                                    decoration: BoxDecoration(
                                                                        color: Color(
                                                                            0xFF03AC13),
                                                                        borderRadius:
                                                                            BorderRadius.circular(5)),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 15,
                                                                ),
                                                                //continue button
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              AllProductscreen(),
                                                                        ));
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      "Continue Shopping",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .orange,
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    height:
                                                                        screenHeight *
                                                                            0.06,
                                                                    width:
                                                                        screenWidth *
                                                                            0.095,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        border: Border.all(
                                                                            color: Colors
                                                                                .orange),
                                                                        borderRadius:
                                                                            BorderRadius.circular(5)),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border.all(
                                                                color: Colors
                                                                    .grey
                                                                    .shade200)),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    )
                                  : //other devices
                                  FutureBuilder<String?>(
                                      future: cartController.getCurrentUserId(),
                                      builder: (context, userIdSnapshot) {
                                        if (userIdSnapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }

                                        if (userIdSnapshot.hasError ||
                                            userIdSnapshot.data == null) {
                                          return Center(
                                              child: Text("No user logged in"));
                                        }

                                        // User ID successfully fetched, use it to get cart items
                                        String userId = userIdSnapshot.data!;
                                        return StreamBuilder<DocumentSnapshot>(
                                          stream: FirebaseFirestore.instance
                                              .collection(
                                                  'users') // users collection
                                              .doc(
                                                  userId) // Document ID will be the user's UID
                                              .snapshots(),
                                          builder: (context, cartSnapshot) {
                                            if (cartSnapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            }

                                            if (!cartSnapshot.hasData ||
                                                cartSnapshot.data == null) {
                                              return Center(
                                                  child: Text(
                                                      "No data available"));
                                            }

                                            // 🔍 Print the data for debugging
                                            print(
                                                "Firestore Data: ${cartSnapshot.data!.data()}");

                                            if (cartSnapshot.data!.data() ==
                                                null) {
                                              return Center(
                                                  child: Text(
                                                      "Your cart is empty"));
                                            }

                                            Map<String, dynamic> userData =
                                                cartSnapshot.data!.data()
                                                    as Map<String, dynamic>;
                                            List<dynamic> cartItems =
                                                userData['cartItems'] ?? [];
                                            num totalPrice =
                                                userData['totalPrice'] ?? 0.0;

                                            if (cartItems == [] ||
                                                cartItems.isEmpty) {
                                              return Center(
                                                  child: Text(
                                                      "Your cart is empty"));
                                            }

                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  //cart items list
                                                  Container(
                                                    child: ListView.builder(
                                                      itemCount:
                                                          cartItems.length,
                                                      physics: ScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemBuilder:
                                                          (context, index) {
                                                        var item =
                                                            cartItems[index];
                                                        return Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            //checkbox
                                                            Container(
                                                              height: 12,
                                                              width: 12,
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .rectangle,
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .grey)),
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            //image
                                                            Container(
                                                              height:
                                                                  screenHeight *
                                                                      0.2,
                                                              width: screenWidth *
                                                                  (isTablet
                                                                      ? 0.165
                                                                      : 0.25),
                                                              decoration: BoxDecoration(
                                                                  image: DecorationImage(
                                                                      fit: BoxFit
                                                                          .fill,
                                                                      image: NetworkImage(
                                                                          item[
                                                                              'productUrl']))),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              item[
                                                                  'productName'],
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            //quantity button
                                                            Container(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  GestureDetector(
                                                                    onTap:
                                                                        () async {
                                                                      await cartController.updateCartQuantity(
                                                                          item[
                                                                              'productId'],
                                                                          -1);
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.grey.shade200),
                                                                      ),
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              5),
                                                                      height:
                                                                          50,
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .remove,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              10),
                                                                      height:
                                                                          50,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.grey.shade200),
                                                                      ),
                                                                      child:
                                                                          Text(
                                                                        item['quantity']
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontWeight: FontWeight.bold),
                                                                      )),
                                                                  GestureDetector(
                                                                    onTap:
                                                                        () async {
                                                                      await cartController
                                                                          .updateCartQuantity(
                                                                              item['productId'],
                                                                              1);
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              5),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.grey.shade200),
                                                                      ),
                                                                      height:
                                                                          50,
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .add,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            //unitprice
                                                            Text(
                                                              "Unit Price:₹${item['ourPrice'] * item['quantity']}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),

                                                            //dealprice
                                                            Text(
                                                              "Deal Price: Not Applicable",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),

                                                            //price
                                                            Text(
                                                              "Total Price: ₹${item['ourPrice'] * item['quantity']}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),

                                                            //remove button
                                                            GestureDetector(
                                                              onTap: () async {
                                                                // Remove the item from the cart
                                                                await cartController
                                                                    .removeCartItem(
                                                                        item[
                                                                            'productId']);
                                                              },
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(8),
                                                                height: 40,
                                                                child: Text(
                                                                  "Remove",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .red,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5)),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                            )
                                                          ],
                                                        );
                                                      },
                                                    ),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors
                                                                .grey.shade200),
                                                        color: Colors.white),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  //total section
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 8),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Subtotal",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                            Text(
                                                              "₹${totalPrice.toStringAsFixed(2)}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ],
                                                        ),
                                                        Divider(
                                                          color: Colors
                                                              .grey.shade200,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Total",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                            Text(
                                                              "₹${totalPrice.toStringAsFixed(2)}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Text(
                                                          "Shipping options will be updated during checkout.",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Row(
                                                          children: [
                                                            //confirm button

                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              CheckoutPage(
                                                                        totalPrice:
                                                                            totalPrice,
                                                                        cartItems:
                                                                            cartItems,
                                                                      ),
                                                                    ));
                                                              },
                                                              child: Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                  "Confirm Order",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                height:
                                                                    screenHeight *
                                                                        0.05,
                                                                width: 120,
                                                                decoration: BoxDecoration(
                                                                    color: Color(
                                                                        0xFF03AC13),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5)),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 15,
                                                            ),
                                                            //continue button
                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              AllProductscreen(),
                                                                    ));
                                                              },
                                                              child: Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                  "Continue Shopping",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .orange,
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                height:
                                                                    screenHeight *
                                                                        0.05,
                                                                width: 150,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .orange),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5)),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            color: Colors.grey
                                                                .shade200)),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    )
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
      ),
    );
  }
}
