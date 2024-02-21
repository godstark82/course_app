import 'package:cached_network_image/cached_network_image.dart';
import 'package:course_app/models/course_model.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class TeacherCard extends StatelessWidget {
  const TeacherCard({super.key, required this.course, required this.index});
  final Course course;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth * 0.35,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 100,
            child: CachedNetworkImage(imageUrl: course.teachers[index].img),
          ),
          Text(course.teachers[index].name)
              .text
              .lg
              .bold
              .emerald900
              .make(),
          Text('Subject: ${course.teachers[index].subject}')
              .text
              .blue700
              .make(),
          Text('Exp: ${course.teachers[index].experience} Years')
        ],
      ),
    );
  }
}
