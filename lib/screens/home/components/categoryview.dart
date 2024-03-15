import 'package:cached_network_image/cached_network_image.dart';
import 'package:course_app/provider/category_provider.dart';
import 'package:course_app/screens/category/category_screen.dart';
import 'package:course_app/screens/category/components/courses_in_category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CategoryViewHomeScreen extends StatelessWidget {
  const CategoryViewHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Category',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextButton(
                  onPressed: () {
                    Get.to(() => CategoryScreen());
                  },
                  child: Text('See more'))
            ],
          ),
        ),
        SizedBox(
            height: 150,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: context.read<CategoryProvider>().categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                          onTap: () {
                            Get.to(() => CategoryCourses(
                                cateogry: context
                                    .read<CategoryProvider>()
                                    .categories[index]));
                          },
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.yellow.shade700,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image(
                                      image: CachedNetworkImageProvider(
                                    context
                                        .read<CategoryProvider>()
                                        .categories[index]
                                        .img
                                        .toString(),
                                  )),
                                )),
                            Text(
                              context
                                  .read<CategoryProvider>()
                                  .categories[index]
                                  .name
                                  .toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )
                          ])));
                }))
      ],
    );
  }
}
