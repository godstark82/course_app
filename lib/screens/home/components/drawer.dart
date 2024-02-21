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
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
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
            const SizedBox(height: 10),
            const Divider(),
            
          ],
        ),
      ),
    );
  }
}
