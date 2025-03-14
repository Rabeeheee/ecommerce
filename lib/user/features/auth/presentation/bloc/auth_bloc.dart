import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:tech_haven/core/common/cubits/app_cubit/app_user_cubit.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/auth/domain/usecases/forgot_password_send_email.dart';
import 'package:tech_haven/user/features/auth/domain/usecases/create_user.dart';
import 'package:tech_haven/user/features/auth/domain/usecases/google_sign_up.dart';
import 'package:tech_haven/user/features/auth/domain/usecases/update_user_phone_number.dart';
import 'package:tech_haven/user/features/auth/domain/usecases/user_signin.dart';
import 'package:tech_haven/user/features/auth/domain/usecases/verify_phone_number_and_sign_up.dart';
import 'package:tech_haven/user/features/auth/domain/usecases/send_otp_to_phone_number.dart';
import 'package:tech_haven/user/features/auth/presentation/bloc/forgot_password_page_state.dart';
import 'package:tech_haven/user/features/auth/presentation/bloc/otp_page_state.dart';
import 'package:tech_haven/user/features/auth/presentation/bloc/sign_in_page_state.dart';
import 'package:tech_haven/user/features/auth/presentation/bloc/sign_up_page_state.dart';
import 'sign_up_welcome_page.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // final UserSignUp _userSignUp;
  // final CurrentUser _currentUser;
  final SendOTPToPhoneNumber _sendOTPToPhoneNumber;
  final VerifyPhoneAndSignUpUser _verifyPhoneAndSignUpUser;
  final CreateUser _createUser;
  final UserSignIn _userSignIn;
  final GoogleSignUp _googleSignUp;
  final ForgotPasswordSendEmail _forgotPasswordSendEmail;
  final UpdateUserPhoneNumber _updateUserPhoneNumber;
  AuthBloc({
    // required UserSignUp userSignUp,
    required AppUserCubit appUserCubit,
    // required CurrentUser currentUser,
    required UpdateUserPhoneNumber updateUserPhoneNumber,
    required SendOTPToPhoneNumber sendOTPToPhoneNumber,
    required VerifyPhoneAndSignUpUser verifyPhoneAndSignUpUser,
    required CreateUser createUser,
    required UserSignIn userSignIn,
    required GoogleSignUp googleSignUp,
    required ForgotPasswordSendEmail forgotPasswordSendEmail,
  })  :
        //  _userSignUp = userSignUp,
        _updateUserPhoneNumber = updateUserPhoneNumber,
        _sendOTPToPhoneNumber = sendOTPToPhoneNumber,
        _verifyPhoneAndSignUpUser = verifyPhoneAndSignUpUser,
        _createUser = createUser,
        _userSignIn = userSignIn,
        _googleSignUp = googleSignUp,
        _forgotPasswordSendEmail = forgotPasswordSendEmail,
        super(AuthInitial()) {
    // on the first event or in the initial stage we will show the loading state
    on<AuthEvent>((event, emit) {
      emit(
        AuthLoading(),
      );
    });
    //for verifying the phoneNumber and also creating a user with email and password
    // on<NavigateToSignUpPageEvent>(_onNavigateToSignUpPageEvent);
    // on<AuthSignUpEvent>(_onAuthSignUpEvent);
    //sending the phonenumber to send the otp.
    on<SendOTPEvent>(_onSendOTPEvent);
    on<VerifyPhoneAndSignUpUserEvent>(_onVerifyPhoneAndSignUpUserEvent);
    //for verifying the otp pincode with phone number
    on<CreateUserEvent>(_onCreateUserEvent);
    // on<AuthIsUserLoggedInEvent>(_onAuthIsUserLoggedInEvent);
    on<UserSignInEvent>(_onUserSignInEvent);
    on<SignUpWithGoogleAccount>(_onSignUpWithGoogleAccount);
    on<SignInWithGoogleAccount>(_onSignInWithGoogleAccount);
    on<ForgotPasswordSendEmailEvent>(_onForgotPasswordSendEmailEvent);
    on<UpdateThePhoneNumberOfUser>(_onUpdateThePhoneNumberOfUser);
    // on<ForgotPasswordOTPVerificaion>(_onForgotPasswordOTPVerificaion);
  }

  FutureOr<void> _onSendOTPEvent(
    SendOTPEvent event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _sendOTPToPhoneNumber(
      SendOTPToPhoneNumberParams(
        phonenumber: event.phoneNumber,
        email: event.email,
        password: event.password,
      ),
    );
    res.fold((failure) => emit(OTPSendFailed(message: failure.message)),
        (authSignUpModel) {
      emit(
        OTPSendSuccess(authSignUpModel: authSignUpModel),
      );
    });
  }

  FutureOr<void> _onVerifyPhoneAndSignUpUserEvent(
      VerifyPhoneAndSignUpUserEvent event, Emitter<AuthState> emit) async {
    final res = await _verifyPhoneAndSignUpUser(VerifyPhoneAndSignUpUserParams(
      phoneNumber: event.phoneNumber,
      email: event.email,
      password: event.password,
      verificationId: event.verificationId,
      otpCode: event.otpCode,
    ));
    res.fold(
      (failure) => emit(
        UserCreationFailed(
          message: failure.message,
        ),
      ),
      (username) => emit(
        UserCreationSuccess(
          username: username,
        ),
      ),
    );
  }

  FutureOr<void> _onCreateUserEvent(
      CreateUserEvent event, Emitter<AuthState> emit) async {
    final res = await _createUser(CreateUserParams(
      image: event.image,
      username: event.username,
      currency: event.currency,
      currencySymbol: event.currencySymbol,
      color: event.color,
    ));

    res.fold(
      (failure) => emit(CreateUserFailed(message: failure.message)),
      (userCreated) => emit(
        CreateUserSuccess(
          userCreated: userCreated,
        ),
      ),
    );
  }

  FutureOr<void> _onUserSignInEvent(
      UserSignInEvent event, Emitter<AuthState> emit) async {
    final res = await _userSignIn(UserSignInParams(
        phoneNumber: event.phoneNumber, password: event.password));
    res.fold((failure) => emit(AuthSignInFailed(message: failure.message)),
        (result) {
      emit(AuthSignInSuccess(
        message: result,
      ));
    });
  }

  // FutureOr<void> _onAuthIsUserLoggedInEvent(
  //     AuthIsUserLoggedInEvent event, Emitter<AuthState> emit) async {
  //   final res = await _currentUser(NoParams());

  //   res.fold(
  //       (failure) => emit(
  //             AuthIsUserLoggedInFailed(message: failure.message),
  //           ), (user) {
  //     _appUserCubit.updateUser(user);
  //     emit(
  //       AuthIsUserLoggedInSuccess(user: user),
  //     );
  //   });
  // }

  FutureOr<void> _onSignUpWithGoogleAccount(
      SignUpWithGoogleAccount event, Emitter<AuthState> emit) async {
    final res = await _googleSignUp(NoParams());
    res.fold((failure) => emit(AuthGoogleSignUpFailed(message: failure.message)),
        (success) => emit(AuthGoogleSignUpSuccess(message: success)));
  }

  FutureOr<void> _onSignInWithGoogleAccount(
      SignInWithGoogleAccount event, Emitter<AuthState> emit) async {
    final res = await _googleSignUp(NoParams());
    res.fold((failure) => emit(AuthGoogleSignInFailed(message: failure.message)),
        (success) => emit(AuthGoogleSignInSuccess(message: success)));
  }

  FutureOr<void> _onForgotPasswordSendEmailEvent(
      ForgotPasswordSendEmailEvent event, Emitter<AuthState> emit) async {
    final res = await _forgotPasswordSendEmail(
        ForgotPasswordSendEmailParams(phoneNumber: event.phoneNumber));

    res.fold(
        (failure) => emit(UserEmailForgotPasswordFailed(
              message: failure.message,
            )),
        (success) => emit(UserEmailForgotPasswordSuccess(message: success)));
  }

  // FutureOr<void> _onForgotPasswordOTPVerificaion(ForgotPasswordOTPVerificaion event, Emitter<AuthState> emit) {

  // }

  FutureOr<void> _onUpdateThePhoneNumberOfUser(
      UpdateThePhoneNumberOfUser event, Emitter<AuthState> emit) async {
    final res = await _updateUserPhoneNumber(UpdateUserPhoneNumberParams(
        updateNumber: event.updateNumber,
        phoneNumber: event.phoneNumber,
        verificationID: event.verificationID,
        otpCode: event.otpCode));
    res.fold((failed) => emit(UpdateUserPhoneNumberFailed(message: failed.message)), (success) => emit(UpdateUserPhoneNumberSuccess()));
  }
}
