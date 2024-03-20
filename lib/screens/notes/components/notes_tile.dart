// ignore_for_file: prefer_const_constructors, unused_import, prefer_const_literals_to_create_immutables, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:course_app/models/course_model.dart';
import 'package:course_app/models/notes_model.dart';
import 'package:course_app/provider/notes_provider.dart';
import 'package:course_app/provider/user_provider.dart';
import 'package:course_app/screens/course/explore_course.dart';
import 'package:course_app/screens/notes/components/confirm_purchase_notes.dart';
import 'package:course_app/screens/notes/components/explore_notes.dart';
import 'package:course_app/screens/views/confirm_purchase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

class NotesTile extends StatefulWidget {
  const NotesTile({super.key, required this.notes, required this.isPurchased});
  final NotesModel notes;
  final bool isPurchased;

  @override
  State<NotesTile> createState() => _CourseTileState();
}

class _CourseTileState extends State<NotesTile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final price = widget.notes.price;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                offset: Offset(1, 0),
                blurRadius: 2,
                color: Colors.grey,
                blurStyle: BlurStyle.solid),
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(widget.notes.title,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(widget.notes.category.name.toString())
                ],
              ),
              SizedBox(width: 5),
              SizedBox(
                height: 75,
                child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: CachedNetworkImage(
                        imageUrl: widget.notes.image.url, height: 100)),
              ),
            ],
          ),
          SizedBox(
            child: Text('Rs. $price /-',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19)),
          ),
          SizedBox(height: 10),
          context.watch<UserProvider>().userNotes.contains(widget.notes)
              ? FilledButton(
                  onPressed: () {
                    Get.to(() => ExploreNotesScreen(
                        isPurchased: true, notes: widget.notes));
                  },
                  child: SizedBox(
                      width: context.width,
                      height: 50,
                      child: Center(child: Text('LET\'S STUDY'))))
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => ExploreNotesScreen(
                            notes: widget.notes,
                            isPurchased: widget.isPurchased));
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
                    InkWell(
                      onTap: () async {
                        String? id;
                        List<NotesModel> userNotes =
                            context.read<UserProvider>().userNotes;
                        for (int i = 0; i < userNotes.length; i++) {
                          if (userNotes[i].title == widget.notes.title) {
                            id = widget.notes.title;
                            break;
                          }
                        }

                        if (id == null) {
                          await Get.to<bool>(() =>
                                  ConfirmNotesPurchase(notes: widget.notes))
                              ?.whenComplete(() => setState(() {}));
                        }
                      },
                      child: Container(
                          height: 50,
                          width: context.screenWidth * 0.35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.deepPurpleAccent),
                          child: Center(
                              child: Text('BUY NOW',
                                  style: TextStyle(color: Colors.white)))),
                    )
                  ],
                )
        ],
      ),
    );
  }
}
