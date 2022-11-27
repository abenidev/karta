// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Question {
  int id;
  String question;
  List<String> choices;
  List<int> answers;
  String category;
  String? difficulty;
  bool iAsked;

  Question({
    required this.id,
    required this.question,
    required this.choices,
    required this.answers,
    required this.category,
    this.difficulty,
    required this.iAsked,
  });

  Question copyWith({
    int? id,
    String? question,
    List<String>? choices,
    List<int>? answers,
    String? category,
    String? difficulty,
    bool? iAsked,
  }) {
    return Question(
      id: id ?? this.id,
      question: question ?? this.question,
      choices: choices ?? this.choices,
      answers: answers ?? this.answers,
      category: category ?? this.category,
      difficulty: difficulty ?? this.difficulty,
      iAsked: iAsked ?? this.iAsked,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'question': question,
      'choices': choices,
      'answers': answers,
      'category': category,
      'difficulty': difficulty,
      'iAsked': iAsked,
    };
  }

  // factory Question.fromMap(Map<String, dynamic> map) {
  //   return Question(
  //     id: map['id'] as int,
  //     question: map['question'] as String,
  //     choices: List<String>.from((map['choices'] as List<String>),
  //     answers: List<int>.from((map['answers'] as List<int>),
  //     category: map['category'] as String,
  //     difficulty: map['difficulty'] != null ? map['difficulty'] as String : null,
  //     iAsked: map['iAsked'] as bool,
  //   );
  // }

  String toJson() => json.encode(toMap());

  // factory Question.fromJson(String source) => Question.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Question(id: $id, question: $question, choices: $choices, answers: $answers, category: $category, difficulty: $difficulty, iAsked: $iAsked)';
  }

  @override
  bool operator ==(covariant Question other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.question == question &&
        listEquals(other.choices, choices) &&
        listEquals(other.answers, answers) &&
        other.category == category &&
        other.difficulty == difficulty &&
        other.iAsked == iAsked;
  }

  @override
  int get hashCode {
    return id.hashCode ^ question.hashCode ^ choices.hashCode ^ answers.hashCode ^ category.hashCode ^ difficulty.hashCode ^ iAsked.hashCode;
  }
}
