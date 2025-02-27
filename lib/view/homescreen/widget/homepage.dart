import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Determine screen type based on width
    bool isMobile = screenWidth < 600;
    bool isTablet = screenWidth >= 600 && screenWidth <= 1024;
    bool isDesktop = screenWidth > 1024;
    return Scaffold(
      backgroundColor: Color(0xFF2A2A2A),
      appBar: AppBar(
        leading: Icon(null),
        backgroundColor: Color(0xFF2A2A2A),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Go",
              style: TextStyle(
                  color: Colors.orange,
                  fontSize: 50,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "mart",
              style: TextStyle(
                  color: Color(0xFF03AC13),
                  fontSize: 50,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 15 : 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isMobile
                  ? Column(
                      children: [
                        Text(
                          "COMING",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 45,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "SOON",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 45,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  : Text(
                      "COMING SOON",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontWeight: FontWeight.bold),
                    ),
              SizedBox(
                height: 15,
              ),
              Text(
                textAlign: TextAlign.center,
                "Our website is under construction, follow us for update now!",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "LetterKenny,Co.Donegal,Ireland",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "+353 (74) 920 2265",
                style: TextStyle(color: Color(0xFF03AC13), fontSize: 16),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "info@gomart.ie",
                style: TextStyle(color: Color(0xFF03AC13), fontSize: 15),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Image.asset(
                      "assets/png/fb_logo.png",
                      height: 30,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey.shade200)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: Image.asset(
                      "assets/png/instagram.png",
                      height: 30,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey.shade200)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: Image.asset(
                      "assets/png/tiktok.png",
                      height: 30,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey.shade200)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: Image.asset(
                      "assets/png/twitter.png",
                      height: 30,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey.shade200)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: Image.asset(
                      "assets/png/youtube.png",
                      height: 30,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey.shade200)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
