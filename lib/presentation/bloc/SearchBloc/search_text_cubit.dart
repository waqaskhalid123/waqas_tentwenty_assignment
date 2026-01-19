import 'package:flutter_bloc/flutter_bloc.dart';

class SearchTextCubit extends Cubit<String> {
  SearchTextCubit() : super('');

  void updateText(String text) {
    emit(text);
  }

  void clearText() {
    emit('');
  }
}
