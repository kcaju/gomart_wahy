import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class TrendingproductsCard extends StatelessWidget {
  const TrendingproductsCard(
      {super.key,
      required this.url,
      required this.title,
      required this.name,
      required this.oldRate,
      required this.newRate,
      required this.count,
      this.isProducts = false,
      this.addToCartTap});
  final String url, title, name, oldRate, newRate, count;
  final bool isProducts;
  final void Function()? addToCartTap;

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Determine screen type based on width
    bool isMobile = screenWidth < 600;
    bool isTablet = screenWidth >= 600 && screenWidth <= 1024;
    bool isDesktop = screenWidth > 1024;
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                child: Image.network(height: 200, url),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                title,
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                name,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                oldRate,
                style: TextStyle(
                    color: Colors.grey.shade600,
                    decorationColor: Colors.black,
                    decoration: TextDecoration.lineThrough,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                newRate,
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              //progress indicator

              LinearPercentIndicator(
                lineHeight: 8.0,
                percent: 0.5,
                backgroundColor: Colors.grey.shade300,
                progressColor: Color(0xFF03AC13),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Available:",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "$count/10",
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: addToCartTap,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  height: 45,
                  alignment: Alignment.center,
                  child: Text(
                    "Add to Cart",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(5)),
                ),
              )
            ],
          ),
          width: isDesktop
              ? 250
              : isMobile
                  ? 350
                  : 300,
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade300,
              ),
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)),
        ),
        isProducts
            ? SizedBox()
            : Container(
                padding: EdgeInsets.all(8),
                child: Text(
                  "-12% OFF",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                  ),
                  color: Colors.red,
                ),
              ),
        Positioned(
          right: isProducts ? 120 : 8,
          top: 8,
          child: CircleAvatar(
            radius: 15,
            backgroundColor: Colors.green,
            child: Icon(
              Icons.favorite_outline,
              size: 20,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
