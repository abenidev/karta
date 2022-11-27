import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:karta/constants/strings.dart';
import 'package:karta/models/question.dart';
import '../screens/home_screen/home_screen.dart';

class QuestionNotifier extends StateNotifier<List<Question>> {
  QuestionNotifier(this.ref) : super([]);
  final Ref ref;

  void setQuestions(List<Question> newQuestions) {
    state = [...state, ...newQuestions];
  }
}

final questionNotifierProvider = StateNotifierProvider<QuestionNotifier, List<Question>>((ref) => QuestionNotifier(ref));

final questionsFutureProvider = FutureProvider((ref) async {
  final response = await http.get(Uri.parse(kUrl));
  final body = jsonDecode(response.body);
  //

  ref.read(loadingStateProvider.notifier).state = false;

  final q = List.generate(
    body.length,
    (index) => Question(
      id: body[index]['id'],
      question: body[index]['question'],
      choices: [...body[index]['answers'].entries.map((entry) => entry.value ?? '').toList()],
      answers: [...body[index]['correct_answers'].entries.map((entry) => entry.value == "true" ? 1 : 0).toList()],
      difficulty: body[index]['difficulty'],
      category: body[index]['category'],
      iAsked: false,
    ),
  );

  ref.read(questionNotifierProvider.notifier).setQuestions(q);

  return q;
});
