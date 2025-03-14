
// class GetAllCategory implements UseCase<List<Category>, GetAllCategoryParams> {
//   final SearchCategoryRepository searchCategoryRepository;
//   GetAllCategory({required this.searchCategoryRepository});

//   @override
//   Future<Either<Failure, List<Category>>> call(GetAllCategoryParams params) async {
//     return await searchCategoryRepository.getAllCategories(params.refreshPage);
//   }
// }

// class GetAllCategoryParams {
//   final bool refreshPage;
//   GetAllCategoryParams({required this.refreshPage});
// }
