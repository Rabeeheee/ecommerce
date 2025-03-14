import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tech_haven/core/common/domain/usecase/get_vendor_data.dart';
import 'package:tech_haven/core/entities/user.dart';
import 'package:tech_haven/core/entities/vendor.dart';
import 'package:tech_haven/vendor/features/registervendor/domain/usecase/send_request_for_vendor.dart';

part 'register_vendor_event.dart';
part 'register_vendor_state.dart';

class RegisterVendorBloc
    extends Bloc<RegisterVendorEvent, RegisterVendorState> {
  final SendRequestForVendor _sendRequestForVendor;
  final GetVendorData _getVendorData;
  RegisterVendorBloc(
      {required SendRequestForVendor sendRequestForVendor,
      required GetVendorData getVendorData})
      : _getVendorData = getVendorData,
        _sendRequestForVendor = sendRequestForVendor,
        super(RegisterVendorInitial()) {
    on<RegisterVendorEvent>((event, emit) {
      emit(RegisterVendorLoading());
    });
    on<CheckForVendorStatusEvent>(_onCheckForVendorStatusEvent);
    on<SendRequestForVendorEvent>(_onSendRequestForVendorEvent);
  }

  FutureOr<void> _onSendRequestForVendorEvent(SendRequestForVendorEvent event,
      Emitter<RegisterVendorState> emit) async {
    final result = await _sendRequestForVendor(
      SendRequestForVendorParams(
        user: event.user,
        businessPicture: event.businessPicuture,
        businessName: event.businessName,
        physicalAddress: event.physicalAddress,
        accountNumber: event.accountNumber,
      ),
    );

    result.fold(
        (failure) => emit(SendRequestForVendorFailed(message: failure.message)),
        (success) => emit(SendRequestForVendorSuccess(
              vendorID: success,
            )));
  }

  FutureOr<void> _onCheckForVendorStatusEvent(CheckForVendorStatusEvent event,
      Emitter<RegisterVendorState> emit) async {
    final result =
        await _getVendorData(GetVendorDataParams(vendorID: event.vendorID));
    result.fold(
        (failure) => emit(CheckForVendorStatusFailed(message: failure.message)),
        (success) {
      return emit(CheckForVendorStatusSuccess(vendor: success!));
    });
  }
}
