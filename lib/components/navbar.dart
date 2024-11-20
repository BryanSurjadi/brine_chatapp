import 'package:brine_chatapp/components/appbar.dart';
import 'package:brine_chatapp/pages/chats.dart';
import 'package:brine_chatapp/pages/home.dart';
import 'package:brine_chatapp/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 70.0,
          elevation: 1000.0,
          backgroundColor: Theme.of(context).colorScheme.primary,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (value) =>
              controller.selectedIndex.value = value,
          destinations: const [
            NavigationDestination(
              icon: Icon(
                Icons.home_outlined,
                size: 34.0,
              ),
              label: "H o m e",
              selectedIcon: Icon(
                Icons.home,
                size: 34.0,
              ),
            ),
            NavigationDestination(
              icon: Icon(FontAwesomeIcons.comments),
              label: "C h a t s",
              selectedIcon: Icon(FontAwesomeIcons.solidComments),
            ),
            NavigationDestination(
              icon: Icon(FontAwesomeIcons.user),
              label: "P r o f i l e",
              selectedIcon: Icon(FontAwesomeIcons.solidUser),
            ),
          ],
        ),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: Obx(() => controller.headers[controller.selectedIndex.value]),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }

  // prefferredSize(Size size, Obx obx) {}
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 1.obs;
  final headers = [
    const BriAppBar(page: "Contacts"),
    const BriAppBar(page: "Chats"),
    const BriAppBar(page: "Profile")
  ];
  final screens = [HomePage(), ChatPage(), const ProfilePage()];
}
