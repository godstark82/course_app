// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:course_app/constants/widgets/carousel_tile.dart';
import 'package:course_app/constants/widgets/skeleton_widget.dart';
import 'package:course_app/provider/carousel_provider.dart';
import 'package:course_app/provider/category_provider.dart';
import 'package:course_app/provider/course_provider.dart';
import 'package:course_app/screens/home/components/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: context.read<CarouselProvider>().fetchCarousel(),
        builder: (context, carouselSnapshot) {
          return FutureBuilder(
              future: context.read<CourseProvider>().fetchCourses(),
              builder: (context, courseSnapshot) {
                return FutureBuilder(
                    future: context.read<CategoryProvider>().fetchCategories(),
                    builder: (context, categorySnapshot) {
                      if (carouselSnapshot.connectionState ==
                              ConnectionState.waiting ||
                          courseSnapshot.connectionState ==
                              ConnectionState.waiting ||
                          categorySnapshot.connectionState ==
                              ConnectionState.waiting) {
                        return const SkeletonWidget();
                      } else {
                        final carousels =
                            context.read<CarouselProvider>().carousels;
                        final courses = context.read<CourseProvider>().courses;
                        final categories =
                            context.read<CategoryProvider>().categories;
                        return SingleChildScrollView(
                            child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SearchBarHomeScreen(),
                            SizedBox(
                              height: 200,
                              width: context.screenWidth,
                              child: InfiniteCarousel.builder(
                                  axisDirection: Axis.horizontal,
                                  center: true,
                                  itemCount: carousels.length,
                                  itemExtent: context.screenWidth,
                                  itemBuilder: (context, index, i) {
                                    return CarouselTile(
                                      carousel: carousels[index],
                                    );
                                  }),
                            ),
                          ],
                        ));
                      }
                    });
              });
        });
  }
}
