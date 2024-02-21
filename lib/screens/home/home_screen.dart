// ignore_for_file: unused_local_variable

import 'package:course_app/screens/home/components/carousel.dart';
import 'package:course_app/screens/home/components/courses.dart';
import 'package:course_app/screens/home/components/search_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SearchBarHomeScreen(),
        ),
        SliverToBoxAdapter(
          child: HomeScreenCarousel(),
        ),
        HomeScreenCourses()
      ],
    );
  }
}
