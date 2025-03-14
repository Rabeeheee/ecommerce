import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/animated_bar.dart';
import 'package:tech_haven/core/common/widgets/circular_button.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/constants/constants.dart';
import 'package:tech_haven/core/rive/rive_nav_utils.dart';
import 'package:tech_haven/core/common/pages/bottomnav/widgets/bottom_navigation_bar_container.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class VendorBottomNavigationBar extends StatelessWidget {
  const VendorBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          GoRouter.of(context)
              .pushNamed(AppRouteConstants.registerProductPage, extra: null);
        },
        child: const SvgIcon(
          icon: CustomIcons.plusSvg,
          color: AppPallete.whiteColor,
          radius: 20,
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: PageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          itemCount: Constants.listOFVendorPages.length,
          itemBuilder: (context, index) {
            return Constants.listOFVendorPages[index];
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBarContainer(
        children: List.generate(
          Constants.vendorListOfIcons.length,
          (index) {
            // final icon = RiveNavUtils.selectedBottomNavVendor.value;
            return ValueListenableBuilder(
              valueListenable: RiveNavUtils.selectedBottomNavVendor,
              builder: (BuildContext context, value, Widget? child) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedBar(
                      isActive: RiveNavUtils.selectedBottomNavVendor.value ==
                          Constants.vendorListOfIcons[index],
                    ),
                    CircularButton(
                      onPressed: () {
                        RiveNavUtils.selectedBottomNavVendor.value =
                            Constants.vendorListOfIcons[index];
                        pageController.jumpToPage(index);
                      },
                      shadow: false,
                      circularButtonChild: Opacity(
                        opacity: Constants.vendorListOfIcons[index] ==
                                RiveNavUtils.selectedBottomNavVendor.value
                            ? 1
                            : 0.5,
                        child: SvgIcon(
                          icon: Constants.vendorListOfIcons[index],
                          radius: 25,
                          color: AppPallete.whiteColor,
                        ),
                      ),
                      diameter: 45,
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
