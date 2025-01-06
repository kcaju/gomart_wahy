import 'package:flutter/material.dart';
import 'package:gomart_wahy/view/floatingactionbutton/custom_floatingbutton.dart';
import 'package:gomart_wahy/view/homescreen/drawerscreen/drawer_screen.dart';
import 'package:gomart_wahy/view/homescreen/home_screen.dart';
import 'package:gomart_wahy/view/homescreen/widget/customtextformfield.dart';
import 'package:gomart_wahy/view/homescreen/widget/header_greencard.dart';
import 'package:gomart_wahy/view/homescreen/widget/header_whitebox.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

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
  bool isBillingSameAsShipping = false;
  bool useAnotherAddressForBilling = false;
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
                                            Container(
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
                                            SizedBox(
                                              height: 10,
                                            ),
                                            //checkboxes
                                            Row(
                                              children: [
                                                Checkbox(
                                                  activeColor: Colors.green,
                                                  value:
                                                      isBillingSameAsShipping,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      isBillingSameAsShipping =
                                                          value!;
                                                    });
                                                  },
                                                ),
                                                Text(
                                                  "Billing same as Shipping address",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Checkbox(
                                                  activeColor: Colors.green,
                                                  value:
                                                      useAnotherAddressForBilling,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      useAnotherAddressForBilling =
                                                          value!;
                                                    });
                                                  },
                                                ),
                                                Text(
                                                  "Use Another Address for Billing",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ],
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
                                                  child: LinearPercentIndicator(
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
                                            //price
                                            Row(
                                              children: [
                                                Text(
                                                  "Items(2):",
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade600,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16),
                                                ),
                                                SizedBox(
                                                  width: 300,
                                                ),
                                                Text(
                                                  "₹11.07",
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade600,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            //shippingprice
                                            Row(
                                              children: [
                                                Text(
                                                  "Shipping & handling:",
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade600,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16),
                                                ),
                                                SizedBox(
                                                  width: 220,
                                                ),
                                                Text(
                                                  "₹4.95",
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade600,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16),
                                                ),
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
                                                  "₹16.02",
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
                                            Container(
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
                                                      BorderRadius.circular(8)),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Container(
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
                                                      BorderRadius.circular(8)),
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
                                        Container(
                                          height: 50,
                                          alignment: Alignment.center,
                                          width: 150,
                                          child: Text(
                                            "Save this Address",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          decoration: BoxDecoration(
                                              color: Colors.orange,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        //checkboxes
                                        Row(
                                          children: [
                                            Checkbox(
                                              activeColor: Colors.green,
                                              value: isBillingSameAsShipping,
                                              onChanged: (value) {
                                                setState(() {
                                                  isBillingSameAsShipping =
                                                      value!;
                                                });
                                              },
                                            ),
                                            Text(
                                              "Billing same as Shipping address",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Checkbox(
                                              activeColor: Colors.green,
                                              value:
                                                  useAnotherAddressForBilling,
                                              onChanged: (value) {
                                                setState(() {
                                                  useAnotherAddressForBilling =
                                                      value!;
                                                });
                                              },
                                            ),
                                            Text(
                                              "Use Another Address for Billing",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ],
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
                                                    width: isTablet ? 400 : 180,
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
                                              //price
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Items(2):",
                                                    style: TextStyle(
                                                        color: Colors
                                                            .grey.shade600,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize:
                                                            isTablet ? 18 : 16),
                                                  ),
                                                  Text(
                                                    "₹11.07",
                                                    style: TextStyle(
                                                        color: Colors
                                                            .grey.shade600,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize:
                                                            isTablet ? 18 : 16),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              //shippingprice
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Shipping & handling:",
                                                    style: TextStyle(
                                                        color: Colors
                                                            .grey.shade600,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize:
                                                            isTablet ? 18 : 16),
                                                  ),
                                                  Text(
                                                    "₹4.95",
                                                    style: TextStyle(
                                                        color: Colors
                                                            .grey.shade600,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize:
                                                            isTablet ? 18 : 16),
                                                  ),
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
                                                        fontSize:
                                                            isTablet ? 18 : 16),
                                                  ),
                                                  Text(
                                                    "₹16.02",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            isTablet ? 18 : 16),
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
                                              Container(
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
                                                        BorderRadius.circular(
                                                            8)),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Container(
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
                                                        BorderRadius.circular(
                                                            8)),
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
                                                              color:
                                                                  Colors.green,
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
                                                              color:
                                                                  Colors.green,
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
