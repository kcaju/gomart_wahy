import 'package:flutter/material.dart';

class TopofferCard extends StatelessWidget {
  const TopofferCard(
      {super.key, required this.offer, required this.url, required this.color});
  final String offer, url;
  final Color color;

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
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: Text(
              offer,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(5)),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Fresh Fruits",
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            "Healthy Juice",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Text(
                "Shop Now",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.arrow_forward,
                color: Colors.black,
              )
            ],
          )
        ],
      ),
      width: screenWidth *
          (isDesktop
              ? 0.3
              : isMobile
                  ? double.infinity
                  : 0.6),
      height: screenHeight * (isMobile ? 0.3 : 0.25),
      decoration: BoxDecoration(
          color: Colors.amber,
          image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(url)),
          borderRadius: BorderRadius.circular(5)),
    );
  }
}
