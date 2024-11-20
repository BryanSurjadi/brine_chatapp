import 'package:flutter/material.dart';

class BriTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  const BriTextField(
      {super.key,
      required this.hintText,
      required this.obscureText,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: TextField(
          obscureText: obscureText,
          controller: controller,
          style: TextStyle(
            color: hintText == "Enter a message" ? Colors.black : Colors.white,
          ),
          decoration: InputDecoration(
            // Conditional border based on hintText
            border: hintText == "Enter a message"
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2.0,
                    ),
                  )
                : UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
            enabledBorder: hintText == "Enter a message"
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 1.5,
                    ),
                  )
                : UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
            focusedBorder: hintText == "Enter a message"
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2.0,
                    ),
                  )
                : UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 14.0,
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.w400,
            ),
          ),
        ));
  }
}
