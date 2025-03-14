import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_category.dart';
import 'package:tech_haven/core/entities/category.dart';

part 'search_category_event.dart';
part 'search_category_state.dart';

class SearchCategoryBloc
    extends Bloc<SearchCategoryEvent, SearchCategoryState> {
  final GetAllCategory _getAllCategory;
  static bool isDataLoaded = false;
  SearchCategoryBloc({required GetAllCategory getAllCategory})
      : _getAllCategory = getAllCategory,
        super(SearchCategoryInitial()) {
    on<SearchCategoryEvent>((event, emit) {
      emit(SearchCategoryLoading());
    });
    on<GetAllSearchCategoryEvent>(_onGetAllSearchCategoryEvent);
  }

  FutureOr<void> _onGetAllSearchCategoryEvent(GetAllSearchCategoryEvent event,
      Emitter<SearchCategoryState> emit) async {
    if (isDataLoaded == false) {
      final result = await _getAllCategory(
          GetAllCategoryParams(refreshPage: event.refreshPage));

      result.fold(
          (failure) => emit(
              SearchCategoryAllCategoryLoadedFailed(message: failure.message)),
          (success) {
        isDataLoaded = true;
        emit(SearchCategoryAllCategoryLoadedSuccess(allCategoryModel: success));
      });
    }
  }
}
