import 'package:state_notifier/state_notifier.dart';

class CheckReturnBookRepository extends StateNotifier<List<int>> {
  CheckReturnBookRepository() : super([]);

  void add(registerIndex) {
    state = [...state, registerIndex];
  }

  void remove(registerIndex) =>
      state = state.where((item) => item != registerIndex).toList();
}
