import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gomart_wahy/view/floatingactionbutton/custom_floatingbutton.dart';
import 'package:gomart_wahy/view/homescreen/drawerscreen/drawer_screen.dart';
import 'package:gomart_wahy/view/homescreen/home_screen.dart';
import 'package:gomart_wahy/view/homescreen/widget/customtextformfield.dart';
import 'package:gomart_wahy/view/homescreen/widget/header_greencard.dart';
import 'package:gomart_wahy/view/homescreen/widget/header_whitebox.dart';
import 'package:gomart_wahy/view/homescreen/widget/homepage.dart';
import 'package:gomart_wahy/view/invoice_page/invoice_page.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage(
      {super.key, required this.totalPrice, required this.cartItems});
  final num totalPrice;
  final List cartItems;

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController eirCode = TextEditingController();

  // Fetch user data from Firestore
  void _fetchUserData() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();
        final userData = userDoc.data();

        if (userData != null && userData.containsKey('userAddress')) {
          final addressData = userData['userAddress'];

          setState(() {
            fname.text = addressData['firstName'] ?? '';
            lname.text = addressData['lastName'] ?? '';
            address.text = addressData['address'] ?? '';
            mobile.text = addressData['mobile'] ?? '';
            email.text = addressData['email'] ?? '';
            state.text = addressData['state'] ?? '';
            eirCode.text = addressData['eirCode'] ?? '';
          });
        }
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  late Razorpay _razorpay;
  // Callback function to handle payment success
  void _paymentSuccess(PaymentSuccessResponse response) {
    print("success $response");
  }

// Callback function to handle payment failure
  void _paymentFaliure(PaymentSuccessResponse response) {
    print("Faliure $response");
  }

