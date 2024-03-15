// ignore_for_file: prefer_final_fields, use_build_context_synchronously

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_app/constants/db.dart';
import 'package:course_app/models/course_model.dart';
import 'package:course_app/provider/course_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProvider extends ChangeNotifier {
  List<Course> _userCourses = db.value['user-courses'] != null
      ? (db.value['user-courses'] as List)
          .map((course) => Course.fromJson(course))
          .toSet()
          .toList()
      : [];

  List<Course> get userCourses => _userCourses;

  // func for adding a course in this list
  Future<void> buyCourse(Course course) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('courses')
        .add({'id': course.id});
    _userCourses.add(course);
  }

  Future<bool> fetchUserCourses(BuildContext context) async {
    _userCourses.clear();
    final query = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('courses')
        .get();
    await context.read<CourseProvider>().fetchCourses();
    final docs = query.docs;
    for (int i = 0; i < docs.length; i++) {
      final jsonString = docs[i].data();

      // Course course = Course.fromId(jsonString['id']);
      // _userCourses.add(course);
      _userCourses.add(context
          .read<CourseProvider>()
          .courses
          .firstWhere((element) => element.id == jsonString['id']));
    }

    _userCourses.toSet().toList();
    _userCourses.sort((a, b) => a.creationTime.compareTo(b.creationTime));
    log('User Courses Fetched: ${_userCourses.length}');
    log('Local: ${_userCourses.length}');
    notifyListeners();
    return true;
  }
}
