import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/appbar_searchbar.dart';
import 'package:tech_haven/core/common/widgets/phone_number_text_field.dart';
import 'package:tech_haven/core/common/widgets/rounded_rectangular_button.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/utils/show_snackbar.dart';
import 'package:tech_haven/user/features/auth/presentation/route%20params/home_route_params.dart';
import 'package:tech_haven/user/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:tech_haven/user/features/profile/presentation/widgets/profile_header_tile.dart';
import 'package:tech_haven/user/features/profile/presentation/widgets/profile_welcome_text.dart';
import 'package:tech_haven/user/features/profile/presentation/widgets/tile_bar_button.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProfileBloc>().add(GetUserProfileDataEvent());
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        appBar: const AppBarSearchBar(),
        body: SingleChildScrollView(
          child: BlocConsumer<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is GetProfileDataFailedState) {
                Fluttertoast.showToast(msg: state.message);
              }
              if (state is GoToOTPPageState) {
                GoRouter.of(context)
                    .pushNamed(AppRouteConstants.otpVerificationPage,
                        extra: OTPParams(
                          phoneNumber: '',
                          verificaionID: state.verificationID,
                          isForSignUp: false,
                        ));
              }
              if (state is FailedToGetVerificationID) {
                Fluttertoast.showToast(msg: state.message);
              }
            },
            buildWhen: (previous, current) => current is GetProfileDataState,
            builder: (context, state) {
              // if(state is GetProfileDataSuccessState){
              //   return
              // }
              return Column(
                children: [
                  //hello nice to meet you
                  ProfileWelcomeText(
                    color: state is GetProfileDataSuccessState ? state.user.color : 2345667,
                    imageURL: state is GetProfileDataSuccessState ? state.user.profilePhoto! : 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/2048px-Default_pfp.svg.png',
                    name: state is GetProfileDataSuccessState
                        ? state.user.username!
                        : 'Nice to meet you',
                    subText: state is GetProfileDataSuccessState
                        ? 'Enjoy your Tech Journey with Tech Haven'
                        : 'You are currently not signed in',
                    onTapSettingIcon: () {
                      GoRouter.of(context)
                          .pushNamed(AppRouteConstants.profileEditPage);
                    },
                  ),
                  //your orders
                  TileBarButton(
                    title: 'Your Orders',
                    icon: CustomIcons.orderListSvg,
                    onTap: () {
                      GoRouter.of(context)
                          .pushNamed(AppRouteConstants.userOrderPage);
                    },
                  ),
                  if (state is GetProfileDataSuccessState &&
                      state.user.phoneNumber == null)
                    TileBarButton(
                        title: 'Verify Phone Number',
                        subtitle:
                            'Verify you phone number to get access to more features',
                        onTap: () {
                          _showPhoneVerificationDialog(context, false);
                        },
                        icon: CustomIcons.phoneOutlined),
                  TileBarButton(
                    title: state is GetProfileDataSuccessState
                        ? state.user.isVendor
                            ? 'Enter Vendor Mode'
                            : 'Start Selling'
                        : 'Please Wait',
                    subtitle: state is GetProfileDataSuccessState
                        ? state.user.isVendor
                            ? 'Start Selling your new Product!'
                            : 'Activate this option to start selling your products as a vendor on our platform.'
                        : 'Please Wait',
                    icon: CustomIcons.cartSvg,
                    onTap: () {
                      if (state is GetProfileDataSuccessState &&
                          state.user.phoneNumber == null) {
                        return _showPhoneVerificationDialog(context, true);
                      }
                      //if the user is vendor we will direct them to vendor else wilill direct him to register page where they will see the status of the vendor status.
                      state is GetProfileDataSuccessState && state.user.isVendor
                          ? GoRouter.of(context)
                              .pushNamed(AppRouteConstants.vendorMainPage)
                          : state is GetProfileDataSuccessState &&
                                  !state.user.isVendor
                              ? GoRouter.of(context).pushNamed(
                                  AppRouteConstants.registerVendorPage,
                                  extra: state.user)
                              : null;
                    },
                  ),
                  // const ProfileHeaderTile(
                  //   title: 'SETTINGS',
                  // ),
                  // const TileBarButton(
                  //   title: 'Country',
                  //   icon: CustomIcons.globeSvg,
                  // ),
                  // const TileBarButton(
                  //   title: 'Language',
                  //   icon: CustomIcons.languageSvg,
                  // ),
                  const ProfileHeaderTile(
                    title: 'REACH OUT TO US',
                  ),
                  TileBarButton(
                    title: 'Help Center',
                    onTap: () {
                      GoRouter.of(context)
                          .pushNamed(AppRouteConstants.helpCenterPage);
                    },
                    icon: CustomIcons.questionMarkSvg,
                  ),
                  const ProfileHeaderTile(
                    title: 'ABOUT US',
                  ),
                  TileBarButton(
                    title: 'About App',
                    onTap: () {
                      GoRouter.of(context)
                          .pushNamed(AppRouteConstants.aboutAppPage);
                    },
                    icon: CustomIcons.exclamationSvg,
                  ),
                  TileBarButton(
                    title: 'Terms And Conditions',
                    onTap: () {
                      GoRouter.of(context)
                          .pushNamed(AppRouteConstants.termsAndConditionsPage);
                    },
                    icon: CustomIcons.fileCheck,
                  ),
                  TileBarButton(
                    title: 'Privacy Policy',
                    onTap: () {
                      GoRouter.of(context)
                          .pushNamed(AppRouteConstants.privacyPolicyPage);
                    },
                    icon: CustomIcons.lockOutlinedSvg,
                  ),

                  TileBarButton(
                    title: 'Sign Out',
                    icon: CustomIcons.rightArrowExitSvg,
                    onTap: () {
                      showConfirmationDialog(context, 'Sign Out',
                          'Are you sure you want to sign out', () async {
                        await FirebaseAuth.instance.signOut();
                        GoogleSignIn googleSignIn = GoogleSignIn();
                        await googleSignIn.signOut();
                        GoRouter.of(context)
                            .goNamed(AppRouteConstants.splashScreen);
                      });
                      // context.read<AuthBloc>().add(SignOutUserEvent());
                    },
                  ),
                  // Row(
                  //   children: [
                  //     Icon(Icons.card_travel),
                  //     Text('data'),
                  //   ],
                  // )
                ],
              );
            },
          ),
        ));
  }
}

ValueNotifier<String> countryCode = ValueNotifier('000');

void _showPhoneVerificationDialog(
    BuildContext context, bool forVendorRegistration) {
  final TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          forVendorRegistration
              ? 'Verify Your Phone Number first to Register for Vendor'
              : 'Verify Phone Number',
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Form(
              key: formKey,
              child: PhoneNumberTextField(
                countryCode: countryCode,
                textFormFieldEnabled: true,
                phoneNumberController: phoneController,
              ),
            )
          ],
        ),
        actions: [
          RoundedRectangularButton(
            title: 'Verify',
            onPressed: () {
              if (formKey.currentState!.validate()) {
                String phoneNumber =
                    '+${countryCode.value}${phoneController.text}';
                // Implement verification logic here
                context.read<ProfileBloc>().add(SendOTPForGoogleLoginEvent(
                      phoneNumber: phoneNumber,
                    ));
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      );
    },
  );
}