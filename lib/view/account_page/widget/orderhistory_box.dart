import 'package:flutter/material.dart';

class OrderhistoryBox extends StatefulWidget {
  const OrderhistoryBox({super.key});

  @override
  State<OrderhistoryBox> createState() => _OrderhistoryBoxState();
}

class _OrderhistoryBoxState extends State<OrderhistoryBox> {
  final List<Map<String, String>> orders = const [
    {
      'Order Number#': '12345',
      'Placed on': 'Jan 5, 2025',
      'Method': 'Credit Card',
      'Total': '\$100.00',
      'Action': 'status'
    },
    {
      'Order Number#': '12346',
      'Placed on': 'Jan 4, 2025',
      'Method': 'PayPal',
      'Total': '\$200.00',
      'Action': 'status'
    },
    {
      'Order Number#': '12347',
      'Placed on': 'Jan 3, 2025',
      'Method': 'Cash',
      'Total': '\$300.00',
      'Action': 'status'
    },
  ];
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
            "Recent Orders",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(
            height: 15,
          ),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(
                    label: Text(
                  'Order Number#',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                )),
                DataColumn(
                    label: Text(
                  'Placed on',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                )),
                DataColumn(
                    label: Text(
                  'Method',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                )),
                DataColumn(
                    label: Text(
                  'Total',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                )),
                DataColumn(
                    label: Text(
                  'Action',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                )),
              ],
              rows: List.generate(
                orders.length,
                (index) {
                  final order = orders[index];
                  return DataRow(
                    cells: [
                      DataCell(Text(
                        order['Order Number#']!,
                        style: TextStyle(
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      )),
                      DataCell(Text(
                        order['Placed on']!,
                        style: TextStyle(
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      )),
                      DataCell(Text(
                        order['Method']!,
                        style: TextStyle(
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      )),
                      DataCell(Text(
                        order['Total']!,
                        style: TextStyle(
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      )),
                      DataCell(Text(
                        order['Action']!,
                        style: TextStyle(
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      )),
                    ],
                  );
                },
              ),
            ),
          )

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       "Order Number#",
          //       style: TextStyle(
          //           color: Colors.grey.shade800,
          //           fontWeight: FontWeight.w900,
          //           fontSize: 18),
          //     ),
          //     Text(
          //       "Placed On",
          //       style: TextStyle(
          //           color: Colors.grey.shade800,
          //           fontWeight: FontWeight.w900,
          //           fontSize: 18),
          //     ),
          //     Text(
          //       "Method",
          //       style: TextStyle(
          //           color: Colors.grey.shade800,
          //           fontWeight: FontWeight.w900,
          //           fontSize: 18),
          //     ),
          //     Text(
          //       "Total",
          //       style: TextStyle(
          //           color: Colors.grey.shade800,
          //           fontWeight: FontWeight.w900,
          //           fontSize: 18),
          //     ),
          //     Text(
          //       "Action",
          //       style: TextStyle(
          //           color: Colors.grey.shade800,
          //           fontWeight: FontWeight.w900,
          //           fontSize: 18),
          //     ),
          //     SizedBox()
          //   ],
          // ),
          // SizedBox(
          //   height: 15,
          // ),
          // //order lists
          // ListView.separated(
          //     shrinkWrap: true,
          //     physics: ScrollPhysics(),
          //     itemBuilder: (context, index) {
          //       return Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //             "Order Number",
          //             style: TextStyle(
          //                 color: Colors.grey.shade800,
          //                 fontWeight: FontWeight.w900,
          //                 fontSize: 18),
          //           ),
          //           Text(
          //             "Date",
          //             style: TextStyle(
          //                 color: Colors.grey.shade800,
          //                 fontWeight: FontWeight.w900,
          //                 fontSize: 18),
          //           ),
          //           Text(
          //             "Online",
          //             style: TextStyle(
          //                 color: Colors.grey.shade800,
          //                 fontWeight: FontWeight.w900,
          //                 fontSize: 18),
          //           ),
          //           Text(
          //             "₹",
          //             style: TextStyle(
          //                 color: Colors.grey.shade800,
          //                 fontWeight: FontWeight.w900,
          //                 fontSize: 18),
          //           ),
          //           Text(
          //             "status",
          //             style: TextStyle(
          //                 color: Colors.grey.shade800,
          //                 fontWeight: FontWeight.w900,
          //                 fontSize: 18),
          //           ),
          //           SizedBox()
          //         ],
          //       );
          //     },
          //     separatorBuilder: (context, index) => SizedBox(
          //           height: 10,
          //         ),
          //     itemCount: 2)
        ],
      ),
    );
  }
}
