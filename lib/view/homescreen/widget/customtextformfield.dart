import 'package:flutter/material.dart';

class Customtextformfield extends StatelessWidget {
  const Customtextformfield(
      {super.key, required this.hintText, this.isPassword = false});
  final String hintText;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey.shade200)),
      child: TextFormField(
        decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: isPassword
                ? Icon(
                    Icons.visibility,
                    size: 20,
                  )
                : null,
            hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 16),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none)),
      ),
    );
  }
}
