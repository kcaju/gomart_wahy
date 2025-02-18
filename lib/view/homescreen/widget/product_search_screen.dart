import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gomart_wahy/view/floatingactionbutton/custom_floatingbutton.dart';
import 'package:gomart_wahy/view/homescreen/drawerscreen/drawer_screen.dart';
import 'package:gomart_wahy/view/homescreen/widget/header_greencard.dart';
import 'package:gomart_wahy/view/homescreen/widget/header_whitebox.dart';
import 'package:gomart_wahy/view/homescreen/widget/trendingproducts_card.dart';

class ProductSearchScreen extends StatefulWidget {
  const ProductSearchScreen({super.key, required this.searchQuery});
  final String searchQuery;

  @override
  State<ProductSearchScreen> createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {
  List<Map<String, dynamic>> searchResults = [];
  Future<void> searchProducts(String query) async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Products').get();
    List<Map<String, dynamic>> filteredProducts = querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .where((product) {
      String category = product['category'].toString().toLowerCase();
      String name = product['name'].toString().toLowerCase();
      return category.contains(query.toLowerCase()) ||
          name.contains(query.toLowerCase());
    }).toList();

    setState(() {
      searchResults = filteredProducts;
    });
  }

  @override
  void initState() {
    searchProducts(widget.searchQuery);
    super.initState();
  }

  //add to cart
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
  Widget build(BuildContext context) {
    // Use MediaQuery to get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Determine screen type based on width
    bool isMobile = screenWidth < 600;
    bool isTablet = screenWidth >= 600 && screenWidth <= 1024;
    bool isDesktop = screenWidth > 1024;

    return SafeArea(
        child: Scaffold(
      endDrawer: DrawerScreen(),
      floatingActionButton: CustomFloatingbutton(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                //green container
                isDesktop ? HeaderGreencard() : SizedBox(),
                SizedBox(
                  height: 50,
                ),
                GridView.builder(
                  padding: EdgeInsets.all(50),
                  itemCount: searchResults.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isMobile ? 1 : 3,
                      crossAxisSpacing: 10,
                      mainAxisExtent: 600,
                      mainAxisSpacing: 10),
                  itemBuilder: (context, index) {
                    var product = searchResults[index];
                    return TrendingproductsCard(
                        isProducts: true,
                        addToCartTap: () {
                          //add to cart
                          addToCart({
                            "productId": "", // Store product ID
                            "productUrl": product['productUrl'],
                            "productName": product['productName'],
                            "category": product['category'],
                            "originalPrice": product['originalPrice'],
                            "ourPrice": product['ourPrice'],
                            "currentstock": product['currentstock'],
                            "quantity": 1 // Default quantity
                          });
                        },
                        url: product['productUrl'],
                        title: product['productName'],
                        name: product['category'],
                        oldRate: product['originalPrice'],
                        newRate: product['ourPrice'],
                        count: product['currentstock'],
                        maxcount: product['openstock']);
                  },
                )
              ],
            ),
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
    ));
  }
}
