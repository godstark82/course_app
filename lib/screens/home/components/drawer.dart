import 'package:course_app/constants/utils/utils.dart';
import 'package:course_app/screens/home/home.dart';
import 'package:course_app/screens/study/study_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    String getUserName() {
      if (FirebaseAuth.instance.currentUser!.displayName == null) {
        return '';
      } else {
        return ', ${FirebaseAuth.instance.currentUser!.displayName}';
      }
    }

    return Drawer(
      shape: const BeveledRectangleBorder(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                const CircleAvatar(child: FlutterLogo()),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (getUserName() != '')
                      Text('Hi${getUserName()}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    if (getUserName() == '')
                      const Text('Welcome User',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    TextButton(
                        style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                        onPressed: () {
                          Get.toNamed('/profile');
                        },
                        child: const Text('View Profile'))
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Divider(thickness: 3),
          ListTile(
            style: ListTileStyle.drawer,
            onTap: () {
              if (GlobalKeys.homeScaffoldKey.currentState?.isDrawerOpen ==
                  true) {
                GlobalKeys.homeScaffoldKey.currentState?.closeDrawer();
              }
              Get.to(() => const StudyScreen());
            },
            title: const Text(
              'Study Section',
              style: TextStyle(fontSize: 16),
            ),
            leading: const Icon(Icons.book),
          ),
          const Divider(),
          ListTile(
            title: const Text('Category'),
            onTap: () {
              selectedIndex.value = 1;
              GlobalKeys.homeScaffoldKey.currentState?.closeDrawer();
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Quizes'),
            onTap: () {
              selectedIndex.value = 2;
              GlobalKeys.homeScaffoldKey.currentState?.closeDrawer();
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Profile'),
            onTap: () {
              GlobalKeys.homeScaffoldKey.currentState?.closeDrawer();
              Get.toNamed('/profile');
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
