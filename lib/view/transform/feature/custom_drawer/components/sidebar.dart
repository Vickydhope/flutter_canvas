import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'info_card.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 288,
        height: double.infinity,
        color: Colors.blueGrey.shade900,
        child: const SafeArea(
          child: Column(
            children: [
              InfoCard(name: "Robert Downey Jr.", profession: "Ironman"),
              Divider(color: Colors.white,thickness: 0.1),
              SideMenuTile(title: "Home", icon: CupertinoIcons.home),
              SideMenuTile(title: "Account", icon: CupertinoIcons.person_2),
              SideMenuTile(title: "Gallery", icon: CupertinoIcons.photo),
              SideMenuTile(
                  title: "Notifications", icon: CupertinoIcons.bell_solid),
              SideMenuTile(title: "About", icon: CupertinoIcons.info),
            ],
          ),
        ),
      ),
    );
  }
}

class SideMenuTile extends StatelessWidget {
  const SideMenuTile({
    super.key,
    required this.title,
    required this.icon,
  });

  final String title;

  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
