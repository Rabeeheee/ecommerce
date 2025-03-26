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
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is GetProfileDataFailedState) {
            Fluttertoast.showToast(msg: state.message);
          }
          if (state is GoToOTPPageState) {
            GoRouter.of(context).pushNamed(
              AppRouteConstants.otpVerificationPage,
              extra: OTPParams(
                phoneNumber: '',
                verificaionID: state.verificationID,
                isForSignUp: false,
              ),
            );
          }
          if (state is FailedToGetVerificationID) {
            Fluttertoast.showToast(msg: state.message);
          }
        },
        buildWhen: (previous, current) => current is GetProfileDataState,
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // Profile welcome card with shadow and border radius
                  Container(
                    margin: const EdgeInsets.only(bottom: 16.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: ProfileWelcomeText(
                        color: state is GetProfileDataSuccessState ? state.user.color : 2345667,
                        imageURL: state is GetProfileDataSuccessState 
                          ? state.user.profilePhoto! 
                          : 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/2048px-Default_pfp.svg.png',
                        name: state is GetProfileDataSuccessState
                          ? state.user.username!
                          : 'Nice to meet you',
                        subText: state is GetProfileDataSuccessState
                          ? 'Enjoy your Tech Journey with Tech Haven'
                          : 'You are currently not signed in',
                        onTapSettingIcon: () {
                          GoRouter.of(context).pushNamed(AppRouteConstants.profileEditPage);
                        },
                      ),
                    ),
                  ),
                  
                  // Your Orders section
                  _buildSectionCard(
                    context,
                    child: TileBarButton(
                      title: 'Your Orders',
                      icon: CustomIcons.orderListSvg,
                      onTap: () {
                        GoRouter.of(context).pushNamed(AppRouteConstants.userOrderPage);
                      },
                    ),
                  ),
                  
                  // Phone verification section if needed
                  if (state is GetProfileDataSuccessState && state.user.phoneNumber == null)
                    _buildSectionCard(
                      context,
                      child: TileBarButton(
                        title: 'Verify Phone Number',
                        subtitle: 'Verify your phone number to get access to more features',
                        onTap: () {
                          _showPhoneVerificationDialog(context, false);
                        },
                        icon: CustomIcons.phoneOutlined,
                      ),
                    ),
                  
                  // Vendor section
                  _buildSectionCard(
                    context,
                    child: TileBarButton(
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
                        if (state is GetProfileDataSuccessState && state.user.phoneNumber == null) {
                          return _showPhoneVerificationDialog(context, true);
                        }
                        state is GetProfileDataSuccessState && state.user.isVendor
                          ? GoRouter.of(context).pushNamed(AppRouteConstants.vendorMainPage)
                          : state is GetProfileDataSuccessState && !state.user.isVendor
                            ? GoRouter.of(context).pushNamed(
                                AppRouteConstants.registerVendorPage,
                                extra: state.user)
                            : null;
                      },
                    ),
                  ),
                  
                  // Support section
                  _buildSectionWithHeader(
                    context,
                    headerTitle: 'REACH OUT TO US',
                    child: TileBarButton(
                      title: 'Help Center',
                      onTap: () {
                        GoRouter.of(context).pushNamed(AppRouteConstants.helpCenterPage);
                      },
                      icon: CustomIcons.questionMarkSvg,
                    ),
                  ),
                  
                  // About Us section
                  _buildSectionWithHeader(
                    context,
                    headerTitle: 'ABOUT US',
                    children: [
                      TileBarButton(
                        title: 'About App',
                        onTap: () {
                          GoRouter.of(context).pushNamed(AppRouteConstants.aboutAppPage);
                        },
                        icon: CustomIcons.exclamationSvg,
                      ),
                      const Divider(height: 1),
                      TileBarButton(
                        title: 'Terms And Conditions',
                        onTap: () {
                          GoRouter.of(context).pushNamed(AppRouteConstants.termsAndConditionsPage);
                        },
                        icon: CustomIcons.fileCheck,
                      ),
                      const Divider(height: 1),
                      TileBarButton(
                        title: 'Privacy Policy',
                        onTap: () {
                          GoRouter.of(context).pushNamed(AppRouteConstants.privacyPolicyPage);
                        },
                        icon: CustomIcons.lockOutlinedSvg,
                      ),
                    ],
                  ),
                  
                  // Sign Out button
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 24.0),
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        showConfirmationDialog(
                          context, 
                          'Sign Out',
                          'Are you sure you want to sign out', 
                          () async {
                            await FirebaseAuth.instance.signOut();
                            GoogleSignIn googleSignIn = GoogleSignIn();
                            await googleSignIn.signOut();
                            GoRouter.of(context).goNamed(AppRouteConstants.splashScreen);
                          }
                        );
                      },
                      icon: Icon(Icons.logout, color: Theme.of(context).colorScheme.error),
                      label: Text(
                        'Sign Out',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        backgroundColor: Theme.of(context).colorScheme.error.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                  ),
                  
                  // Bottom spacing
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  
  // Helper method to build a section card with shadow and border radius
  Widget _buildSectionCard(BuildContext context, {required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: child,
      ),
    );
  }
  
  // Helper method to build a section with header and multiple children
  Widget _buildSectionWithHeader(
    BuildContext context, {
    required String headerTitle,
    Widget? child,
    List<Widget>? children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
          child: Text(
            headerTitle,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: child != null
                ? child
                : Column(
                    children: children ?? [],
                  ),
          ),
        ),
      ],
    );
  }
}

ValueNotifier<String> countryCode = ValueNotifier('000');

void _showPhoneVerificationDialog(BuildContext context, bool forVendorRegistration) {
  final TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 8.0,
        backgroundColor: Theme.of(context).cardColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                forVendorRegistration
                    ? 'Verify Your Phone Number'
                    : 'Verify Phone Number',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              if (forVendorRegistration)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Phone verification is required to register as a vendor',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              Form(
                key: formKey,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
                    ),
                  ),
                  child: PhoneNumberTextField(
                    countryCode: countryCode,
                    textFormFieldEnabled: true,
                    phoneNumberController: phoneController,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  RoundedRectangularButton(
                    title: 'Verify',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        String phoneNumber = '+${countryCode.value}${phoneController.text}';
                        // Implement verification logic here
                        context.read<ProfileBloc>().add(SendOTPForGoogleLoginEvent(
                          phoneNumber: phoneNumber,
                        ));
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}