import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfiledeatilsBox extends StatefulWidget {
  const ProfiledeatilsBox({super.key});

  @override
  State<ProfiledeatilsBox> createState() => _ProfiledeatilsBoxState();
}

class _ProfiledeatilsBoxState extends State<ProfiledeatilsBox> {
  String? userName;
  Map<String, dynamic>? userData;
  bool isLoading = true;

  Future<void> fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedName =
        prefs.getString('name'); // Retrieve name from local storage

    if (savedName != null) {
      try {
        // Query Firestore to find user document where the name matches
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('name', isEqualTo: savedName)
            .limit(1) // Limit to one document
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          setState(() {
            userName = savedName;
            userData = querySnapshot.docs.first.data() as Map<String, dynamic>;
          });
        } else {
          print("No user found with name: $savedName");
        }
      } catch (e) {
        print("Error fetching user data: $e");
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    fetchUserData();
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

    return Container(
      child: isDesktop
          ? Row(
              children: [
                //image
                Container(
                  width: 200,
                  child: Image.asset(
                    "assets/png/client-2.png",
                    height: 200,
                  ),
                ),
                //details
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userData?['name'] ?? "Name",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                          color: Colors.grey.shade600,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          userData?['mobile'] ?? "#######",
                          style: TextStyle(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.normal,
                              fontSize: 16),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.email,
                          color: Colors.grey.shade600,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          userData?['email'] ?? "#######",
                          style: TextStyle(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.normal,
                              fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        //order
                        SizedBox(
                          width: 250,
                          child: ListTile(
                            leading: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.green.shade100),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.shopping_bag_outlined,
                                size: 30,
                                color: Colors.green,
                              ),
                            ),
                            title: Text(
                              "0",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ),
                            subtitle: Text(
                              "Total Orders",
                              style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),

                        //processing
                        SizedBox(
                          width: 250,
                          child: ListTile(
                            leading: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.orange.shade100),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.recycling,
                                size: 30,
                                color: Colors.orange,
                              ),
                            ),
                            title: Text(
                              "0",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ),
                            subtitle: Text(
                              "Order Processing",
                              style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),

                        //total deliver
                        SizedBox(
                          width: 250,
                          child: ListTile(
                            leading: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.blue.shade100),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.local_shipping_outlined,
                                size: 30,
                                color: Colors.blue,
                              ),
                            ),
                            title: Text(
                              "0",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ),
                            subtitle: Text(
                              "Total Delivered",
                              style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            )
          : //other devices
          Padding(
              padding: EdgeInsets.symmetric(horizontal: isTablet ? 20 : 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //image
                  Container(
                    width: 200,
                    child: Image.asset(
                      "assets/png/client-2.png",
                      height: 180,
                    ),
                  ),
                  //name
                  Text(
                    "Name",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        color: Colors.grey.shade600,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "123456789",
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.normal,
                            fontSize: 16),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.email,
                        color: Colors.grey.shade600,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "name@gmail.com",
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.normal,
                            fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  isTablet
                      ? Row(
                          children: [
                            //order
                            SizedBox(
                              width: 220,
                              child: ListTile(
                                leading: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.green.shade100),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.shopping_bag_outlined,
                                    size: 30,
                                    color: Colors.green,
                                  ),
                                ),
                                title: Text(
                                  "0",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                ),
                                subtitle: Text(
                                  "Total Orders",
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),

                            //processing
                            SizedBox(
                              width: 220,
                              child: ListTile(
                                leading: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.orange.shade100),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.recycling,
                                    size: 30,
                                    color: Colors.orange,
                                  ),
                                ),
                                title: Text(
                                  "0",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                ),
                                subtitle: Text(
                                  "Order Processing",
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),

                            //total deliver
                            SizedBox(
                              width: 220,
                              child: ListTile(
                                leading: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.blue.shade100),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.local_shipping_outlined,
                                    size: 30,
                                    color: Colors.blue,
                                  ),
                                ),
                                title: Text(
                                  "0",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                ),
                                subtitle: Text(
                                  "Total Delivered",
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18),
                                ),
                              ),
                            )
                          ],
                        )
                      : //mobile
                      Column(
                          children: [
                            //order
                            SizedBox(
                              width: 220,
                              child: ListTile(
                                leading: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.green.shade100),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.shopping_bag_outlined,
                                    size: 30,
                                    color: Colors.green,
                                  ),
                                ),
                                title: Text(
                                  "0",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                ),
                                subtitle: Text(
                                  "Total Orders",
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),

                            //processing
                            SizedBox(
                              width: 220,
                              child: ListTile(
                                leading: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.orange.shade100),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.recycling,
                                    size: 30,
                                    color: Colors.orange,
                                  ),
                                ),
                                title: Text(
                                  "0",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                ),
                                subtitle: Text(
                                  "Order Processing",
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),

                            //total deliver
                            SizedBox(
                              width: 220,
                              child: ListTile(
                                leading: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.blue.shade100),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.local_shipping_outlined,
                                    size: 30,
                                    color: Colors.blue,
                                  ),
                                ),
                                title: Text(
                                  "0",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                ),
                                subtitle: Text(
                                  "Total Delivered",
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18),
                                ),
                              ),
                            )
                          ],
                        )
                ],
              ),
            ),
      decoration: BoxDecoration(
          color: Colors.white, border: Border.all(color: Colors.grey.shade200)),
    );
  }
}
