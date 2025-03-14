import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:tech_haven/core/common/widgets/loader.dart';
import 'package:tech_haven/core/common/widgets/primary_app_button.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/core/utils/auth_utils.dart';
import 'package:tech_haven/core/utils/show_snackbar.dart';
import 'package:tech_haven/user/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tech_haven/user/features/auth/presentation/bloc/forgot_password_page_state.dart';
import 'package:tech_haven/user/features/auth/presentation/responsive/responsive_authentication.dart';
import 'package:tech_haven/user/features/auth/presentation/widgets/authentication_container.dart';
import 'package:tech_haven/core/common/widgets/phone_number_text_field.dart';
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController phoneNumberController = TextEditingController();
  final countryCode = AuthUtils.forgotPasswordCountryCode;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UserEmailForgotPasswordFailed) {
            showSnackBar(
              context: context,
              title: 'Oh',
              content: state.message,
              contentType: ContentType.failure,
            );
            GoRouter.of(context).pop();
          }
          if (state is UserEmailForgotPasswordSuccess) {
            showSnackBar(
              context: context,
              title: 'Success',
              content: state.message,
              contentType: ContentType.success,
            );
            GoRouter.of(context).pop();
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Loader();
          }
          return ResponsiveAuthentication(
            mobileLayout: _buildForgotPasswordMobileLayout(context),
            desktopLayout: _buildForgotPasswordDesktopLayout(context),
          );
        },
      );
  }

  Widget _buildForgotPasswordMobileLayout(BuildContext context) {
    return Scaffold(
         backgroundColor: AppPallete.primaryAppColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [       const SizedBox(height: 50),
          Flexible(
            flex: 2,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 415, maxWidth: 415),
              child: Lottie.asset('assets/lotties/forget_password.json'),
            ),
          ),
          Flexible(
            flex: 4,
            child: _buildForgotPasswordContainer(context),
          ),
        ],
      ),
    );
  }

  Widget _buildForgotPasswordDesktopLayout(BuildContext context) {
    return Scaffold(
         backgroundColor: AppPallete.primaryAppColor,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 415, maxWidth: 415),
            child: Lottie.asset('assets/lotties/forget_password.json'),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 625, maxWidth: 415),
            child: _buildForgotPasswordContainer(context),
          ),
        ],
      ),
    );
  }

  Widget _buildForgotPasswordContainer(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.bottomCenter,
      children: [
        Column(
          children: [
            const SizedBox(height: 50),
            Expanded(
              child: AuthenticationContainer(
                title: "Forgot \nPassword?",
                subTitle: 'Enter your registered mobile number',
                columnChildren: [
                  const SizedBox(height: 20),
                  PhoneNumberTextField(
                    countryCode: countryCode,
                    textFormFieldEnabled: true,
                    phoneNumberController: phoneNumberController,
                  ),
                  PrimaryAppButton(
                    buttonText: 'Send OTP',
                    onPressed: () async {
                      if (countryCode.value != '000') {
                        final fullPhoneNumber =
                            '+${countryCode.value}${phoneNumberController.text}';
                        context.read<AuthBloc>().add(ForgotPasswordSendEmailEvent(
                          phoneNumber: fullPhoneNumber,
                        ));
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
