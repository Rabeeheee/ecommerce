import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_category_cubit_state.dart';

class SearchCategoryCubit extends Cubit<int> {
  SearchCategoryCubit() : super(0);

  void changeIndex(int newIndex) {
    // Check if the new index is different from the current state
    if (newIndex != state) {
      emit(newIndex);
    }
  }
}

class SearchCategoryAccordionCubit extends Cubit<int> {
  SearchCategoryAccordionCubit() : super(0);

  void changeAccordionIndex(int newIndex) {
    if (newIndex != state) {
      emit(newIndex);
    } else {
      emit(-1);
    }
  }
}
