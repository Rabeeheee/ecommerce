// import 'package:fpdart/fpdart.dart';
// import 'package:tech_haven/core/error/failures.dart';
// import 'package:tech_haven/core/usecase/usecase.dart';
// import 'package:tech_haven/user/features/auth/domain/repository/auth_repository.dart';

// class GoogleSignIn implements UseCase<String, NoParams> {
//   final AuthRepository authRepository;
//   GoogleSignIn({required this.authRepository});
  
//   @override
//   Future<Either<Failure, String>> call(NoParams params) async{
//    return await authRepository.signInUserWithGoogle();
//   }
// }