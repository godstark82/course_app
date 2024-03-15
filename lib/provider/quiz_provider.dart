
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_app/constants/db.dart';
import 'package:course_app/models/quiz_model.dart';
import 'package:course_app/provider/course_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class QuizProvider extends ChangeNotifier {
  final List<QuizModel> _quizes = ((db.value['quizes'] ?? []) as List)
      .map((quiz) => QuizModel.fromJson(quiz))
      .toList();

  List<QuizModel> get quizes => _quizes;

  final List<UserQuizModel> _userQuiz =
      ((db.value['user-quizes'] ?? []) as List)
          .map((quiz) => UserQuizModel.fromJson(quiz))
          .toList();

  List<UserQuizModel> get userQuiz => _userQuiz;

  Future<bool> fetchQuizes() async {
    _quizes.clear();
    final coll = await admin.doc('db').collection('quizes').get();
    final docs = coll.docs;
    for (int i = 0; i < docs.length; i++) {
      _quizes.add(QuizModel.fromJson(docs[i].data()));
    }
    notifyListeners();
    return true;
  }

  Future<bool> fetchUserQuiz() async {
    _userQuiz.clear();
    final coll = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('quiz')
        .get();
    final docs = coll.docs;
    for (int i = 0; i < docs.length; i++) {
      _userQuiz.add(UserQuizModel.fromJson(docs[i].data()));
    }
    notifyListeners();
    return true;
  }

  Future<void> enrollQuiz(UserQuizModel quiz) async {
    _userQuiz.clear();
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('quiz')
        .add(quiz.toJson());
    notifyListeners();
  }

  Future<void> editQuizToUserDoc(UserQuizModel quiz) async {
    final index = _userQuiz
        .indexWhere((element) => element.quiz.quizName == quiz.quiz.quizName);
    _userQuiz[index] = quiz;
    final collection = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('quiz')
        .get();
    final docs = collection.docs;

    final refDocument = docs.firstWhere(
        (element) => element.data()['quiz']['quizName'] == quiz.quiz.quizName);
    await refDocument.reference.update(quiz.toJson());
    notifyListeners();
  }
}
