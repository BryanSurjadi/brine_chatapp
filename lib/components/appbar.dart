import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BriAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String page;

  const BriAppBar({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 70.0,
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: Text(
        page,
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.w700, fontSize: 30.0),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70.0);
}
