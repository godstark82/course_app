import 'package:course_app/constants/utils/utils.dart';
import 'package:course_app/screens/category/category_screen.dart';
import 'package:course_app/screens/home/home.dart';
import 'package:course_app/screens/study/study_screen.dart';
import 'package:course_app/screens/views/about_us.dart';
import 'package:course_app/screens/views/contact_us.dart';
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
      backgroundColor: Colors.white,
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
          DrawerTile(
              iconData: AssetImage(AssetImages.STUDY),
              onTap: () {
                GlobalKeys.homeScaffoldKey.currentState?.closeDrawer();
                Get.to(() => StudyScreen());
              },
              title: 'Study Section'),
          DrawerTile(
              iconData: AssetImage(AssetImages.COURSE),
              onTap: () {
                GlobalKeys.homeScaffoldKey.currentState?.closeDrawer();
                selectedIndex.value = 0;
              },
              title: 'All Courses'),
          DrawerTile(
              iconData: AssetImage(AssetImages.CATEGORY),
              onTap: () {
                GlobalKeys.homeScaffoldKey.currentState?.closeDrawer();
                Get.to(() => CategoryScreen());
              },
              title: 'Categories'),
          DrawerTile(
              iconData: AssetImage(AssetImages.QUIZ_1),
              onTap: () {
                GlobalKeys.homeScaffoldKey.currentState?.closeDrawer();
                selectedIndex.value = 3;
              },
              title: 'Quizes'),
          DrawerTile(
              iconData: AssetImage(AssetImages.ABOUT),
              onTap: () {
                GlobalKeys.homeScaffoldKey.currentState?.closeDrawer();
                Get.to(() => AboutusScreen());
              },
              title: 'About Notepediax'),
          DrawerTile(
              iconData: AssetImage(AssetImages.ABOUT),
              onTap: () {
                GlobalKeys.homeScaffoldKey.currentState?.closeDrawer();
                Get.to(() => ContactusScreen());
              },
              title: 'Contact us'),
        ],
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  const DrawerTile(
      {super.key,
      required this.iconData,
      required this.onTap,
      required this.title});
  final ImageProvider iconData;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          children: [
            SizedBox(width: 2),
            Image(image: iconData, height: 24, width: 24),
            SizedBox(width: 10),
            Text(title, style: TextStyle(fontSize: 15)),
          ],
        ),
      ),
    );
  }
}
