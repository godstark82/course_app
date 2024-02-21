// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:course_app/models/category_model.dart';
import 'package:course_app/models/gallery_model.dart';
import 'package:course_app/provider/course_provider.dart';

class Course {
  int id;
  String title;
  GalleryImage img;
  Category category;
  String description;
  DateTime creationTime;
  double price;
  double discount;
  List<Subject> subjects;
  List<FAQModel> faq;
  List<Teacher> teachers;
  List<AnnounmentsModel>? announcements;

  // constructor for course model
  Course(
      {required this.id,
      required this.title,
      required this.img,
      required this.faq,
      required this.category,
      required this.subjects,
      required this.creationTime,
      required this.description,
      required this.teachers,
      required this.price,
      required this.discount,
      this.announcements});
  // function to Course Model this from json
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
        id: json['id'],
        title: json['title'],
        img: GalleryImage.fromJson(json['img']),
        price: double.parse((json['price']).toString()),
        faq: json['faq'] != null
            ? (json['faq'] as List)
                .map((item) => FAQModel.fromJson(item))
                .toList()
            : [],
        discount: double.parse(json['discount'].toString()),
        category: Category.fromJson(json['category']),
        subjects: json['subjects'] != null
            ? (json['subjects'] as List)
                .map((i) => Subject.fromJson(i))
                .toList()
            : [],
        creationTime: DateTime.parse(json['creationTime']),
        description: json['description'],
        teachers: (json['teachers'] as List)
            .map((teacher) => Teacher.fromJson(teacher))
            .toList(),
        announcements: json['announcements'] != null
            ? (json['announcements'] as List)
                .map((e) => AnnounmentsModel.fromJson(e))
                .toList()
            : []);
  }
// function to convert Course Model to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'img': img.toJson(),
      'price': price,
      'faq': faq.map((item) => item.toJson()),
      'discount': discount,
      'category': category.toJson(),
      'subjects': subjects.map((subject) => subject.toJson()).toList(),
      'description': description,
      'creationTime': creationTime.toIso8601String(),
      'teachers': teachers.map((teacher) => teacher.toJson()).toList(),
      'announcements':
          announcements?.map((announcement) => announcement.toJson()).toList()
    };
  }

  factory Course.fromId(int id, BuildContext context) {
    return context
        .read<CourseProvider>()
        .courses
        .firstWhere((element) => element.id == id);
  }
}

class Teacher {
  String name;
  String img;
  String desc;
  String subject;
  String? experience;
  Teacher({
    required this.name,
    required this.img,
    required this.desc,
    required this.subject,
    required this.experience,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
        name: json['name'],
        img: json['img'],
        desc: json['desc'],
        subject: json['subject'],
        experience: '${json['experience'] ?? 'N/A'}');
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'img': img,
      'desc': desc,
      'subject': subject,
      'experience': experience
    };
  }

  @override
  String toString() {
    return 'Teacher(name: $name, img: $img, desc: $desc, subject: $subject, experience: $experience)';
  }
}

// model for subjects including with chapters in it

class Subject {
  //
  String name;
  List<Chapter>? chapters;
  String? img;
  Subject({
    required this.name,
    required this.chapters,
    required this.img,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      name: json['name'],
      img: json['img'],
      chapters: json['chapters'] == null
          ? []
          : (json['chapters'] as List).map((i) => Chapter.fromJson(i)).toList(),
    );
  }

  toJson() {
    return {
      'name': name,
      'img': img,
      'chapters': chapters?.map((chapter) => chapter.toJson()).toList(),
    };
  }
}

// model for chapters including with a list of lectures

class Chapter {
  //
  String name;
  List<LectureVideo>? lectures;
  List<PDF>? notes;
  List<PDF>? assignments;

  Chapter(
      {required this.assignments,
      required this.lectures,
      required this.name,
      required this.notes});

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      assignments: json['assignments'] == null
          ? []
          : (json['assignments'] as List).map((i) => PDF.fromJson(i)).toList(),
      lectures: json['lectures'] == null
          ? []
          : (json['lectures'] as List)
              .map((i) => LectureVideo.fromJson(i))
              .toList(),
      name: json['name'],
      notes: json['notes'] == null
          ? []
          : (json['notes'] as List).map((i) => PDF.fromJson(i)).toList(),
    );
  }

  toJson() {
    return {
      'name': name,
      'lectures': lectures?.map((lecture) => lecture.toJson()).toList(),
      'notes': notes?.map((note) => note.toJson()).toList(),
      'assignments':
          assignments?.map((assignment) => assignment.toJson()).toList(),
    };
  }
}

// class for a pdf
class PDF {
  String name;
  String url;

  PDF({required this.name, required this.url});

  factory PDF.fromJson(Map<String, dynamic> json) {
    return PDF(name: json['name'], url: json['url']);
  }

  toJson() {
    return {
      'name': name,
      'url': url,
    };
  }
}

class LectureVideo {
  String name;
  String url;
  String thumbnail;
  LectureVideo(
      {required this.name, required this.url, required this.thumbnail});

  factory LectureVideo.fromJson(Map<String, dynamic> json) {
    return LectureVideo(
        name: json['name'], url: json['url'], thumbnail: json['thumbnail']);
  }

  toJson() {
    return {'name': name, 'url': url, 'thumbnail': thumbnail};
  }
}

class FAQModel {
  final String question;
  final String answer;

  FAQModel({
    required this.answer,
    required this.question,
  });

  factory FAQModel.fromJson(Map<String, dynamic> json) {
    return FAQModel(answer: json['answer'], question: json['question']);
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'answer': answer,
    };
  }
}

class AnnounmentsModel {
  String adminName;
  String text;
  String? image;

  AnnounmentsModel({
    required this.adminName,
    required this.text,
    this.image,
  });

  factory AnnounmentsModel.fromJson(Map<String, dynamic> json) {
    return AnnounmentsModel(
        adminName: json['adminName'], text: json['text'], image: json['image']);
  }

  Map<String, dynamic> toJson() {
    return {
      'adminName': adminName,
      'text': text,
      'image': image ?? 'N/A',
    };
  }
}
