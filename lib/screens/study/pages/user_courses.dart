import 'package:course_app/constants/widgets/course_tile.dart';
import 'package:course_app/provider/user_provider.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class UserCourses extends StatelessWidget {
  const UserCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 150),
          child: Container(
            height: 160,
            decoration: const BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppBar(
                    backgroundColor: Colors.transparent,
                    leading: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          margin: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50)),
                          child: const Center(
                              child: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.deepPurple,
                            size: 18,
                          )),
                        ))),
                const Padding(
                  padding: EdgeInsets.only(left: 16.0, bottom: 16),
                  child: Text(
                    'COURSES',
                    style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.5,
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
        body: context.watch<UserProvider>().userCourses.isEmpty ?
        Center(
          child: EmptyWidget(
            packageImage: PackageImage.Image_1,
            title: 'No Course Found',
            subTitle: '',
          
          ),
        )
         : CustomScrollView(slivers: [
          SliverList.builder(
              itemCount: context.watch<UserProvider>().userCourses.length,
              itemBuilder: (context, index) {
                return CourseTile(
                    course: context.read<UserProvider>().userCourses[index],
                    isPurchased: true);
              })
        ]));
  }
}
