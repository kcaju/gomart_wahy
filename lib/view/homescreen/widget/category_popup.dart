import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gomart_wahy/view/shopbycategory_screen/category_screen.dart';

class CategoryPopup extends StatelessWidget {
  const CategoryPopup({super.key});

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Determine screen type based on width
    bool isMobile = screenWidth < 600;
    bool isTablet = screenWidth >= 600 && screenWidth < 1024;
    bool isDesktop = screenWidth >= 1024;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("Categories").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No Categories found."));
        }

        final List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
        // List of categories fetched from Firestore
        List<Map<String, dynamic>> categories = snapshot.data!.docs.map((doc) {
          return {
            "name": doc["categoryName"],
            "image": doc["categoryUrl"],
            'products': doc['products']
          };
        }).toList();
        return PopupMenuButton<int>(
          child: Row(
            children: [
              Text(
                "Browse Category",
                style: TextStyle(
                    fontSize: isDesktop ? 16 : 18,
                    color: Colors.green,
                    fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.keyboard_arrow_down,
                color: Colors.green,
              ),
            ],
          ),
          onSelected: (value) {
            // Navigate to the corresponding category page
            final selectedCategory = categories[value];
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CategoryScreen(
                  products: selectedCategory['products'],
                ),
              ),
            );
          },
          itemBuilder: (context) {
            return List.generate(
              documents.length,
              (index) => PopupMenuItem(
                value: index, // Pass the index as the value
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage(categories[index]["image"]),
                    ),
                    SizedBox(width: 10),
                    Text(
                      categories[index]["name"],
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          },
          offset: Offset(0, 50), // Adjusts the popup position
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        );
      },
    );
  }
}
