part of 'search_category_bloc.dart';

sealed class SearchCategoryState extends Equatable {
  const SearchCategoryState();
  @override
  List<Object> get props => [];
}

final class SearchCategoryInitial extends SearchCategoryState {}

final class SearchCategoryLoading extends SearchCategoryState {}

final class SearchCategoryPageState extends SearchCategoryState {}

final class SearchCategoryPageActionState extends SearchCategoryPageState {}

final class SearchCategoryAllCategoryLoadedSuccess
    extends SearchCategoryPageState {
  final List<Category> allCategoryModel;
  SearchCategoryAllCategoryLoadedSuccess({required this.allCategoryModel});
}

final class SearchCategoryAllCategoryLoadedFailed
    extends SearchCategoryPageActionState {
  final String message;
  SearchCategoryAllCategoryLoadedFailed({required this.message});
}
