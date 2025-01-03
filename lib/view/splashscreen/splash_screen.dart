import 'package:flutter/material.dart';
import 'package:gomart_wahy/view/homescreen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 4)).then(
      (value) {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return HomeScreen();
          },
        ));
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Determine screen type based on width
    bool isMobile = screenWidth < 600;
    bool isTablet = screenWidth >= 600 && screenWidth < 1024;
    bool isDesktop = screenWidth >= 1024;
    return Scaffold(
      body: isMobile
          ? Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/png/mobilesplash.jpg"))),
              child: Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Go",
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 80,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "mart",
                                style: TextStyle(
                                    color: Color(0xFF03AC13),
                                    fontSize: 80,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            "Your Ultimate Destination for Fresh Groceries, Spices, and More!",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/png/shop.jpg"))),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(right: 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Go",
                            style: TextStyle(
                                color: Colors.orange,
                                fontSize: 100,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "mart",
                            style: TextStyle(
                                color: Color(0xFF03AC13),
                                fontSize: 100,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      isDesktop
                          ? Text(
                              "Your Ultimate Destination for Fresh Groceries, Spices, and More!",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Your Ultimate Destination for",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Fresh Groceries, Spices, and More!",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
