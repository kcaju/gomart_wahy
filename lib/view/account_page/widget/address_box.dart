import 'package:flutter/material.dart';
import 'package:gomart_wahy/view/account_page/widget/alertbox_fields.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({super.key});

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Determine screen type based on width
    bool isMobile = screenWidth < 600;
    bool isTablet = screenWidth >= 600 && screenWidth <= 1024;
    bool isDesktop = screenWidth > 1024;
    return Column(
      children: [
        isDesktop
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 13),
                child: Row(
                  children: [
                    //defalut address
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Address Book",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Defalut Shipping Address",
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //fname lname
                          Row(
                            children: [
                              Text(
                                "Fname",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Lname",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "street, state, eircode",
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          ),
                          Text(
                            "123456789",
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                                fontSize: 17),
                          ),
                          GestureDetector(
                            onTap: () {
                              //alert box
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertboxFields();
                                },
                              );
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: Colors.green,
                                ),
                                Text(
                                  "Edit",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    //billing address
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Defalut Billing Address",
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              //alert box
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertboxFields();
                                },
                              );
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: Colors.green,
                                ),
                                Text(
                                  "Edit",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade200)),
              )
            :
            //other devices
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 13),
                child: isTablet
                    ? Row(
                        children: [
                          //defalut address
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Address Book",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Defalut Shipping Address",
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                //fname lname
                                Row(
                                  children: [
                                    Text(
                                      "Fname",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Lname",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "street, state, eircode",
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                Text(
                                  "123456789",
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    //alert box
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertboxFields();
                                      },
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.edit,
                                        color: Colors.green,
                                      ),
                                      Text(
                                        "Edit",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          //billing address
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Defalut Billing Address",
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    //alert box
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertboxFields();
                                      },
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.edit,
                                        color: Colors.green,
                                      ),
                                      Text(
                                        "Edit",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    : //mobile
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Address Book",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Defalut Shipping Address",
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //fname lname
                          Row(
                            children: [
                              Text(
                                "Fname",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Lname",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "street, state, eircode",
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          ),
                          Text(
                            "123456789",
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                                fontSize: 17),
                          ),
                          GestureDetector(
                            onTap: () {
                              //alert box
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertboxFields();
                                },
                              );
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: Colors.green,
                                ),
                                Text(
                                  "Edit",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          //billing address
                          Text(
                            "Defalut Billing Address",
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              //alert box
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertboxFields();
                                },
                              );
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: Colors.green,
                                ),
                                Text(
                                  "Edit",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade200)),
              ),
      ],
    );
  }
}
