import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RecentTile extends StatelessWidget {
  final String name;
  final String text;
  final Timestamp time;
  final void Function()? ontap;

  const RecentTile(
      {super.key,
      required this.name,
      required this.text,
      this.ontap,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
              border: Border(
            top: BorderSide(
                color: Theme.of(context).colorScheme.secondary,
                width: 1.0,
                style: BorderStyle.solid),
          )),
          child: Row(
            children: [
              //user icon , name, last message, timestamp if needed
              const Icon(FontAwesomeIcons.solidUser),
              const SizedBox(width: 15.0),
              Column(
                children: [
                  Text(name),
                  const SizedBox(width: 20.0),
                  Row(children: [Text(text), Text(time.toDate().toString())])
                ],
              )
            ],
          )),
    );
  }
}
