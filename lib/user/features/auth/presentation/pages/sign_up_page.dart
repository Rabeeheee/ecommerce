import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:tech_haven/core/common/widgets/circular_button.dart';
import 'package:tech_haven/core/common/widgets/loader.dart';
import 'package:tech_haven/core/common/widgets/primary_app_button.dart';
import 'package:tech_haven/core/constants/constants.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/utils/auth_utils.dart';
import 'package:tech_haven/core/validators/validators.dart';
import 'package:tech_haven/user/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tech_haven/user/features/auth/presentation/bloc/sign_up_page_state.dart';
import 'package:tech_haven/user/features/auth/presentation/constants/auth_constants.dart';
import 'package:tech_haven/core/common/widgets/custom_text_form_field.dart';
import 'package:tech_haven/core/common/widgets/phone_number_text_field.dart';
import 'package:tech_haven/user/features/auth/presentation/responsive/responsive_authentication.dart';
import 'package:tech_haven/user/features/auth/presentation/route%20params/home_route_params.dart';
import '../../../../../core/theme/app_pallete.dart';
import '../widgets/authentication_container.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

String? phoneNumberError;
String? emailError;
String? passwordError;
String? rePasswordError;
final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
bool passwordIsObscure = true;
bool rePasswordIsObscure = true;
late String fullPhoneNumber;
bool textFormFieldEnabled = true;
final phoneNumberController = TextEditingController();
final emailController = TextEditingController();
final passwordController = TextEditingController();
final rePasswordController = TextEditingController();

class _SignUpPageState extends State<SignUpPage> {
  final countryCode = AuthUtils.signUpCountryCode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.primaryAppColor,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is OTPSendFailed) {
            Fluttertoast.showToast(msg: state.message);
          }
          if (state is OTPSendSuccess) {
            GoRouter.of(context).pushNamed(
              AppRouteConstants.otpVerificationPage,
              extra: OTPParams(
                email: state.authSignUpModel.email,
                password: state.authSignUpModel.password,
                phoneNumber: state.authSignUpModel.phoneNumber,
                verificaionID: state.authSignUpModel.verificationID,
                isForSignUp: true,
              ),
            );
          }
          if (state is AuthGoogleSignUpSuccess) {
            GoRouter.of(context).goNamed(AppRouteConstants.mainPage);
          }
          if (state is AuthGoogleSignUpFailed) {
            Fluttertoast.showToast(msg: state.message);
            // showSnackBar(
            //   context: context,
            //   title: 'Oh',
            //   content: state.message,
            //   contentType: ContentType.failure,
            // );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Loader();
          }

          return Form(
            key: signupFormKey,
            child: ResponsiveAuthentication(
              mobileLayout: _buildSignUpMobileLayout(this.context),
              desktopLayout: _buildSignUpTabletDesktopLayout(this.context),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSignUpMobileLayout(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          // height: 15,
        ),
        Positioned(
          top: 0,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 415, maxWidth: 415),
            child: Lottie.asset('assets/lotties/sign_up_lottie.json'),
          ),
        ),
        Positioned(
          bottom: 0,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 625, maxWidth: 415),
            child: _buildSignUpAuthenticationContainer(context),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpTabletDesktopLayout(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 415, maxWidth: 415),
          child: Lottie.asset('assets/lotties/sign_up_lottie.json'),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 625, maxWidth: 415),
          child: _buildSignUpAuthenticationContainer(context),
        ),
      ],
    );
  }

  Widget _buildSignUpAuthenticationContainer(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Column(
          children: [
            const SizedBox(height: 50),
            Expanded(
              child: AuthenticationContainer(
                // height: 625,
                title: 'Sign Up',
                columnChildren: [
                  PhoneNumberTextField(
                    countryCode: countryCode,
                    textFormFieldEnabled: textFormFieldEnabled,
                    phoneNumberController: phoneNumberController,
                    errorText: phoneNumberError,
                  ),
                  CustomTextFormField(
                    enabled: textFormFieldEnabled,
                    textEditingController: emailController,
                    labelText: 'Email',
                    hintText: 'example@gmail.com',
                    validator: Validator.validateEmail,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    errorText: emailError,
                  ),
                  CustomTextFormField(
                    enabled: textFormFieldEnabled,
                    textEditingController: passwordController,
                    labelText: 'Password',
                    hintText: '',
                    isObscureText: passwordIsObscure,
                    validator: Validator.validatePassword,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    isPasswordField: true,
                    suffixOnTap: () {
                      setState(() {
                        passwordIsObscure = !passwordIsObscure;
                      });
                    },
                    errorText: passwordError,
                  ),
                  CustomTextFormField(
                    enabled: textFormFieldEnabled,
                    textEditingController: rePasswordController,
                    labelText: 'Re-Enter Password',
                    hintText: '',
                    isObscureText: rePasswordIsObscure,
                    isPasswordField: true,
                    suffixOnTap: () {
                      setState(() {
                        rePasswordIsObscure = !rePasswordIsObscure;
                      });
                    },
                    errorText: rePasswordError,
                  ),
                  FadeInUp(
                    from: 50,
                    duration: const Duration(
                      milliseconds: Constants.normalAnimationMilliseconds,
                    ),
                    curve: Curves.easeOut,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Already have an account?',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppPallete.primaryAppColor,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            GoRouter.of(context).pushReplacementNamed(
                              AppRouteConstants.signinPage,
                            );
                          },
                          child: const Text(
                            'Sign in',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  PrimaryAppButton(
                    buttonText: 'Sign up',
                    onPressed: () async {
                      setState(() {
                        phoneNumberError = Validator.validatePhoneNumber(
                          phoneNumberController.text,
                        );
                        emailError = Validator.validateEmail(
                          emailController.text,
                        );
                        passwordError = Validator.validatePassword(
                          passwordController.text,
                        );
                        rePasswordError =
                            passwordController.text == rePasswordController.text
                                ? null
                                : 'Passwords do not match';
                      });

                      if (phoneNumberError == null &&
                          emailError == null &&
                          passwordError == null &&
                          rePasswordError == null &&
                          countryCode.value != '000') {
                        fullPhoneNumber =
                            '+${countryCode.value}${phoneNumberController.text}';

                        context.read<AuthBloc>().add(
                          SendOTPEvent(
                            phoneNumber: fullPhoneNumber,
                            email: emailController.text,
                            password: passwordController.text,
                          ),
                        );

                        await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: fullPhoneNumber,
                          verificationCompleted: (phoneAuthCredential) {},
                          verificationFailed: (error) {},
                          codeSent: (verificationId, forceResendingToken) {
                            if (kDebugMode) {
                              print(verificationId);
                            }
                            GoRouter.of(context).pushNamed(
                              AppRouteConstants.otpVerificationPage,
                              extra: OTPParams(
                                email: emailController.text,
                                password: passwordController.text,
                                phoneNumber: fullPhoneNumber,
                                verificaionID: verificationId,
                                isForSignUp: true,
                              ),
                            );
                          },
                          codeAutoRetrievalTimeout: (verificationId) {},
                        );
                      }
                    },
                  ),
                  // const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 10,
          right: 35,
          child: CircularButton(
            onPressed: () async {
              // print('object');
              context.read<AuthBloc>().add(SignUpWithGoogleAccount());
            },
            circularButtonChild: SvgPicture.asset(
              AuthConstants.googleIconSVG,
              width: 30,
              height: 30,
            ),
            diameter: 70,
          ),
        ),
      ],
    );
  }
}
