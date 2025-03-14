
import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/address_details.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/checkout/domain/repository/checkout_repository.dart';

class GetAllUserAddress
    implements UseCase<List<AddressDetails>, GetAllUserAddressParams> {
  final CheckoutRepository checkoutRepository;
  GetAllUserAddress({required this.checkoutRepository});
  @override
  Future<Either<Failure, List<AddressDetails>>> call(
      GetAllUserAddressParams params) async {
    final result =
        await checkoutRepository.getAllUserAddress(userID: params.userID);
    return result;
  }
}

class GetAllUserAddressParams {
  final String userID;
  GetAllUserAddressParams({required this.userID});
}
