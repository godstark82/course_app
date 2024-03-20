// ignore_for_file: unused_local_variable

import 'package:course_app/models/course_model.dart';
import 'package:course_app/provider/course_provider.dart';
import 'package:course_app/screens/home/components/carousel.dart';
import 'package:course_app/screens/home/components/categoryview.dart';
import 'package:course_app/screens/home/components/courses.dart';
import 'package:course_app/screens/home/components/filters.dart';
import 'package:course_app/screens/home/components/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Course> courses = [];

  void sortCoursesByDecreasedTime() {
    courses.sort((a, b) => b.creationTime.compareTo(a.creationTime));
    setState(() {});
  }

  void sortCoursesByIncreasedTime() {
    courses.sort((a, b) => a.creationTime.compareTo(b.creationTime));
    setState(() {});
  }

  @override
  void initState() {
    courses = context.read<CourseProvider>().courses;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: SearchBarHomeScreen(),
        ),
        const SliverToBoxAdapter(child: HomeScreenCarousel()),
        const SliverToBoxAdapter(child: CategoryViewHomeScreen()),
        SliverToBoxAdapter(
            child: FilterViewHome(
              showHeader: true,
                decreasingFn: sortCoursesByDecreasedTime,
                increasingFn: sortCoursesByIncreasedTime)),
        HomeScreenCourses(
          courses: courses,
        )
      ],
    );
  }
}
