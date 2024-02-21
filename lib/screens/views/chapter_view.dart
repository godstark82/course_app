// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:banner_listtile/banner_listtile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:course_app/models/course_model.dart';
import 'package:course_app/screens/views/video_play_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChapterView extends StatefulWidget {
  const ChapterView({super.key, required this.chapter});
  final Chapter chapter;

  @override
  State<ChapterView> createState() => _ChapterViewState();
}

class _ChapterViewState extends State<ChapterView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chapter.name),
        bottom:
            TabBar(isScrollable: true, controller: tabController, tabs: const [
          Padding(padding: EdgeInsets.all(8.0), child: Text('Lectures')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('Notes')),
          Padding(padding: EdgeInsets.all(8.0), child: Text('Assignments')),
        ]),
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: [
          // Lectures
          ListView.builder(
            itemCount: widget.chapter.lectures?.length,
            itemBuilder: (context, index) {
              return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: BannerListTile(
                    onTap: () {
                      Get.to(() => VideoPlayerView(
                          chapter: widget.chapter, index: index));
                    },
                    showBanner: false,
                    backgroundColor: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    imageContainer: CachedNetworkImage(
                        imageUrl: widget.chapter.lectures![index].thumbnail),
                    title: Text(
                      widget.chapter.lectures![index].name,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 17,
                      ),
                    ),
                  ));
            },
          ),
          Text('Notes'),
          Text('Assignments')
        ],
      ),
    );
  }
}
