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
              ListView.separated(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(DummyDb.draweritems[index]['image']),
                      ),
                      title: Text(
                        DummyDb.draweritems[index]['name'],
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
                              builder: (context) => CategoryScreen(),
                            ));
                      },
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                        height: 5,
                      ),
                  itemCount: DummyDb.draweritems.length),
            ],
          ),
        ),
      ),
    );
  }
}
