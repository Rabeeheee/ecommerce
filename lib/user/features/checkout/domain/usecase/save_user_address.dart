import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/checkout/domain/repository/checkout_repository.dart';

class SaveUserAddress implements UseCase<void, SaveUserAddressParams> {
   final CheckoutRepository checkoutRepository;

  SaveUserAddress(this.checkoutRepository);

  @override
  Future<Either<Failure, void>> call(SaveUserAddressParams params) async {
    return await checkoutRepository.saveUserAddress(
      address: params.address,
      pin: params.pin,
      city: params.city,
      state: params.state,
      country: params.country,
    );
  }
}
class SaveUserAddressParams   {
  final String address;
  final String pin;
  final String city;
  final String state;
  final String country;

  const SaveUserAddressParams({
    required this.address,
    required this.pin,
    required this.city,
    required this.state,
    required this.country,
  });

}