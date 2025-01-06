import 'package:flutter/material.dart';
import 'package:gomart_wahy/view/homescreen/widget/customtextformfield.dart';

class AlertboxFields extends StatefulWidget {
  const AlertboxFields({super.key});

  @override
  State<AlertboxFields> createState() => _AlertboxFieldsState();
}

class _AlertboxFieldsState extends State<AlertboxFields> {
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController eirCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Determine screen type based on width
    bool isMobile = screenWidth < 600;
    bool isTablet = screenWidth >= 600 && screenWidth <= 1024;
    bool isDesktop = screenWidth > 1024;
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      content: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Edit Shipment Address",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            SizedBox(
              width: screenWidth * 0.7,
              child: Customtextformfield(
                  hintText: "First Name", controller: fname),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: screenWidth * 0.7,
              child:
                  Customtextformfield(hintText: "Last Name", controller: lname),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: screenWidth * 0.7,
              child: Customtextformfield(hintText: "Email", controller: email),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: screenWidth * 0.7,
              child:
                  Customtextformfield(hintText: "Mobile", controller: mobile),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: screenWidth * 0.7,
              child: Customtextformfield(hintText: "State", controller: state),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: screenWidth * 0.7,
              child: Customtextformfield(
                  hintText: "Street Address", controller: address),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: screenWidth * 0.7,
              child:
                  Customtextformfield(hintText: "EirCode", controller: eirCode),
            ),
            SizedBox(
              height: 10,
            ), //close and save button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Close",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  height: 45,
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: Text(
                    "Save Changes",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(5),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
