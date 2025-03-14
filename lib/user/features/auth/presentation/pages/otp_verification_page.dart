import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:tech_haven/core/common/widgets/loader.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/core/utils/show_snackbar.dart';
import 'package:tech_haven/user/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tech_haven/user/features/auth/presentation/bloc/otp_page_state.dart';
import 'package:tech_haven/user/features/auth/presentation/responsive/responsive_authentication.dart';
import 'package:tech_haven/user/features/auth/presentation/route%20params/home_route_params.dart';
import 'package:tech_haven/user/features/auth/presentation/widgets/authentication_container.dart';
import 'package:lottie/lottie.dart';

class OTPVerificationPage extends StatelessWidget {
  OTPVerificationPage({
    super.key,
    required this.otpParams,
  });

  final OTPParams otpParams;

  final pinController = TextEditingController();

  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.primaryAppColor,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UserCreationSuccess) {
            if (otpParams.isForSignUp) {
              GoRouter.of(context).pushReplacementNamed(
                AppRouteConstants.signupWelcomePage,
                pathParameters: {
                  'initialUsername': state.username,
                },
              );
            }
          }
          if (state is UserCreationFailed) {
            showSnackBar(
              context: context,
              title: 'Oh',
              content: state.message,
              contentType: ContentType.failure,
            );
            pinController.clear();
            GoRouter.of(context).pop();
          }
          if (state is UpdateUserPhoneNumberFailed) {
            Fluttertoast.showToast(msg: state.message);
            GoRouter.of(context).pop();
          }
          if (state is UpdateUserPhoneNumberSuccess) {
            Fluttertoast.showToast(
                msg: "Your Phone number is successfully Updated");
            GoRouter.of(context).pop();
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Loader();
          }
          return _buildOTPMobileLayout(context);
        },
      ),
    );
  }

  Widget _buildOTPMobileLayout(BuildContext context) {
    print('rebuilding otp mobile');
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 2,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 415, maxWidth: 415),
            child: Lottie.asset('assets/lotties/otp_lottie.json'),
          ),
        ),
        Flexible(
          flex: 4,
          child: _buildOTPAuthenticationContainer(context),
        ),
      ],
    );
  }

  Widget _buildOTPDesktopLayout(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 415, maxWidth: 415),
          child: Lottie.asset('assets/lotties/otp_lottie.json'),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 625, maxWidth: 415),
          child: _buildOTPAuthenticationContainer(context),
        ),
      ],
    );
  }

  Widget _buildOTPAuthenticationContainer(BuildContext context) {
    print('hi');
    const fillColor = AppPallete.lightgreyColor;
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(10),
      ),
    );

    return Stack(
      fit: StackFit.expand,
      children: [
        Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Expanded(
              child: AuthenticationContainer(
                title: 'Code Verification',
                subTitle:
                    'Enter your 6-digit verification code received on your phone number',
                columnChildren: [
                  const SizedBox(height: 20),
                  Pinput(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    length: 6,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(
                        6,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      )
                    ],
                    controller: pinController,
                    focusNode: focusNode,
                    defaultPinTheme: defaultPinTheme,
                    separatorBuilder: (index) => const SizedBox(width: 1),
                    onClipboardFound: (value) {
                      pinController.setText(value);
                    },
                    hapticFeedbackType: HapticFeedbackType.lightImpact,
                    onCompleted: (pinCode) {
                      print(pinCode);
                      if (otpParams.isForSignUp) {
                        context.read<AuthBloc>().add(
                              VerifyPhoneAndSignUpUserEvent(
                                phoneNumber: otpParams.phoneNumber,
                                email: otpParams.email!,
                                password: otpParams.password!,
                                verificationId: otpParams.verificaionID,
                                otpCode: pinCode,
                              ),
                            );
                      } else {
                        context.read<AuthBloc>().add(
                              UpdateThePhoneNumberOfUser(
                                updateNumber: false,
                                phoneNumber: otpParams.phoneNumber,
                                verificationID: otpParams.verificaionID,
                                otpCode: pinCode,
                              ),
                            );
                      }
                    },
                    onChanged: (value) {
                      // print(value);
                      if (value.length == 6) {}
                      // debugPrint('onChanged: $value');
                    },
                    cursor: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 9),
                          width: 22,
                          height: 1,
                          color: AppPallete.blackColor,
                        ),
                      ],
                    ),
                    focusedPinTheme: defaultPinTheme,
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
