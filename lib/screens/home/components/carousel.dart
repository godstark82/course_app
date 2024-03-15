import 'package:cached_network_image/cached_network_image.dart';
import 'package:course_app/provider/carousel_provider.dart';
import 'package:course_app/screens/course/explore_course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HomeScreenCarousel extends StatelessWidget {
  const HomeScreenCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final carousels = context.read<CarouselProvider>().carousels;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      height: 150,
      child: FlutterCarousel.builder(
        options: CarouselOptions(
            showIndicator: true,
            aspectRatio: 16 / 9,
            floatingIndicator: true,
            enableInfiniteScroll: true),
        itemCount: carousels.length,
        itemBuilder: (context, index, u) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
                onTap: () {
                  Get.to(
                      () => ExploreCourseScreen(course: carousels[index].course, isPurchased: false));
                },
                child: carousels.isEmpty
                    ? const SizedBox()
                    : CachedNetworkImage(imageUrl: carousels[index].image.url)),
          );
        },
      ),
    );
  }
}
