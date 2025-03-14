import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:tech_haven/core/constants/constants.dart';
import 'package:tech_haven/core/responsive/responsive.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:lottie/lottie.dart';
import 'package:tech_haven/user/features/auth/presentation/responsive/responsive_authentication.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.primaryAppColor,
      body: ResponsiveAuthentication(
          mobileLayout: _buildWelcomeMobileLayout(context),
          desktopLayout: _buildWelcomeTabletDesktopLayout(context)),
    );
  }

  Widget _buildWelcomeMobileLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(
          height: 15,
        ),
        Flexible(
          flex: 2,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 415, maxWidth: 415),
            child: Lottie.asset('assets/lotties/e-commerce-first.json'),
          ),
        ),
        Flexible(
          flex: 3,
          child: _buildWelcomeContainer(context),
        ),
      ],
    );
  }

  Widget _buildWelcomeTabletDesktopLayout(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 415, maxWidth: 415),
          child: Lottie.asset('assets/lotties/e-commerce-first.json'),
        ),
        // const Spacer(),
        // Adjust the width to add space between the Lottie and the container
        _buildWelcomeContainer(context),
      ],
    );
  }

  Widget _buildWelcomeContainer(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 450, maxWidth: 415),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: const [Constants.globalBoxBlur],
          color: AppPallete.whiteColor,
          borderRadius: Responsive.isMobile(context)
              ? const BorderRadius.only(
                  topLeft: Radius.circular(45), topRight: Radius.circular(45))
              : const BorderRadius.all(Radius.circular(45)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              FadeIn(
                duration: const Duration(
                  milliseconds: Constants.normalAnimationMilliseconds,
                ),
                curve: Curves.easeIn,
                child: const Text(
                  'Welcome to',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              FadeIn(
                duration: const Duration(
                  milliseconds: Constants.normalAnimationMilliseconds,
                ),
                curve: Curves.easeIn,
                child: const Text(
                  'Tech Haven',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: AppPallete.primaryAppColor,
                  ),
                ),
              ),
              FadeInUp(
                from: 50,
                duration: const Duration(
                  milliseconds: Constants.normalAnimationMilliseconds,
                ),
                curve: Curves.easeOut,
                child: const Text(
                  'Where Tech Enthusiasts Come Together.',
                  style: TextStyle(
                    color: AppPallete.greyTextColor,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppPallete.bordergreyColor,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(45),
                ),
                child: DefaultTabController(
                  length: 2,
                  child: TabBar(
                    onTap: (value) {
                      if (value == 1) {
                        GoRouter.of(context)
                            .pushNamed(AppRouteConstants.signinPage);
                      } else {
                        GoRouter.of(context)
                            .pushNamed(AppRouteConstants.signupPage);
                      }
                    },
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelStyle: const TextStyle(
                      color: AppPallete.whiteColor,
                      fontSize: Constants.buttonTextFontSize,
                      fontWeight: FontWeight.w500,
                    ),
                    unselectedLabelColor: AppPallete.blackColor,
                    indicator: const BoxDecoration(
                      color: AppPallete.primaryAppButtonColor,
                      borderRadius: BorderRadius.all(Radius.circular(45)),
                    ),
                    tabs: const [
                      Tab(text: 'Sign Up'),
                      Tab(text: 'Sign In'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
