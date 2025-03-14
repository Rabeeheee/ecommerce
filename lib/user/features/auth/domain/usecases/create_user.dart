import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/auth/domain/repository/auth_repository.dart';

class CreateUser implements UseCase<bool, CreateUserParams> {
  final AuthRepository authRepository;
  CreateUser({required this.authRepository});
  @override
  Future<Either<Failure, bool>> call(CreateUserParams params) async {
    return await authRepository.createUser(
        image: params.image,
        username: params.username,
        currency: params.currency,
        currencySymbol: params.currencySymbol,
        color: params.color);
  }
}

class CreateUserParams {
  final dynamic image;
  final String username;
  final String currency;
  final String currencySymbol;
  final int color;

  CreateUserParams({
    required this.currency,
    required this.currencySymbol,
    required this.image,
    required this.username,
    required this.color,
  });
}
