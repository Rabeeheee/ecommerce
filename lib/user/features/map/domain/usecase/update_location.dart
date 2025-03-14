
import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/common/domain/repository/repository.dart';
import 'package:tech_haven/core/usecase/usecase.dart';

import '../../../../../core/error/failures.dart';

class UpdateLocation implements UseCase<bool, UpdateLocationParams> {
  final Repository repository;
  UpdateLocation({required this.repository});

  @override
  Future<Either<Failure, bool>> call(UpdateLocationParams params) async {
    return await repository.updateLocation(
        name: params.name,
        phoneNumber: params.phoneNumber,
        location: params.location,
        apartmentHouseNumber: params.apartmentHouseNumber,
        emailAddress: params.emailAddress,
        addressInstructions: params.addressInstructions);
  }
}

class UpdateLocationParams {
  final String name;
  final String phoneNumber;
  final String location;
  final String apartmentHouseNumber;
  final String emailAddress;
  final String addressInstructions;

  UpdateLocationParams(
      {
      required this.name,
      required this.phoneNumber,
      required this.location,
      required this.apartmentHouseNumber,
      required this.emailAddress,
      required this.addressInstructions});
}
