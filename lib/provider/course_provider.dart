// ignore_for_file: prefer_final_fields

import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_app/constants/db.dart';
import 'package:course_app/models/course_model.dart';
import 'package:flutter/material.dart';

final admin = FirebaseFirestore.instance.collection('admin');

class CourseProvider extends ChangeNotifier {
  // variable for _courses in CourseModel
  List<Course> _courses = db.value['courses'] != null
      ? (db.value['courses'] ?? [])
          .map((course) => Course.fromJson(course))
          .toList()
      : [];

  List<Course> get courses => _courses.toSet().toList();

  Future<List<Course>> fetchCourses() async {
    _courses.clear();
    final query = await FirebaseFirestore.instance.collection('courses').get();
    final docs = query.docs;
    for (int i = 0; i < docs.length; i++) {
      final jsonString = docs[i].data();

      Course course = Course.fromJson(jsonString);
      _courses.add(course);
    }
    final fetchedCourses = LinkedHashSet<Course>.from(_courses).toList();
    fetchedCourses.sort((a, b) => a.creationTime.compareTo(b.creationTime));
    notifyListeners();

    return fetchedCourses;
  }
}