// Callback function to handle external wallet payments
  void _paymentWallet(ExternalWalletResponse response) {}
  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _paymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _paymentFaliure);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _paymentWallet);

    _fetchUserData();
    super.initState();
  }

  @override
  void dispose() {
    // Clear Razorpay resources
    _razorpay.clear();
    super.dispose();
  }

  // Function to start the checkout process with Razorpay
  void checkout(num amt, String phone) {
    var options = {
      //dynamic key of client please replace key with your key
      'key': 'rzp_live_ILgsfZCZoFIKMb',
      //amt in pisa to rupees
      'amount': amt * 100,
      // 'name': title,
      // 'description': description,
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '$phone'},
      'external': {
        'wallets': ['paytm', 'gpay']
      }
    };
    try {
      _razorpay.open(options); //razorpay starts using open()fctn
    } catch (e) {}
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
                                  "Check Out Page",
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
                                      "Page >> Check Out",
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
                              //shipment address
                              isDesktop
                                  ? Row(
                                      children: [
                                        //fields column
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Shipment Address",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Customtextformfield(
                                                        hintText: "First Name",
                                                        controller: fname),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Expanded(
                                                    child: Customtextformfield(
                                                        hintText: "Last Name",
                                                        controller: lname),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Customtextformfield(
                                                  hintText: "Street Address",
                                                  controller: address),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Customtextformfield(
                                                        hintText: "Mobile",
                                                        controller: mobile),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Expanded(
                                                    child: Customtextformfield(
                                                        hintText: "Email",
                                                        controller: email),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 250,
                                                    child: Customtextformfield(
                                                        hintText: "State",
                                                        controller: state),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  SizedBox(
                                                    width: 250,
                                                    child: Customtextformfield(
                                                        hintText: "EirCode",
                                                        controller: eirCode),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              //save button
                                              GestureDetector(
                                                onTap: () async {
                                                  // Get the current logged-in user
                                                  final user = FirebaseAuth
                                                      .instance.currentUser;
                                                  String orderId = DateTime
                                                          .now()
                                                      .millisecondsSinceEpoch
                                                      .toString();
                                                  String invoiceId = DateTime
                                                          .now()
                                                      .millisecondsSinceEpoch
                                                      .toString();
                                                  DateTime currentDate = DateTime
                                                      .now(); // Get the current date and time
                                                  //update userAddress in users
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection("users")
                                                      .doc(user?.uid)
                                                      .update({
                                                    'userAddress': {
                                                      'address': address.text,
                                                      'firstName': fname.text,
                                                      'lastName': lname.text,
                                                      'email': email.text,
                                                      'eirCode': eirCode.text,
                                                      'state': state.text,
                                                      'mobile': mobile.text
                                                    }
                                                  });

                                                  // Save to Firestore
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                          "orderedDetails")
                                                      .doc(user?.uid)
                                                      .set({
                                                    'orderId': orderId,
                                                    'invoiceId': invoiceId,
                                                    'userId': user?.uid,
                                                    'currentDate':
                                                        currentDate, // Save the current date as a string
                                                    'name':
                                                        "${fname.text} ${lname.text}",
                                                    'address': address.text,
                                                    'mobile': mobile.text,
                                                    'state': state.text,
                                                    'totalPrice':
                                                        widget.totalPrice,
                                                    'cartItems': widget
                                                        .cartItems, // Assuming cartItems is a List<Map<String, dynamic>>
                                                    'paymentMethod': "",
                                                    'timestamp': FieldValue
                                                        .serverTimestamp(), // Optional: Add a timestamp
                                                  }).then((value) {
                                                    print(
                                                        "Order saved successfully!");
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                            backgroundColor:
                                                                Colors.green,
                                                            content: Text(
                                                              "Order saved successfully!",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                            )));
                                                  }).catchError((error) {
                                                    print(
                                                        "Failed to save order: $error");
                                                  });
                                                },
                                                child: Container(
                                                  height: 50,
                                                  alignment: Alignment.center,
                                                  width: 150,
                                                  child: Text(
                                                    "Save this Address",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  decoration: BoxDecoration(
                                                      color: Colors.orange,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),

                                        //order summary box
                                        Container(
                                          // height: 500,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 15),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.grey.shade200)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "Order Summary",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20),
                                                  ),
                                                  //progress indicator
                                                  SizedBox(
                                                    width: 200,
                                                    child:
                                                        LinearPercentIndicator(
                                                      lineHeight: 4.0,
                                                      percent: 0.2,
                                                      backgroundColor:
                                                          Colors.grey.shade300,
                                                      progressColor:
                                                          Colors.orange,
                                                    ),
                                                  )
                                                ],
                                              ),

                                              SizedBox(
                                                height: 20,
                                              ),
                                              SizedBox(
                                                width: 420,
                                                child: Divider(
                                                  color: Colors.grey.shade300,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              //total
                                              Row(
                                                children: [
                                                  Text(
                                                    "Total:",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                  SizedBox(
                                                    width: 320,
                                                  ),
                                                  Text(
                                                    "₹${widget.totalPrice}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 25,
                                              ),
                                              Text(
                                                "Do not refresh this page until payment complete",
                                                style: TextStyle(
                                                    color: Colors.grey.shade600,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Text(
                                                "Complete shipping address for Payment",
                                                style: TextStyle(
                                                    color: Colors.grey.shade600,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 17),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              //place order buttons
                                              GestureDetector(
                                                onTap: () async {
                                                  checkout(widget.totalPrice,
                                                      mobile.text);
                                                  // Get the current logged-in user
                                                  final user = FirebaseAuth
                                                      .instance.currentUser;

                                                  if (user != null) {
                                                    // Perform Razorpay payment
                                                    checkout(widget.totalPrice,
                                                        mobile.text);
                                                    String orderId = DateTime
                                                            .now()
                                                        .millisecondsSinceEpoch
                                                        .toString();
                                                    String invoiceId = DateTime
                                                            .now()
                                                        .millisecondsSinceEpoch
                                                        .toString();
                                                    DateTime currentDate = DateTime
                                                        .now(); // Get the current date and time

                                                    // Define the payment method
                                                    String paymentMethod =
                                                        'Online';

                                                    // Update the paymentMethod field in the current user's document

                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                            "orderedDetails")
                                                        .doc(user
                                                            .uid) // Use the user's UID as the document ID
                                                        .set({
                                                      'orderId': orderId,
                                                      'invoiceId': invoiceId,
                                                      'userId': user.uid,
                                                      'currentDate':
                                                          currentDate, // Save the current date as a string
                                                      'name':
                                                          "${fname.text} ${lname.text}",
                                                      'address': address.text,
                                                      'mobile': mobile.text,
                                                      'state': state.text,
                                                      'totalPrice':
                                                          widget.totalPrice,
                                                      'cartItems': widget
                                                          .cartItems, // Assuming cartItems is a List<Map<String, dynamic>>

                                                      'timestamp': FieldValue
                                                          .serverTimestamp(),
                                                    });
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                            "orderedDetails")
                                                        .doc(user.uid)
                                                        .update({
                                                      'orderId': orderId,
                                                      'invoiceId': invoiceId,
                                                      'userId': user.uid,
                                                      'currentDate':
                                                          currentDate, // Save the current date as a string
                                                      'name':
                                                          "${fname.text} ${lname.text}",
                                                      'address': address.text,
                                                      'mobile': mobile.text,
                                                      'state': state.text,
                                                      'totalPrice':
                                                          widget.totalPrice,
                                                      'cartItems': widget
                                                          .cartItems, // Assuming cartItems is a List<Map<String, dynamic>>
                                                      'paymentMethod':
                                                          paymentMethod,

                                                      'timestamp': FieldValue
                                                          .serverTimestamp(),
                                                    });
                                                  } else {
                                                    print(
                                                        "No user is currently logged in.");
                                                  }
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          backgroundColor:
                                                              Colors.green,
                                                          content: Text(
                                                            "Ordered successfully!",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white),
                                                          )));
                                                },
                                                child: Container(
                                                  height: 40,
                                                  alignment: Alignment.center,
                                                  width: 420,
                                                  child: Text(
                                                    "Place Order via Online",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  // Get the current logged-in user
                                                  final user = FirebaseAuth
                                                      .instance.currentUser;

                                                  if (user != null) {
                                                    // Define the payment method
                                                    String paymentMethod =
                                                        'COD';
                                                    String orderId = DateTime
                                                            .now()
                                                        .millisecondsSinceEpoch
                                                        .toString();
                                                    String invoiceId = DateTime
                                                            .now()
                                                        .millisecondsSinceEpoch
                                                        .toString();
                                                    DateTime currentDate = DateTime
                                                        .now(); // Get the current date and time

                                                    // Update the paymentMethod field in the current user's document

                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                            "orderedDetails")
                                                        .doc(user
                                                            .uid) // Use the user's UID as the document ID
                                                        .set({
                                                      'paymentMethod':
                                                          "", // Update the paymentMethod field
                                                      'orderId': orderId,
                                                      'invoiceId': invoiceId,
                                                      'currentDate':
                                                          currentDate, // Save the current date as a string
                                                      'totalPrice':
                                                          widget.totalPrice,
                                                      'cartItems': widget
                                                          .cartItems, // Assuming cartItems is a List<Map<String, dynamic>>

                                                      // 'timestamp': FieldValue
                                                      //     .serverTimestamp(), // Optional: Add a timestamp
                                                    });
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                            "orderedDetails")
                                                        .doc(user.uid)
                                                        .update({
                                                      'orderId': orderId,
                                                      'invoiceId': invoiceId,
                                                      'userId': user.uid,
                                                      'currentDate':
                                                          currentDate, // Save the current date as a string
                                                      'name':
                                                          "${fname.text} ${lname.text}",
                                                      'address': address.text,
                                                      'mobile': mobile.text,
                                                      'state': state.text,
                                                      'totalPrice':
                                                          widget.totalPrice,
                                                      'cartItems': widget
                                                          .cartItems, // Assuming cartItems is a List<Map<String, dynamic>>
                                                      'paymentMethod':
                                                          paymentMethod,

                                                      'timestamp': FieldValue
                                                          .serverTimestamp(),
                                                    });
                                                  } else {
                                                    print(
                                                        "No user is currently logged in.");
                                                  }
                                                  //to invoice page
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            InvoicePage(),
                                                      ));
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          backgroundColor:
                                                              Colors.green,
                                                          content: Text(
                                                            "Your Order is Placed !!",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 20),
                                                          )));
                                                },
                                                child: Container(
                                                  height: 40,
                                                  alignment: Alignment.center,
                                                  width: 420,
                                                  child: Text(
                                                    "Place Order Cash On Delivery",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "By Placing your order your agree to our company Privacy-policy",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  : //other devices
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: isTablet ? 25 : 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          //textfields
                                          Text(
                                            "Shipment Address",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          isTablet
                                              ? Row(
                                                  children: [
                                                    Expanded(
                                                      child:
                                                          Customtextformfield(
                                                              hintText:
                                                                  "First Name",
                                                              controller:
                                                                  fname),
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Expanded(
                                                      child:
                                                          Customtextformfield(
                                                              hintText:
                                                                  "Last Name",
                                                              controller:
                                                                  lname),
                                                    )
                                                  ],
                                                )
                                              : //mobile
                                              Column(
                                                  children: [
                                                    Customtextformfield(
                                                        hintText: "First Name",
                                                        controller: fname),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Customtextformfield(
                                                        hintText: "Last Name",
                                                        controller: lname)
                                                  ],
                                                ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Customtextformfield(
                                              hintText: "Street Address",
                                              controller: address),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          isTablet
                                              ? Row(
                                                  children: [
                                                    Expanded(
                                                      child:
                                                          Customtextformfield(
                                                              hintText:
                                                                  "Mobile",
                                                              controller:
                                                                  mobile),
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Expanded(
                                                      child:
                                                          Customtextformfield(
                                                              hintText: "Email",
                                                              controller:
                                                                  email),
                                                    )
                                                  ],
                                                )
                                              : //mobile
                                              Column(
                                                  children: [
                                                    Customtextformfield(
                                                        hintText: "Mobile",
                                                        controller: mobile),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Customtextformfield(
                                                        hintText: "Email",
                                                        controller: email),
                                                  ],
                                                ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          isTablet
                                              ? Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 250,
                                                      child:
                                                          Customtextformfield(
                                                              hintText: "State",
                                                              controller:
                                                                  state),
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    SizedBox(
                                                      width: 250,
                                                      child:
                                                          Customtextformfield(
                                                              hintText:
                                                                  "EirCode",
                                                              controller:
                                                                  eirCode),
                                                    )
                                                  ],
                                                )
                                              : //mobile
                                              Column(
                                                  children: [
                                                    Customtextformfield(
                                                        hintText: "State",
                                                        controller: state),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Customtextformfield(
                                                        hintText: "EirCode",
                                                        controller: eirCode),
                                                  ],
                                                ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          //save button
                                          GestureDetector(
                                            onTap: () async {
                                              // Get the current logged-in user
                                              final user = FirebaseAuth
                                                  .instance.currentUser;
                                              String orderId = DateTime.now()
                                                  .millisecondsSinceEpoch
                                                  .toString();
                                              String invoiceId = DateTime.now()
                                                  .millisecondsSinceEpoch
                                                  .toString();
                                              DateTime currentDate = DateTime
                                                  .now(); // Get the current date and time
                                              //update userAddress in users
                                              await FirebaseFirestore.instance
                                                  .collection("users")
                                                  .doc(user?.uid)
                                                  .update({
                                                'userAddress': {
                                                  'address': address.text,
                                                  'firstName': fname.text,
                                                  'lastName': lname.text,
                                                  'email': email.text,
                                                  'eirCode': eirCode.text,
                                                  'state': state.text,
                                                  'mobile': mobile.text
                                                }
                                              });

                                              // Save to Firestore
                                              await FirebaseFirestore.instance
                                                  .collection("orderedDetails")
                                                  .doc(user?.uid)
                                                  .set({
                                                'orderId': orderId,
                                                'invoiceId': invoiceId,
                                                'userId': user?.uid,
                                                'currentDate':
                                                    currentDate, // Save the current date as a string
                                                'name':
                                                    "${fname.text} ${lname.text}",
                                                'address': address.text,
                                                'mobile': mobile.text,
                                                'state': state.text,
                                                'totalPrice': widget.totalPrice,
                                                'cartItems': widget
                                                    .cartItems, // Assuming cartItems is a List<Map<String, dynamic>>
                                                'paymentMethod': "",
                                                // 'timestamp': FieldValue
                                                //     .serverTimestamp(), // Optional: Add a timestamp
                                              }).then((value) {
                                                fname.clear();
                                                lname.clear();
                                                address.clear();
                                                mobile.clear();
                                                state.clear();
                                                email.clear();
                                                eirCode.clear();

                                                print(
                                                    "Order saved successfully!");
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        backgroundColor:
                                                            Colors.green,
                                                        content: Text(
                                                          "Order saved successfully!",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white),
                                                        )));
                                              }).catchError((error) {
                                                print(
                                                    "Failed to save order: $error");
                                              });
                                            },
                                            child: Container(
                                              height: 50,
                                              alignment: Alignment.center,
                                              width: 150,
                                              child: Text(
                                                "Save this Address",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              decoration: BoxDecoration(
                                                  color: Colors.orange,
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                            ),
                                          ),

                                          SizedBox(
                                            height: 15,
                                          ),
                                          //order summary box
                                          Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 15),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        Colors.grey.shade200)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Order Summary",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20),
                                                    ),
                                                    //progress indicator
                                                    SizedBox(
                                                      width:
                                                          isTablet ? 400 : 150,
                                                      child:
                                                          LinearPercentIndicator(
                                                        lineHeight: 4.0,
                                                        percent: 0.2,
                                                        backgroundColor: Colors
                                                            .grey.shade300,
                                                        progressColor:
                                                            Colors.orange,
                                                      ),
                                                    )
                                                  ],
                                                ),

                                                SizedBox(
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 420,
                                                  child: Divider(
                                                    color: Colors.grey.shade300,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                //total
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Total:",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: isTablet
                                                              ? 18
                                                              : 16),
                                                    ),
                                                    Text(
                                                      "₹${widget.totalPrice}",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: isTablet
                                                              ? 18
                                                              : 16),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 25,
                                                ),
                                                Text(
                                                  "Do not refresh this page until payment complete",
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade600,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15),
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Text(
                                                  "Complete shipping address for Payment",
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade600,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 17),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                //place order buttons
                                                GestureDetector(
                                                  onTap: () async {
                                                    // Get the current logged-in user
                                                    final user = FirebaseAuth
                                                        .instance.currentUser;

                                                    if (user != null) {
                                                      // Perform Razorpay payment
                                                      checkout(
                                                          widget.totalPrice,
                                                          mobile.text);

                                                      // Define the payment method
                                                      String paymentMethod =
                                                          'Online';
                                                      String orderId = DateTime
                                                              .now()
                                                          .millisecondsSinceEpoch
                                                          .toString();
                                                      String invoiceId = DateTime
                                                              .now()
                                                          .millisecondsSinceEpoch
                                                          .toString();
                                                      DateTime currentDate =
                                                          DateTime
                                                              .now(); // Get the current date and time

                                                      // Update the paymentMethod field in the current user's document

                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              "orderedDetails")
                                                          .doc(user
                                                              .uid) // Use the user's UID as the document ID
                                                          .set({
                                                        'paymentMethod':
                                                            "", // Update the paymentMethod field
                                                        'orderId': orderId,
                                                        'invoiceId': invoiceId,
                                                        'currentDate':
                                                            currentDate, // Save the current date as a string

                                                        'totalPrice':
                                                            widget.totalPrice,
                                                        'cartItems': widget
                                                            .cartItems, // Assuming cartItems is a List<Map<String, dynamic>>

                                                        // 'timestamp': FieldValue
                                                        //     .serverTimestamp(), // Optional: Add a timestamp
                                                      });
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              "orderedDetails")
                                                          .doc(user.uid)
                                                          .update({
                                                        'orderId': orderId,
                                                        'invoiceId': invoiceId,
                                                        'userId': user.uid,
                                                        'currentDate':
                                                            currentDate, // Save the current date as a string
                                                        'name':
                                                            "${fname.text} ${lname.text}",
                                                        'address': address.text,
                                                        'mobile': mobile.text,
                                                        'state': state.text,
                                                        'totalPrice':
                                                            widget.totalPrice,
                                                        'cartItems': widget
                                                            .cartItems, // Assuming cartItems is a List<Map<String, dynamic>>
                                                        'paymentMethod':
                                                            paymentMethod,

                                                        'timestamp': FieldValue
                                                            .serverTimestamp(),
                                                      });
                                                    } else {
                                                      print(
                                                          "No user is currently logged in.");
                                                    }
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    alignment: Alignment.center,
                                                    width: double.infinity,
                                                    child: Text(
                                                      "Place Order via Online",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    decoration: BoxDecoration(
                                                        color: Colors.blue,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    // Get the current logged-in user
                                                    final user = FirebaseAuth
                                                        .instance.currentUser;

                                                    if (user != null) {
                                                      // Define the payment method
                                                      String paymentMethod =
                                                          'COD';
                                                      String orderId = DateTime
                                                              .now()
                                                          .millisecondsSinceEpoch
                                                          .toString();
                                                      String invoiceId = DateTime
                                                              .now()
                                                          .millisecondsSinceEpoch
                                                          .toString();
                                                      DateTime currentDate =
                                                          DateTime
                                                              .now(); // Get the current date and time

                                                      // Update the paymentMethod field in the current user's document

                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              "orderedDetails")
                                                          .doc(user
                                                              .uid) // Use the user's UID as the document ID
                                                          .set({
                                                        'paymentMethod':
                                                            "", // Update the paymentMethod field
                                                        'orderId': orderId,
                                                        'invoiceId': invoiceId,
                                                        'currentDate':
                                                            currentDate, // Save the current date as a string

                                                        'totalPrice':
                                                            widget.totalPrice,
                                                        'cartItems': widget
                                                            .cartItems, // Assuming cartItems is a List<Map<String, dynamic>>

                                                        // 'timestamp': FieldValue
                                                        //     .serverTimestamp(), // Optional: Add a timestamp
                                                      });
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              "orderedDetails")
                                                          .doc(user.uid)
                                                          .update({
                                                        'orderId': orderId,
                                                        'invoiceId': invoiceId,
                                                        'userId': user.uid,
                                                        'currentDate':
                                                            currentDate, // Save the current date as a string
                                                        'name':
                                                            "${fname.text} ${lname.text}",
                                                        'address': address.text,
                                                        'mobile': mobile.text,
                                                        'state': state.text,
                                                        'totalPrice':
                                                            widget.totalPrice,
                                                        'cartItems': widget
                                                            .cartItems, // Assuming cartItems is a List<Map<String, dynamic>>
                                                        'paymentMethod':
                                                            paymentMethod,

                                                        'timestamp': FieldValue
                                                            .serverTimestamp(),
                                                      });
                                                    } else {
                                                      print(
                                                          "No user is currently logged in.");
                                                    }
                                                    //to invoice page
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              InvoicePage(),
                                                        ));
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                            backgroundColor:
                                                                Colors.green,
                                                            content: Text(
                                                              "Your Order is Placed !!",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 20),
                                                            )));
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    alignment: Alignment.center,
                                                    width: double.infinity,
                                                    child: Text(
                                                      "Place Order Cash On Delivery",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                isTablet
                                                    ? Row(
                                                        children: [
                                                          Text(
                                                            "By Placing your order your agree to our company",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            "Privacy-policy",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .green,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                          ),
                                                        ],
                                                      )
                                                    : //mobile
                                                    Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "By Placing your order your agree to our company",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            "Privacy-policy",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .green,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                          ),
                                                        ],
                                                      ),
                                              ],
                                            ),
                                          )
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
