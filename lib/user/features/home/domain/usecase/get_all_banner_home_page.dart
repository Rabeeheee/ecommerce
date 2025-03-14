import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/banner.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/home/domain/repository/home_page_repository.dart';

class GetAllBannerHomePage implements UseCase<List<Banner>, NoParams> {
  final HomePageRepository homePageRepository;
  GetAllBannerHomePage({required this.homePageRepository});

  @override
  Future<Either<Failure, List<Banner>>> call(NoParams params) async {
    return await homePageRepository.getAllBanners();
  }
}
