import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gomart_wahy/view/floatingactionbutton/custom_floatingbutton.dart';
import 'package:gomart_wahy/view/homescreen/drawerscreen/drawer_screen.dart';
import 'package:gomart_wahy/view/homescreen/home_screen.dart';
import 'package:gomart_wahy/view/homescreen/widget/header_greencard.dart';
import 'package:gomart_wahy/view/homescreen/widget/header_whitebox.dart';
import 'package:gomart_wahy/view/homescreen/widget/homepage.dart';
import 'package:gomart_wahy/view/homescreen/widget/trendingproducts_card.dart';
import 'package:gomart_wahy/view/wishlist_page/wish_listpage.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProductDetailspage extends StatelessWidget {
  const ProductDetailspage({super.key, this.products, this.product});
  final QueryDocumentSnapshot<Object?>? products;
  final Map? product;

  @override
  Widget build(BuildContext context) {
    // Firebase Firestore instance
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    // Use MediaQuery to get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Determine screen type based on width
    bool isMobile = screenWidth < 600;
    bool isTablet = screenWidth >= 600 && screenWidth <= 1024;
    bool isDesktop = screenWidth > 1024;

    void addToCart(Map<String, dynamic> product) async {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      User? user = auth.currentUser;
      if (user == null) {
        print("User not logged in");
        return;
      }

      DocumentReference userRef = firestore.collection("users").doc(user.uid);

      // Retrieve the current cart data
      DocumentSnapshot userDoc = await userRef.get();
      List<dynamic> cartItems = userDoc.get("cartItems") ?? [];

      // Check if the product is already in the cart
      int existingIndex = cartItems
          .indexWhere((item) => item["productName"] == product["productName"]);

      if (existingIndex != -1) {
        // If product exists, update the quantity
        cartItems[existingIndex]["quantity"] += 1;
      } else {
        // Otherwise, add as a new product
        cartItems.add(product);
      }

      // Update Firestore document
      await userRef.update({"cartItems": cartItems}).then((_) {
        print("Product added to cart successfully");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Product added to cart successfully",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
        );
      }).catchError((error) {
        print("Failed to add product to cart: $error");
      });
    }

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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                " Product Details",
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
                                    "Page >> Product Details",
                                    style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontWeight: FontWeight.bold,
                                        fontSize: isMobile ? 14 : 16),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: isMobile ? 15 : 100,
                            ),
                            //container with product image details
                            isDesktop
                                ? Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 15),
                                    width: screenWidth * 0.7,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        //image details
                                        Row(
                                          children: [
                                            Image.network(
                                              products?['productUrl'] ??
                                                  product?['productUrl'],
                                              height: 450,
                                            ),
                                            SizedBox(
                                              width: 12,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    products?['productName'] ??
                                                        product?['productName'],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 25),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "₹ ${products?['ourPrice'] ?? product?['ourPrice']}",
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Description",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18),
                                                      ),
                                                      //progress indicator

                                                      Flexible(
                                                        child: SizedBox(
                                                          width: 450,
                                                          child:
                                                              LinearPercentIndicator(
                                                            lineHeight: 4.0,
                                                            percent: 0.2,
                                                            backgroundColor:
                                                                Colors.grey
                                                                    .shade300,
                                                            progressColor:
                                                                Colors.orange,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    products?['description'] ??
                                                        product?['description'],
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 16),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "Stock:",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                  //weight box
                                                  Container(
                                                    height: 25,
                                                    width: 100,
                                                    child: Center(
                                                      child: Text(
                                                        products?[
                                                                'currentstock'] ??
                                                            product?[
                                                                'currentstock'],
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3),
                                                        border: Border.all(
                                                            color: Colors.grey
                                                                .shade200)),
                                                  ),
                                                  //quantity addto cart button
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      //quantity button
                                                      Container(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade200),
                                                              ),
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(5),
                                                              height: 50,
                                                              child: Icon(
                                                                Icons.remove,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10),
                                                                height: 50,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade200),
                                                                ),
                                                                child: Text(
                                                                  "1",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                )),
                                                            Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(5),
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade200),
                                                              ),
                                                              height: 50,
                                                              child: Icon(
                                                                Icons.add,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 15,
                                                            ),
                                                            //add cart button
                                                            GestureDetector(
                                                              onTap: () {
                                                                String
                                                                    productId =
                                                                    DateTime.now()
                                                                        .millisecondsSinceEpoch
                                                                        .toString();
                                                                //add to cart
                                                                addToCart({
                                                                  "productId":
                                                                      productId, // Store product ID
                                                                  "productUrl": product?[
                                                                          'productUrl'] ??
                                                                      products?[
                                                                          'productUrl'],
                                                                  "productName": product?[
                                                                          'productName'] ??
                                                                      products?[
                                                                          'productName'],
                                                                  "category": product?[
                                                                          'category'] ??
                                                                      products?[
                                                                          'category'],
                                                                  "originalPrice": product?[
                                                                          'originalPrice'] ??
                                                                      products?[
                                                                          'originalPrice'],
                                                                  "ourPrice": product?[
                                                                          'ourPrice'] ??
                                                                      products?[
                                                                          'ourPrice'],
                                                                  "currentstock": product?[
                                                                          'currentstock'] ??
                                                                      products?[
                                                                          'currentstock'],
                                                                  "quantity":
                                                                      1 // Default quantity
                                                                });
                                                              },
                                                              child: Container(
                                                                height: 50,
                                                                width: 150,
                                                                child: Center(
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .shopping_bag,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                        "Add to Cart",
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .white,
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .orange,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5)),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        //scroll images
                                        SizedBox(
                                          height: 150,
                                          width: screenWidth * 0.3,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: List.generate(
                                                6,
                                                (index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 15),
                                                    child: Container(
                                                      height: 100,
                                                      width: 120,
                                                      decoration: BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  image:
                                                                      NetworkImage(
                                                                    products?[
                                                                            'productUrl'] ??
                                                                        product?[
                                                                            'productUrl'],
                                                                  )),
                                                          border: Border.all(
                                                              color: Colors.grey
                                                                  .shade200),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: Colors.grey.shade200)),
                                  )
                                :
                                //other devices
                                Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: isTablet ? 20 : 5),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          //image
                                          Center(
                                            child: Image.network(
                                              products?['productUrl'] ??
                                                  product?['productUrl'],
                                              height: 550,
                                            ),
                                          ),
                                          //scroll images
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: List.generate(
                                                10,
                                                (index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 15),
                                                    child: Container(
                                                      height: 150,
                                                      width: 130,
                                                      decoration: BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  image:
                                                                      NetworkImage(
                                                                    products?[
                                                                            'productUrl'] ??
                                                                        product?[
                                                                            'productUrl'],
                                                                  )),
                                                          border: Border.all(
                                                              color: Colors.grey
                                                                  .shade200),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),

                                          Text(
                                            products?['productName'] ??
                                                product?['productName'],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "₹ ${products?['ourPrice'] ?? product?['ourPrice']}",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Description",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                              //progress indicator

                                              SizedBox(
                                                width: isTablet ? 450 : 200,
                                                child: LinearPercentIndicator(
                                                  lineHeight: 4.0,
                                                  percent: 0.2,
                                                  backgroundColor:
                                                      Colors.grey.shade300,
                                                  progressColor: Colors.orange,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            products?['description'] ??
                                                product?['description'],
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Stock:",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          //weight box
                                          Container(
                                            height: 25,
                                            width: 100,
                                            child: Center(
                                              child: Text(
                                                products?['currentstock'] ??
                                                    product?['currentstock'],
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                                border: Border.all(
                                                    color:
                                                        Colors.grey.shade200)),
                                          ),
                                          //quantity addto cart button
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              //quantity button
                                              Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors
                                                                .grey.shade200),
                                                      ),
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      height: 50,
                                                      child: Icon(
                                                        Icons.remove,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    Container(
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        height: 50,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors.grey
                                                                  .shade200),
                                                        ),
                                                        child: Text(
                                                          "1",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors
                                                                .grey.shade200),
                                                      ),
                                                      height: 50,
                                                      child: Icon(
                                                        Icons.add,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 15,
                                                    ),
                                                    //add cart button
                                                    GestureDetector(
                                                      onTap: () {
                                                        String productId = DateTime
                                                                .now()
                                                            .millisecondsSinceEpoch
                                                            .toString();
                                                        //add to cart
                                                        addToCart({
                                                          "productId":
                                                              productId, // Store product ID
                                                          "productUrl": product?[
                                                                  'productUrl'] ??
                                                              products?[
                                                                  'productUrl'],
                                                          "productName": product?[
                                                                  'productName'] ??
                                                              products?[
                                                                  'productName'],
                                                          "category": product?[
                                                                  'category'] ??
                                                              products?[
                                                                  'category'],
                                                          "originalPrice": product?[
                                                                  'originalPrice'] ??
                                                              products?[
                                                                  'originalPrice'],
                                                          "ourPrice": product?[
                                                                  'ourPrice'] ??
                                                              products?[
                                                                  'ourPrice'],
                                                          "currentstock": product?[
                                                                  'currentstock'] ??
                                                              products?[
                                                                  'currentstock'],
                                                          "quantity":
                                                              1 // Default quantity
                                                        });
                                                      },
                                                      child: Container(
                                                        height: 50,
                                                        width: 150,
                                                        child: Center(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .shopping_bag,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                "Add to Cart",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        decoration: BoxDecoration(
                                                            color:
                                                                Colors.orange,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: Colors.grey.shade200)),
                                    ),
                                  ),
                            SizedBox(
                              height: isMobile ? 25 : 80,
                            ),

                            //interested items row
                            isMobile
                                ? Column(
                                    children: [
                                      Text(
                                        "You may be interested",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 40,
                                            child: Icon(
                                              Icons.arrow_back,
                                              color: Colors.white,
                                            ),
                                            decoration: BoxDecoration(
                                                color: Colors.orange,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Container(
                                            height: 40,
                                            width: 40,
                                            child: Icon(
                                              Icons.arrow_forward,
                                              color: Colors.white,
                                            ),
                                            decoration: BoxDecoration(
                                                color: Colors.orange,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                : Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: isTablet ? 20 : 0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "You may be interested",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 32,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Spacer(),
                                        Row(
                                          children: [
                                            Container(
                                              height: 40,
                                              width: 40,
                                              child: Icon(
                                                Icons.arrow_back,
                                                color: Colors.white,
                                              ),
                                              decoration: BoxDecoration(
                                                  color: Colors.orange,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Container(
                                              height: 40,
                                              width: 40,
                                              child: Icon(
                                                Icons.arrow_forward,
                                                color: Colors.white,
                                              ),
                                              decoration: BoxDecoration(
                                                  color: Colors.orange,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                            SizedBox(
                              height: 50,
                            ),
                            //sliding items
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
                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: isTablet ? 20 : 5),
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
                                                              products:
                                                                  product),
                                                    ));
                                              },
                                              child: TrendingproductsCard(
                                                  addToCartTap: () {
                                                    //add to cart
                                                    addToCart({
                                                      "productId": product
                                                          .id, // Store product ID
                                                      "productUrl":
                                                          product['productUrl'],
                                                      "productName": product[
                                                          'productName'],
                                                      "category":
                                                          product['category'],
                                                      "originalPrice": product[
                                                          'originalPrice'],
                                                      "ourPrice":
                                                          product['ourPrice'],
                                                      "currentstock": product[
                                                          'currentstock'],
                                                      "quantity":
                                                          1 // Default quantity
                                                    });
                                                  },
                                                  isProducts: true,
                                                  url: product['productUrl'],
                                                  maxcount:
                                                      product['openstock'],
                                                  title: product['productName'],
                                                  name: product['category'],
                                                  oldRate:
                                                      product['originalPrice'],
                                                  newRate: product['ourPrice'],
                                                  count:
                                                      product['currentstock']),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
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
