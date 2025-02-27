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
import 'package:gomart_wahy/view/product_details/product_detailspage.dart';
import 'package:gomart_wahy/view/wishlist_page/wish_listpage.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key, this.products});
  final List? products;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  // Firebase Firestore instance
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  String? selectedValue;
  List countries = [];
  // Fetch country from Firestore
  Future<void> fetchCountries() async {
    try {
      QuerySnapshot snapshot = await firestore
          .collection('Countries')
          .where('status', isEqualTo: 'Active') // Only fetch active categories
          .get();

      setState(() {
        countries = snapshot.docs
            .map((doc) =>
                doc['countryName'] as String) // Extract the 'name' field
            .toList();
      });
    } catch (e) {
      print("Error fetching categories: $e");
    }
  }

  List brands = [];
  // Fetch BRANDS from Firestore
  Future<void> fetchBrands() async {
    try {
      QuerySnapshot snapshot = await firestore
          .collection('Brands')
          .where('status', isEqualTo: 'Active') // Only fetch active categories
          .get();

      setState(() {
        brands = snapshot.docs
            .map(
                (doc) => doc['brandName'] as String) // Extract the 'name' field
            .toList();
      });
    } catch (e) {
      print("Error fetching categories: $e");
    }
  }

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
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      );
    }).catchError((error) {
      print("Failed to add product to cart: $error");
    });
  }

  @override
  void initState() {
    fetchCountries();
    fetchBrands();
    super.initState();
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
                                "Shop by Category",
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
                            isDesktop
                                ? Row(
                                    children: [
                                      //side box
                                      Container(
                                        width: 300,
                                        child: Column(
                                          children: [
                                            //search now

                                            SizedBox(
                                              height: 15,
                                            ),
                                            //countries
                                            Row(
                                              children: [
                                                Text(
                                                  "Countries",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                //progress indicator

                                                Expanded(
                                                  child: LinearPercentIndicator(
                                                    lineHeight: 4.0,
                                                    percent: 0.2,
                                                    backgroundColor:
                                                        Colors.grey.shade300,
                                                    progressColor:
                                                        Colors.orange,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            //list of country
                                            ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: countries.length,
                                              itemBuilder: (context, index) {
                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      countries[index],
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 16),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    )
                                                  ],
                                                );
                                              },
                                            ),
                                            //brands
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Brands",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                //progress indicator

                                                Expanded(
                                                  child: LinearPercentIndicator(
                                                    lineHeight: 4.0,
                                                    percent: 0.2,
                                                    backgroundColor:
                                                        Colors.grey.shade300,
                                                    progressColor:
                                                        Colors.orange,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            //list of brands
                                            ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: brands.length,
                                              itemBuilder: (context, index) {
                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      brands[index],
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 16),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    )
                                                  ],
                                                );
                                              },
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            //filter
                                            Row(
                                              children: [
                                                Text(
                                                  "Filter by Price",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                //progress indicator

                                                Expanded(
                                                  child: LinearPercentIndicator(
                                                    lineHeight: 4.0,
                                                    percent: 0.2,
                                                    backgroundColor:
                                                        Colors.grey.shade300,
                                                    progressColor:
                                                        Colors.orange,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            //textfields
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: TextField(
                                                  decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder()),
                                                )),
                                                Text(
                                                  "-",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 25),
                                                ),
                                                Expanded(
                                                    child: TextField(
                                                  decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder()),
                                                )),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            //two buttons
                                            Row(
                                              children: [
                                                Container(
                                                  height: 30,
                                                  width: 80,
                                                  child: Center(
                                                    child: Text(
                                                      "Filter",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Color(0xFF03AC13)),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  height: 30,
                                                  width: 50,
                                                  child: Center(
                                                    child: Text(
                                                      "All",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Color(0xFF03AC13)),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            //best selling
                                            Row(
                                              children: [
                                                Text(
                                                  "Best Selling",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                //progress indicator

                                                Expanded(
                                                  child: LinearPercentIndicator(
                                                    lineHeight: 4.0,
                                                    percent: 0.2,
                                                    backgroundColor:
                                                        Colors.grey.shade300,
                                                    progressColor:
                                                        Colors.orange,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 15),
                                        decoration: BoxDecoration(
                                            color: Colors.white70,
                                            border: Border.all(
                                                color: Colors.grey.shade200),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            //list of products

                                            GridView.builder(
                                              itemCount:
                                                  widget.products!.length,
                                              shrinkWrap: true,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 3,
                                                      crossAxisSpacing: 10,
                                                      mainAxisSpacing: 10,
                                                      mainAxisExtent: 600),
                                              itemBuilder: (context, index) {
                                                final product = widget
                                                        .products![
                                                    index]; // Access each product as a map
                                                return GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              ProductDetailspage(
                                                            product: product,
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
                                                      addToCartTap: () {
                                                        String productId = DateTime
                                                                .now()
                                                            .millisecondsSinceEpoch
                                                            .toString();
                                                        //add to cart
                                                        addToCart({
                                                          "productId":
                                                              productId, // Store product ID
                                                          "productUrl": product[
                                                              'productUrl'],
                                                          "productName": product[
                                                              'productName'],
                                                          "category": product[
                                                              'category'],
                                                          "originalPrice": product[
                                                              'originalPrice'],
                                                          "ourPrice": product[
                                                              'ourPrice'],
                                                          "currentstock": product[
                                                              'currentstock'],
                                                          "quantity":
                                                              1 // Default quantity
                                                        });
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
                                                );
                                              },
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                : //other devices
                                Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: isTablet ? 20 : 5),
                                    child: Column(
                                      children: [
                                        //side box
                                        Container(
                                          width: double.infinity,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 15,
                                              ),
                                              //countries
                                              Row(
                                                children: [
                                                  Text(
                                                    "Countries",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                  //progress indicator

                                                  Expanded(
                                                    child:
                                                        LinearPercentIndicator(
                                                      lineHeight: 4.0,
                                                      percent: 0.2,
                                                      backgroundColor:
                                                          Colors.grey.shade300,
                                                      progressColor:
                                                          Colors.orange,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              //list of country
                                              ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: countries.length,
                                                itemBuilder: (context, index) {
                                                  return Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        countries[index],
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 16),
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      )
                                                    ],
                                                  );
                                                },
                                              ),
                                              //brands
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Brands",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                  //progress indicator

                                                  Expanded(
                                                    child:
                                                        LinearPercentIndicator(
                                                      lineHeight: 4.0,
                                                      percent: 0.2,
                                                      backgroundColor:
                                                          Colors.grey.shade300,
                                                      progressColor:
                                                          Colors.orange,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              //list of brands
                                              ListView.builder(
                                                shrinkWrap: true,
                                                physics: ScrollPhysics(),
                                                itemCount: brands.length,
                                                itemBuilder: (context, index) {
                                                  return Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        brands[index],
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 16),
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      )
                                                    ],
                                                  );
                                                },
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              //filter
                                              Row(
                                                children: [
                                                  Text(
                                                    "Filter by Price",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                  //progress indicator

                                                  Expanded(
                                                    child:
                                                        LinearPercentIndicator(
                                                      lineHeight: 4.0,
                                                      percent: 0.2,
                                                      backgroundColor:
                                                          Colors.grey.shade300,
                                                      progressColor:
                                                          Colors.orange,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              //textfields
                                              Row(
                                                children: [
                                                  Expanded(
                                                      child: TextField(
                                                    decoration: InputDecoration(
                                                        border:
                                                            OutlineInputBorder()),
                                                  )),
                                                  Text(
                                                    "-",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 25),
                                                  ),
                                                  Expanded(
                                                      child: TextField(
                                                    decoration: InputDecoration(
                                                        border:
                                                            OutlineInputBorder()),
                                                  )),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              //two buttons
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 30,
                                                    width: 80,
                                                    child: Center(
                                                      child: Text(
                                                        "Filter",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color:
                                                            Color(0xFF03AC13)),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    height: 30,
                                                    width: 50,
                                                    child: Center(
                                                      child: Text(
                                                        "All",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color:
                                                            Color(0xFF03AC13)),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              //best selling
                                              Row(
                                                children: [
                                                  Text(
                                                    "Best Selling",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                  //progress indicator

                                                  Expanded(
                                                    child:
                                                        LinearPercentIndicator(
                                                      lineHeight: 4.0,
                                                      percent: 0.2,
                                                      backgroundColor:
                                                          Colors.grey.shade300,
                                                      progressColor:
                                                          Colors.orange,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 15),
                                          decoration: BoxDecoration(
                                              color: Colors.white70,
                                              border: Border.all(
                                                  color: Colors.grey.shade200),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                        ),
                                        //sort option

                                        SizedBox(
                                          height: 15,
                                        ),
                                        //list of products

                                        isTablet
                                            ? GridView.builder(
                                                itemCount:
                                                    widget.products!.length,
                                                shrinkWrap: true,
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 3,
                                                        crossAxisSpacing: 10,
                                                        mainAxisSpacing: 10,
                                                        mainAxisExtent: 600),
                                                itemBuilder: (context, index) {
                                                  final product = widget
                                                          .products![
                                                      index]; // Access each product as a map
                                                  return GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                ProductDetailspage(
                                                              product: product,
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
                                                        addToCartTap: () {
                                                          String productId =
                                                              DateTime.now()
                                                                  .millisecondsSinceEpoch
                                                                  .toString();
                                                          //add to cart
                                                          addToCart({
                                                            "productId":
                                                                productId, // Store product ID
                                                            "productUrl": product[
                                                                'productUrl'],
                                                            "productName": product[
                                                                'productName'],
                                                            "category": product[
                                                                'category'],
                                                            "originalPrice":
                                                                product[
                                                                    'originalPrice'],
                                                            "ourPrice": product[
                                                                'ourPrice'],
                                                            "currentstock": product[
                                                                'currentstock'],
                                                            "quantity":
                                                                1 // Default quantity
                                                          });
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
                                                  );
                                                },
                                              )
                                            : //mobile
                                            ListView.separated(
                                                shrinkWrap: true,
                                                physics: ScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  final product = widget
                                                          .products![
                                                      index]; // Access each product as a map
                                                  return GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                ProductDetailspage(
                                                              product: product,
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
                                                        addToCartTap: () {
                                                          String productId =
                                                              DateTime.now()
                                                                  .millisecondsSinceEpoch
                                                                  .toString();
                                                          //add to cart
                                                          addToCart({
                                                            "productId":
                                                                productId, // Store product ID
                                                            "productUrl": product[
                                                                'productUrl'],
                                                            "productName": product[
                                                                'productName'],
                                                            "category": product[
                                                                'category'],
                                                            "originalPrice":
                                                                product[
                                                                    'originalPrice'],
                                                            "ourPrice": product[
                                                                'ourPrice'],
                                                            "currentstock": product[
                                                                'currentstock'],
                                                            "quantity":
                                                                1 // Default quantity
                                                          });
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
                                                  );
                                                },
                                                separatorBuilder:
                                                    (context, index) =>
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                itemCount:
                                                    widget.products!.length)
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
