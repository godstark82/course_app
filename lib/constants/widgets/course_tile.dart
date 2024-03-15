// ignore_for_file: prefer_const_constructors, unused_import, prefer_const_literals_to_create_immutables, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:course_app/models/course_model.dart';
import 'package:course_app/provider/user_provider.dart';
import 'package:course_app/screens/course/explore_course.dart';
import 'package:course_app/screens/views/confirm_purchase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

class CourseTile extends StatefulWidget {
  const CourseTile(
      {super.key, required this.course, required this.isPurchased});
  final Course course;
  final bool isPurchased;

  @override
  State<CourseTile> createState() => _CourseTileState();
}

class _CourseTileState extends State<CourseTile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final price = widget.course.price;
    final oldPrice = widget.course.price +
        ((widget.course.price * widget.course.discount) / 100);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(offset: Offset(1, 0), blurRadius: 2,color: Colors.grey,blurStyle: BlurStyle.inner),
            BoxShadow(offset: Offset(-1, 0), blurRadius: 2,color: Colors.grey,blurStyle: BlurStyle.inner),
            // BoxShadow(offset: Offset.zero, blurRadius: 4,color: Colors.grey),
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.course.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          AspectRatio(
              aspectRatio: 16 / 9,
              child: CachedNetworkImage(
                  imageUrl: widget.course.img.url, width: context.width)),
          Divider(),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    '$oldPrice',
                    style: TextStyle(decoration: TextDecoration.lineThrough),
                  ),
                  SizedBox(width: 10),
                  Text('Rs. $price /-',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 19)),
                ],
              ),
              Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10)),
                  child:
                      Text('Discount of ${widget.course.discount}% Applied')),
            ],
          ),
          SizedBox(height: 20),
          context.read<UserProvider>().userCourses.contains(widget.course)
              ? FilledButton(
                  onPressed: () {
                    Get.to(() => ExploreCourseScreen(
                        tabIndex: 1, course: widget.course, isPurchased: true));
                  },
                  child: SizedBox(
                      width: context.width,
                      height: 50,
                      child: Center(child: Text('LET\'S STUDY'))))
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => ExploreCourseScreen(
                            course: widget.course,
                            isPurchased: widget.isPurchased));
                      },
                      child: Container(
                          height: 50,
                          width: context.screenWidth * 0.35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.deepPurpleAccent.withOpacity(0.2)),
                          child: Center(
                              child: Text('EXPLORE',
                                  style: TextStyle(color: Colors.deepPurple)))),
                    ),
                    InkWell(
                      onTap: () {
                        int? id;
                        List<Course> userCourse =
                            context.read<UserProvider>().userCourses;
                        for (int i = 0; i < userCourse.length; i++) {
                          if (userCourse[i].id == widget.course.id) {
                            id = widget.course.id;
                            break;
                          }
                        }

                        if (id == null) {
                          Get.to(
                              () => ConfirmPurchasePage(course: widget.course));
                        } else {
                          Get.to(() => AlreadyPurchasedPage());
                        }
                      },
                      child: Container(
                          height: 50,
                          width: context.screenWidth * 0.35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.deepPurpleAccent),
                          child: Center(
                              child: Text('BUY NOW',
                                  style: TextStyle(color: Colors.white)))),
                    )
                  ],
                )
        ],
      ),
    );
  }
}
