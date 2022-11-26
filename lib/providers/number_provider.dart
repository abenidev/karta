import 'package:flutter_riverpod/flutter_riverpod.dart';

class NumberStateNotifier extends StateNotifier<int> {
  NumberStateNotifier() : super(0);

  void increment() => state++;
  void decrement() => state--;
}

final numberStateNotifierProvider = StateNotifierProvider<NumberStateNotifier, int>((ref) {
  return NumberStateNotifier();
});
