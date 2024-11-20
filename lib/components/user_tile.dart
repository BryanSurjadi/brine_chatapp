import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function()? ontap;

  const UserTile({super.key, required this.text, this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
            width: 1.0,
            style: BorderStyle.solid,
          )),
        ),
        child: Row(
          children: [
            //icon and name
            const Icon(FontAwesomeIcons.solidUser),
            const SizedBox(width: 15.0),
            Text(
              text,
              style: const TextStyle(
                  color: Colors.black,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
