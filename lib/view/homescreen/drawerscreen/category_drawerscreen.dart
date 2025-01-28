import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gomart_wahy/dummy_db.dart';
import 'package:gomart_wahy/view/shopbycategory_screen/category_screen.dart';

class CategoryDrawerscreen extends StatefulWidget {
  const CategoryDrawerscreen({super.key});

  @override
  State<CategoryDrawerscreen> createState() => _CategoryDrawerscreenState();
}

class _CategoryDrawerscreenState extends State<CategoryDrawerscreen> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        width: 300,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Go",
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "mart",
                        style: TextStyle(
                            color: Color(0xFF03AC13),
                            fontSize: 32,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: CircleAvatar(
                      radius: 13,
                      backgroundColor: Colors.pink.shade50,
                      child: Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              // List of Products
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Categories")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("No Categories found."));
                  }

                  final List<QueryDocumentSnapshot> documents =
                      snapshot.data!.docs;
                  return ListView.separated(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final categories = documents[index];
                        final products = categories['products'];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(categories['categoryUrl']),
                          ),
                          title: Text(
                            categories['categoryName'],
                            style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            // Handle tap
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoryScreen(
                                    products: products,
                                  ),
                                ));
                          },
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                            height: 5,
                          ),
                      itemCount: documents.length);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
