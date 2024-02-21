import 'package:cached_network_image/cached_network_image.dart';
import 'package:course_app/provider/category_provider.dart';
import 'package:course_app/provider/course_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    int getCoursesInCategory(String? categoryName) {
      final courses = context.read<CourseProvider>().courses;
      final count = courses
          .where((element) => element.category.name == categoryName)
          .toList()
          .length;
      return count;
    }

    final categories = context.watch<CategoryProvider>().categories;
    return Scaffold(
      body: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Text(
                      'Total Categories - ${categories.length}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  ListTile(
                    leading: CachedNetworkImage(
                      height: 60,
                      width: 60,
                      imageUrl: categories[0].img.toString(),
                    ),
                    title: Text(categories[index].name.toString()),
                    subtitle: Text(
                        'Courses: ${getCoursesInCategory(categories[index].name)}'),
                  )
                ],
              );
            } else {
              return ListTile(
                leading: CachedNetworkImage(
                    height: 60,
                    width: 60,
                    imageUrl: categories[index].img.toString()),
                title: Text(categories[index].name.toString()),
                subtitle: Text(
                    'Courses: ${getCoursesInCategory(categories[index].name)}'),
              );
            }
          }),
    );
  }
}
