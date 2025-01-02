import 'package:flutter/material.dart';

class CustomFloatingbutton extends StatefulWidget {
  const CustomFloatingbutton({super.key});

  @override
  State<CustomFloatingbutton> createState() => _CustomFloatingbuttonState();
}

class _CustomFloatingbuttonState extends State<CustomFloatingbutton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: Colors.orange,
      child: Icon(
        Icons.pan_tool_alt_outlined,
        color: Colors.white,
      ),
    );
  }
}
