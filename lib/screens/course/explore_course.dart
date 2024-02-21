import 'package:cached_network_image/cached_network_image.dart';
import 'package:course_app/models/course_model.dart';
import 'package:course_app/screens/course/components/teacher_card.dart';
import 'package:course_app/screens/course/components/view_chapters.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ExploreCourseScreen extends StatefulWidget {
  const ExploreCourseScreen({super.key, required this.course});
  final Course course;

  @override
  State<ExploreCourseScreen> createState() => _ExploreCourseScreenState();
}

class _ExploreCourseScreenState extends State<ExploreCourseScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 35,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(widget.course.title),
        bottom: TabBar(
          isScrollable: true,
          tabs: const [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              child: Text(
                'Description',
                style: TextStyle(
                    color: Colors.deepPurpleAccent,
                    fontWeight: FontWeight.w800),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'All Classes',
                style: TextStyle(
                    color: Colors.deepPurpleAccent,
                    fontWeight: FontWeight.w800),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Announcements',
                style: TextStyle(
                    color: Colors.deepPurpleAccent,
                    fontWeight: FontWeight.w800),
              ),
            )
          ],
          controller: tabController,
        ),
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: [
          DescriptionView(course: widget.course),
          AllClassesView(course: widget.course),
          AnnouncementsView(course: widget.course)
        ],
      ),
    );
  }
}

class DescriptionView extends StatelessWidget {
  const DescriptionView({super.key, required this.course});
  final Course course;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  course.img.url,
                ),
              ),
              const Divider(),
              const SizedBox(height: 20),
              const Text('Description',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
              const SizedBox(height: 10),
              Text(course.description),
              const Divider(),
              const SizedBox(height: 20),
              const Text('Know Your Teachers',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
              const SizedBox(height: 10)
            ],
          )),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 275,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: course.teachers.length,
                  itemBuilder: (context, index) {
                    return TeacherCard(course: course, index: index);
                  }),
            ),
          )
        ],
      ),
    );
  }
}

class AllClassesView extends StatelessWidget {
  const AllClassesView({super.key, required this.course});
  final Course course;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.count(
          crossAxisCount: 3,
          children: course.subjects
              .map((subject) => InkWell(
                    onTap: () {
                      Get.to(() => ViewChaptersList(subject: subject));
                      debugPrint(subject.img.toString());
                    },
                    child: Column(
                      children: [
                        if (subject.img.isEmptyOrNull)
                          CircleAvatar(
                            radius: 50,
                            child: CachedNetworkImage(
                                imageUrl: subject.img ??
                                    'https://www.pngitem.com/pimgs/b/201-2014927_research-icon-png.png'),
                          ),
                        Text(subject.name),
                      ],
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class AnnouncementsView extends StatelessWidget {
  const AnnouncementsView({super.key, required this.course});
  final Course course;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (course.announcements ?? []).isEmpty
          ? "No Announcements Yet".text.lg.bold.makeCentered()
          : ListView.builder(
              itemCount: course.announcements?.length,
              itemBuilder: (context, index) {
                return const Text('course');
              }),
    );
  }
}
