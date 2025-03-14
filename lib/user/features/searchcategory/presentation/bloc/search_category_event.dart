part of 'search_category_bloc.dart';

sealed class SearchCategoryEvent extends Equatable {
  const SearchCategoryEvent();

  @override
  List<Object> get props => [];
}

final class GetAllSearchCategoryEvent extends SearchCategoryEvent {
  final bool refreshPage;
  const GetAllSearchCategoryEvent({required this.refreshPage});
}
