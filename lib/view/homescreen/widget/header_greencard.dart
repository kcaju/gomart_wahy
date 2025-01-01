import 'package:flutter/material.dart';

class HeaderGreencard extends StatelessWidget {
  const HeaderGreencard({super.key});

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Determine screen type based on width
    bool isMobile = screenWidth < 600;
    bool isTablet = screenWidth >= 600 && screenWidth < 1024;
    bool isDesktop = screenWidth >= 1024;
    return Container(
      width: screenWidth,
      child: Row(
        mainAxisAlignment:
            isMobile ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.email_outlined,
            size: isDesktop ? 20 : (isTablet ? 20 : (isMobile ? 14 : 10)),
            color: Colors.white,
          ),
          SizedBox(
            width: screenWidth * 0.01,
          ),
          Text(
            "info@gomart.ie",
            style: TextStyle(
                color: Colors.white,
                fontSize:
                    isDesktop ? 18 : (isTablet ? 20 : (isMobile ? 12 : 10))),
          ),
          SizedBox(
            width: screenWidth * 0.01,
          ),
          SizedBox(
            height: screenHeight * 0.03,
            child: VerticalDivider(
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: screenWidth * 0.01,
          ),
          Icon(
            Icons.pin_drop_outlined,
            size: isDesktop ? 20 : (isTablet ? 20 : (isMobile ? 14 : 10)),
            color: Colors.white,
          ),
          SizedBox(
            width: screenWidth * 0.01,
          ),
          Text(
            "LetterKenny,Co.Donegal,Ireland",
            style: TextStyle(
                color: Colors.white,
                fontSize:
                    isDesktop ? 18 : (isTablet ? 20 : (isMobile ? 12 : 10))),
          ),
          SizedBox(
            width: screenWidth * 0.01,
          ),
          SizedBox(
            height: screenHeight * 0.03,
            child: VerticalDivider(
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: screenWidth * 0.01,
          ),
          Text(
            "English",
            style: TextStyle(
                color: Colors.white,
                fontSize:
                    isDesktop ? 18 : (isTablet ? 20 : (isMobile ? 12 : 10))),
          ),
          SizedBox(
            width: screenWidth * 0.01,
          ),
          SizedBox(
            height: screenHeight * 0.03,
            child: VerticalDivider(
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: screenWidth * 0.01,
          ),
          Text(
            "Dark",
            style: TextStyle(
                color: Colors.white,
                fontSize:
                    isDesktop ? 18 : (isTablet ? 20 : (isMobile ? 12 : 10))),
          ),
          SizedBox(
            width: screenWidth * 0.01,
          ),
          Icon(
            Icons.dark_mode,
            color: Colors.white,
            size: isDesktop ? 20 : (isTablet ? 20 : (isMobile ? 14 : 10)),
          ),
          SizedBox(
            width: screenWidth * 0.05,
          ),
        ],
      ),
      color: Color(0xFF03AC13),
      height: screenHeight * 0.10,
    );
  }
}
