// ignore_for_file: prefer_const_constructors, unused_import, prefer_const_literals_to_create_immutables

import 'package:course_app/models/course_model.dart';
import 'package:course_app/screens/course/explore_course.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class CourseTile extends StatelessWidget {
  const CourseTile({super.key, required this.course});
  final Course course;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Card(
        child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(course.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(course.img.url,
                      width: context.screenWidth)),
              Divider(),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                          'Rs. ${course.price - (course.price * course.discount)} /-'),
                      SizedBox(width: 10),
                      Text(
                        '${course.price}',
                        style:
                            TextStyle(decoration: TextDecoration.lineThrough),
                      )
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text('Discount of ${course.discount}% Applied')),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(() => ExploreCourseScreen(course: course));
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
                  Container(
                      height: 50,
                      width: context.screenWidth * 0.35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.deepPurpleAccent),
                      child: Center(
                          child: Text('BUY NOW',
                              style: TextStyle(color: Colors.white))))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
