import 'package:flutter/material.dart';

class BriButton extends StatelessWidget {
  final String text;
  final void Function()? ontap;
  const BriButton({super.key, required this.text, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(6.0)),
        padding: const EdgeInsets.all(18.0),
        margin: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Center(
            child: Text(
          text,
          style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontSize: 24.0,
              fontWeight: FontWeight.w700),
        )),
      ),
    );
  }
}
