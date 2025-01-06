import 'package:flutter/material.dart';

class OrdertrackingBox extends StatelessWidget {
  const OrdertrackingBox({super.key});

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Determine screen type based on width
    bool isMobile = screenWidth < 600;
    bool isTablet = screenWidth >= 600 && screenWidth <= 1024;
    bool isDesktop = screenWidth > 1024;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
          color: Colors.white, border: Border.all(color: Colors.grey.shade200)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order Tracking",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(
            height: 10,
          ),
          //tracking row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 30,
              ),
              SizedBox(
                width: isMobile ? 55 : 110,
                child: Divider(
                  color: Colors.green,
                  thickness: 2,
                ),
              ),
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 30,
              ),
              SizedBox(
                width: isMobile ? 55 : 110,
                child: Divider(
                  color: Colors.green,
                  thickness: 2,
                ),
              ),
              Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                child: Text(
                  "3",
                  style: TextStyle(color: Colors.green),
                ),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.green, width: 2)),
              ),
              SizedBox(
                width: isMobile ? 55 : 110,
                child: Divider(
                  color: Colors.grey.shade400,
                  thickness: 2,
                ),
              ),
              Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                child: Text(
                  "4",
                  style: TextStyle(color: Colors.grey.shade700),
                ),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade200, width: 2)),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          //order status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Order Placed",
                style: TextStyle(color: Colors.green),
              ),
              Text(
                "Processing",
                style: TextStyle(color: Colors.green),
              ),
              Text(
                "On the Way",
                style: TextStyle(color: Colors.green),
              ),
              Text(
                "Delivered",
                style: TextStyle(color: Colors.grey.shade700),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          //order status

          Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
            child: Column(
              children: [
                Row(
                  children: [
                    isMobile
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Date &",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              Text(
                                "Time",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              )
                            ],
                          )
                        : Text(
                            "Date & Time",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                    SizedBox(
                      width: 100,
                    ),
                    Text(
                      "Status Info",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ],
                ),
                //date and status
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    isMobile
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "14 Feb",
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15),
                              ),
                              Text(
                                "2023",
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15),
                              ),
                              Text(
                                "13:19",
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15),
                              ),
                            ],
                          )
                        : Text(
                            "14 Feb 2023 - 13:19",
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.normal,
                                fontSize: 15),
                          ),
                    SizedBox(
                      width: isMobile ? 95 : 50,
                    ),
                    Expanded(
                      child: Text(
                        "Your package has been delivered. Thank you for shopping at Gomart!",
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.normal,
                            fontSize: 15),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    isMobile
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "13 Feb",
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15),
                              ),
                              Text(
                                "2023 -",
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15),
                              ),
                              Text(
                                "13:39",
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15),
                              ),
                            ],
                          )
                        : Text(
                            "13 Feb 2023 - 13:39",
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.normal,
                                fontSize: 15),
                          ),
                    SizedBox(
                      width: isMobile ? 95 : 50,
                    ),
                    Expanded(
                      child: Text(
                        "	Your package has been handed over to Gomart Delivery.",
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.normal,
                            fontSize: 15),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    isMobile
                        ? Column(
                            children: [
                              Text(
                                "12 Feb",
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15),
                              ),
                              Text(
                                "2023 -",
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15),
                              ),
                              Text(
                                "14:50",
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15),
                              ),
                            ],
                          )
                        : Text(
                            "12 Feb 2023 - 14:50",
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.normal,
                                fontSize: 15),
                          ),
                    SizedBox(
                      width: isMobile ? 95 : 50,
                    ),
                    Expanded(
                      child: Text(
                        "	Your package has been packed and is being handed over to a logistics partner",
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.normal,
                            fontSize: 15),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    isMobile
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "12 Feb",
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15),
                              ),
                              Text(
                                "2023 -",
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15),
                              ),
                              Text(
                                "13:05",
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15),
                              ),
                            ],
                          )
                        : Text(
                            "12 Feb 2023 - 13:05",
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.normal,
                                fontSize: 15),
                          ),
                    SizedBox(
                      width: isMobile ? 95 : 50,
                    ),
                    Expanded(
                      child: Text(
                        "Your order has been successfully verified.",
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.normal,
                            fontSize: 15),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    isMobile
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "12 Feb",
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15),
                              ),
                              Text(
                                "2023 -",
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15),
                              ),
                              Text(
                                "13:05",
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15),
                              ),
                            ],
                          )
                        : Text(
                            "12 Feb 2023 - 13:05",
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.normal,
                                fontSize: 15),
                          ),
                    SizedBox(
                      width: isMobile ? 95 : 50,
                    ),
                    Expanded(
                      child: Text(
                        "Thank you for shopping at Gomart! Your order is being verified.",
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.normal,
                            fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            decoration:
                BoxDecoration(border: Border.all(color: Colors.grey.shade300)),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
