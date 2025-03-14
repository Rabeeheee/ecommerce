import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tech_haven/core/common/domain/usecase/get_user_data.dart';
import 'package:tech_haven/core/entities/user.dart';
import 'package:tech_haven/core/entities/vendor.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/vendor/features/profile/domain/usecase/get_vendor_profile.dart';

part 'vendor_profile_event.dart';
part 'vendor_profile_state.dart';

class VendorProfileBloc extends Bloc<VendorProfileEvent, VendorProfileState> {
  final GetVendorProfile getVendorProfile;
  final GetUserData getUserData;

  VendorProfileBloc({required this.getVendorProfile, required this.getUserData})
      : super(VendorProfileInitial()) {
    on<GetVendorProfileEvent>(_onGetVendorProfile);
  }

  Future<void> _onGetVendorProfile(
      GetVendorProfileEvent event, Emitter<VendorProfileState> emit) async {
    emit(VendorProfileLoading());
    try {
      User? userdata;
      final user = await getUserData(NoParams());
      user.fold((failure) => emit(VendorProfileError(failure.message)),
          (success) => userdata = success!);
      if (userdata != null) {
        final vendor = await getVendorProfile(
            GetVendorProfileParams(vendorID: userdata!.vendorID!));
        vendor.fold((failure) => emit(VendorProfileError(failure.message)),
            (success) => emit(VendorProfileLoaded(success)));
      }
    } catch (e) {
      emit(VendorProfileError(e.toString()));
    }
  }
}
