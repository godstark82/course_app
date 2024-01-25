import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Drawer(
      child: Column(
        children: [
          Expanded(
            child: DrawerHeader(
                child: Row(
              
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [Icon(FontAwesomeIcons.user), Text('User Name')],
            )),
          ),
          Expanded(flex: 8, child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                style: ListTileStyle.drawer,
                leading: Icon(FontAwesomeIcons.bookOpenReader),
                title: Text('My Courses'),
              ),
              ListTile(
                style: ListTileStyle.drawer,
                leading: Icon(FontAwesomeIcons.download),
                title: Text('Downloads'),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
