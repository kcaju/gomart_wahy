import 'package:flutter/material.dart';

class ShopAndAboutButton extends StatelessWidget {
  const ShopAndAboutButton(
      {super.key,
      required this.text,
      required this.buttonColor,
      this.isWidth = false});
  final String text;
  final Color buttonColor;
  final bool isWidth;

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
      height: screenHeight *
          (isDesktop
              ? 0.065
              : isTablet
                  ? 0.05
                  : 0.06),
      width: isWidth
          ? screenWidth *
              (isMobile
                  ? 0.3
                  : isDesktop
                      ? 0.12
                      : 0.2)
          : screenWidth *
              (isDesktop
                  ? 0.15
                  : isMobile
                      ? 0.4
                      : 0.2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
                fontSize: isWidth ? 15 : 16,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.arrow_forward,
            color: Colors.white,
          )
        ],
      ),
      decoration: BoxDecoration(
          color: buttonColor, borderRadius: BorderRadius.circular(5)),
    );
  }
}
