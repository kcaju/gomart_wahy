import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderhistoryBox extends StatefulWidget {
  const OrderhistoryBox({super.key});

  @override
  State<OrderhistoryBox> createState() => _OrderhistoryBoxState();
}

class _OrderhistoryBoxState extends State<OrderhistoryBox> {
  late Future<List<Map<String, dynamic>>> ordersFuture;

  @override
  void initState() {
    super.initState();
    ordersFuture = fetchOrders();
  }

  String formatDate(DateTime dateTime) {
    // List of month names
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];

    String month = months[dateTime.month - 1]; // Get month name
    String day = dateTime.day.toString();
    String year = dateTime.year.toString();

    return "$month $day, $year"; // e.g., "Feb 8, 2025"
  }

  Future<List<Map<String, dynamic>>> fetchOrders() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('No user signed in');
    }

    final snapshot = await FirebaseFirestore.instance
        .collection('orderedDetails')
        .where('userId', isEqualTo: user.uid) // Ensure 'uid' is used correctly
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();

      // Convert Timestamp to formatted date string
      if (data['currentDate'] != null && data['currentDate'] is Timestamp) {
        DateTime dateTime = (data['currentDate'] as Timestamp).toDate();
        data['currentDate'] = formatDate(dateTime); // Use custom formatter
      }

      return data;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Recent Orders",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 15),
          FutureBuilder<List<Map<String, dynamic>>>(
            future: ordersFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text('No orders found.');
              }

              final orders = snapshot.data!;
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(
                      label: Text('Order Number#',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                    ),
                    DataColumn(
                      label: Text('Placed on',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                    ),
                    DataColumn(
                      label: Text('Method',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                    ),
                    DataColumn(
                      label: Text('Total',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                    ),
                  ],
                  rows: orders.map((order) {
                    return DataRow(
                      cells: [
                        DataCell(Text(
                          order['orderId'] ?? 'N/A',
                          style: TextStyle(
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        )),
                        DataCell(Text(
                          order['currentDate'] ?? 'N/A',
                          style: TextStyle(
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        )),
                        DataCell(Text(
                          order['paymentMethod'] ?? 'N/A',
                          style: TextStyle(
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        )),
                        DataCell(Text(
                          '₹${order['totalPrice'].toString()}',
                          style: TextStyle(
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        )),
                      ],
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
