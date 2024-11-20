import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CurrUser extends StatelessWidget {
  final String name;

  const CurrUser({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black, width: 0.5)),
      ),
      child: Row(
        children: [
          //icon and name
          Text(
            name,
            style: const TextStyle(color: Colors.black, fontSize: 25.0),
          ),
          const SizedBox(width: 50.0),
          const Icon(FontAwesomeIcons.solidUser,size: 35.0,),
        ],
      ),
    );
  }
}
