import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({super.key});

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  String invoiceId = '';
  String orderId = '';
  String orderDate = '';
  String address = '';
  String state = '';
  String paymentMethod = '';
  num totalPrice = 0;
  List orderedItems = [];

  // Fetching order details from Firestore
  void _fetchOrderDetails() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        final orderDoc = await FirebaseFirestore.instance
            .collection('orderedDetails')
            .doc(userId)
            .get();
        final orderData = orderDoc.data();

        if (orderData != null) {
          setState(() {
            invoiceId = orderData['invoiceId'] ?? 'N/A';
            orderId = orderData['orderId'] ?? 'N/A';
            Timestamp timestamp = orderData['currentDate'] ?? Timestamp.now();
            orderDate =
                "${timestamp.toDate().day}-${timestamp.toDate().month}-${timestamp.toDate().year}";
            address = orderData['address'] ?? 'N/A';
            state = orderData['state'] ?? 'N/A';
            paymentMethod = orderData['paymentMethod'] ?? 'N/A';
            totalPrice = orderData['totalPrice'] ?? 'N/A';
            orderedItems = orderData['cartItems'];
          });
        }
      }
    } catch (e) {
      print("Error fetching order details: $e");
    }
  }

  @override
  void initState() {
    _fetchOrderDetails();
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

    final List purchase = [
      {
        'sr': '1',
        'image': 'assets/images/currypowder.jpg',
        'product': 'sambar powder',
        'qty': '1',
        'price': '3.0',
        'amount': '3.69'
      },
      {
        'sr': '2',
        'image': 'assets/images/currypowder.jpg',
        'product': 'rasam powder',
        'qty': '1',
        'price': '4.0',
        'amount': '4.92'
      },
    ];
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 150 : 10,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade200)),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //title
                  isMobile
                      ? Column(
                          children: [
                            //logo
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Go",
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 50),
                                    ),
                                    Text(
                                      "mart",
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 50),
                                    ),
                                  ],
                                ),
                                Text(
                                  "LetterKenny ,Co.Donegal, Ireland",
                                  style: TextStyle(
                                      color: Colors.grey.shade800,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            //title
                            Row(
                              children: [
                                Text(
                                  "Invoice",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 25,
                                  width: 150,
                                  child: Center(
                                      child: Text(
                                    "Placed Order",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  )),
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(20)),
                                )
                              ],
                            ),
                            //details
                            //numbr
                            Row(
                              children: [
                                Text(
                                  "Invoice No",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  width: 11,
                                ),
                                Text(
                                  invoiceId,
                                  style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            //id
                            Row(
                              children: [
                                Text(
                                  "Order ID",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  orderDate,
                                  style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            //date
                            Row(
                              children: [
                                Text(
                                  "Date",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  width: 55,
                                ),
                                Text(
                                  orderDate,
                                  style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18),
                                ),
                              ],
                            )
                          ],
                        )
                      //other devices
                      : Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Invoice",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 25,
                                  width: 150,
                                  child: Center(
                                      child: Text(
                                    "Placed Order",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  )),
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(20)),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            //details
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //numbr
                                    Row(
                                      children: [
                                        Text(
                                          "Invoice No",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        SizedBox(
                                          width: 11,
                                        ),
                                        Text(
                                          invoiceId,
                                          style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 18),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    //id
                                    Row(
                                      children: [
                                        Text(
                                          "Order ID",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Text(
                                          orderId,
                                          style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 18),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    //date
                                    Row(
                                      children: [
                                        Text(
                                          "Date",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        SizedBox(
                                          width: 55,
                                        ),
                                        Text(
                                          orderDate,
                                          style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 18),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                //gomart logo
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Go",
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 50),
                                        ),
                                        Text(
                                          "mart",
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 50),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "LetterKenny ,Co.Donegal, Ireland",
                                      style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                  Divider(),
                  SizedBox(
                    height: 20,
                  ),
                  //address
                  isMobile
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Here are your order details.We thank you for your purchase.",
                              style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Shipping Address",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              '$address, $state',
                              style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18),
                            ),
                          ],
                        )
                      :
                      //other devices
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "Here are your order details.We thank you for your purchase.",
                                style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Shipping Address",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    '$address, $state',
                                    style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                  SizedBox(
                    height: 15,
                  ),
                  //table
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      dataRowHeight: 80,
                      columns: const [
                        DataColumn(
                            label: Text(
                          'SR',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: 18),
                        )),
                        DataColumn(
                            label: Text(
                          'Products',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: 18),
                        )),
                        DataColumn(
                            label: Text(
                          'QTY',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: 16),
                        )),
                        DataColumn(
                            label: Text(
                          'Item Price',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: 16),
                        )),
                        DataColumn(
                            label: Text(
                          'Amount',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: 16),
                        )),
                      ],
                      rows: orderedItems.asMap().entries.map((entry) {
                        int index = entry.key;
                        var item = entry.value;

                        return DataRow(
                          cells: [
                            // Serial Number
                            DataCell(Text(
                              (index + 1).toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            )),

                            // Product with Image and Name
                            DataCell(Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.grey.shade300,
                                  radius: 20,
                                  backgroundImage: item['productUrl'] != null
                                      ? NetworkImage(item[
                                          'productUrl']) // Assuming image URLs are stored in Firestore
                                      : AssetImage(
                                              'assets/images/placeholder.png')
                                          as ImageProvider, // Placeholder if no image
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    item['productName'] ?? 'Unknown Product',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            )),

                            // Quantity
                            DataCell(Text(
                              item['quantity']?.toString() ?? '0',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            )),

                            // Item Price
                            DataCell(Text(
                              item['originalPrice']?.toString() ?? '0.0',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            )),

                            // Amount (calculated if needed)
                            DataCell(Text(
                              ((item['quantity'] ?? 0) *
                                      (item['ourPrice'] ?? 0))
                                  .toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            )),
                          ],
                        );
                      }).toList(),
                    ),
                  ),

                  //method cost
                  SizedBox(
                    height: 15,
                  ),
                  isMobile
                      ? Container(
                          width: double.infinity,
                          color: Colors.grey.shade300,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Payment Method",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                paymentMethod,
                                style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Shipping Cost",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "4.95",
                                style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Total Amount",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "$totalPrice",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        )
                      :
                      //other devices
                      Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Payment Method",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    paymentMethod,
                                    style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Shipping Cost",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "4.95",
                                    style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total Amount",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "$totalPrice",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                          ),
                        ),
                  SizedBox(
                    height: 20,
                  ),

                  //download button
                  Container(
                    height: 45,
                    width: 150,
                    child: Center(
                      child: Text(
                        "Download Invoice",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10)),
                  )

                  //end
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
