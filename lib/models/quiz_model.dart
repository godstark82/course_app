// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserQuizModel {
  QuizModel quiz;
  bool attemped;
  int lastScore;
  DateTime time;
  List<int?> userRecords;

  UserQuizModel(
      {required this.attemped,
      required this.lastScore,
      required this.quiz,
      required this.time,
      required this.userRecords});

  factory UserQuizModel.fromJson(Map<String, dynamic> json) {
    return UserQuizModel(
        time: DateTime.parse(json['time'].toString()),
        attemped: bool.parse(json['attemped'].toString()),
        lastScore: int.parse(json['lastScore'].toString()),
        userRecords: (json['userRecords'] as List)
            .map((e) => int.parse(e.toString()))
            .toList(),
        quiz: QuizModel.fromJson(json['quiz']));
  }

  toJson() {
    return {
      'time': time.toIso8601String(),
      'attemped': attemped,
      'lastScore': lastScore,
      'userRecords': userRecords.map((e) => int.parse(e.toString())).toList(),
      'quiz': quiz.toJson()
    };
  }
}

class QuizModel {
  String quizName;
  DateTime time;
  List<QuizQuestion> questions;
  QuizModel({
    required this.quizName,
    required this.time,
    required this.questions,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'quizName': quizName,
      'time': time.toIso8601String(),
      'questions': questions.map((x) => x.toJson()).toList(),
    };
  }

  factory QuizModel.fromJson(Map<String, dynamic> map) {
    return QuizModel(
        quizName: map['quizName'].toString(),
        time: DateTime.parse(map['time']),
        questions: (map['questions'] as List)
            .map((question) => QuizQuestion.fromJson(question))
            .toList());
  }

  @override
  String toString() =>
      'QuizModel(quizName: $quizName, time: $time, questions: $questions)';
}

class QuizQuestion {
  String question;
  List<String> options;
  int correctAnswer;
  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswer,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'question': question,
      'options': options,
      'correctAnswer': correctAnswer,
    };
  }

  factory QuizQuestion.fromJson(Map<String, dynamic> map) {
    return QuizQuestion(
      correctAnswer: int.parse(map['correctAnswer'].toString()),
      question: map['question'].toString(),
      options: (map['options'] as List).map((e) => '$e').toList(),
    );
  }

  @override
  String toString() =>
      'QuizQuestion(question: $question, options: $options, correctAnswer: $correctAnswer)';
}
