import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/pages/sidemenu/side_menu.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/rive/rive_nav_utils.dart';
import 'package:tech_haven/core/common/widgets/animated_bar.dart';
import 'package:tech_haven/core/common/widgets/circular_button.dart';
import 'package:tech_haven/core/constants/constants.dart';
import 'package:tech_haven/core/common/pages/bottomnav/widgets/bottom_navigation_bar_container.dart';
import 'package:tech_haven/core/responsive/responsive.dart';
import 'package:tech_haven/core/rive/rive_assets.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class UserBottomNavigationBar extends StatefulWidget {
  const UserBottomNavigationBar({super.key});

  @override
  State<UserBottomNavigationBar> createState() =>
      _UserBottomNavigationBarState();
}

class _UserBottomNavigationBarState extends State<UserBottomNavigationBar>
    with SingleTickerProviderStateMixin {
  RiveAsset selectedBottomNav = bottonNavs[0].riveAsset;
  bool isSideMenuOpened = false;
  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(() {
        setState(() {});
      });
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppPallete.primaryAppColor,
        extendBody: true,
        // drawer: (!Responsive.isMobile(context)) ? Container() : null,
        // resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            if (!Responsive.isMobile(context) && isSideMenuOpened)
              AnimatedPositioned(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.fastOutSlowIn,
                  width: 288,
                  left: isSideMenuOpened ? 0 : -288,
                  height: MediaQuery.of(context).size.height,
                  child: const SideMenu()),
            Transform(
              alignment: Alignment.center,
              transform: (!Responsive.isMobile(context))
                  ? (Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(
                        animation.value - 30 * animation.value * pi / 180))
                  : Matrix4.identity(),
              child: Transform.translate(
                offset: (!Responsive.isMobile(context))
                    ? Offset(animation.value * 265, 0)
                    : const Offset(0, 0),
                child: Transform.scale(
                  scale: (!Responsive.isMobile(context))
                      ? scaleAnimation.value
                      : 1,
                  child: ClipRRect(
                    borderRadius:
                        (!Responsive.isMobile(context) && isSideMenuOpened)
                            ? const BorderRadius.all(Radius.circular(24))
                            : BorderRadius.zero,
                    child: PageView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: pageController,
                      itemCount: Responsive.isMobile(context)
                          ? Constants.listOFMainPagesForMobile.length
                          : Constants.listOfMainPagesForTabletAndDesktop.length,
                      // controller: ,
                      itemBuilder: (context, index) {
                        return Responsive.isMobile(context)
                            ? Constants.listOFMainPagesForMobile[index]
                            : ValueListenableBuilder(
                                valueListenable:
                                    RiveNavUtils.selectedSideBarTotal,
                                builder: (context, value, child) {
                                  return Constants
                                          .listOfMainPagesForTabletAndDesktop[
                                      value];
                                });
                      },
                      onPageChanged: (index) {
                        if (Responsive.isMobile(context)) {
                          RiveNavUtils.animateTheIconForBottom(index);
                        } else {
                          RiveNavUtils.animateTheIconForSideMenu(index);
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
            if (!Responsive.isMobile(context))
              AnimatedPositioned(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.fastOutSlowIn,
                  bottom: 50,
                  left: isSideMenuOpened ? 300 : 15,
                  child: CircularButton(
                    diameter: 50,
                    onPressed: () {
                      setState(() {
                        if (isSideMenuOpened) {
                          _animationController.reverse();
                        } else {
                          _animationController.forward();
                        }
                        isSideMenuOpened = !isSideMenuOpened;
                      });
                    },
                    circularButtonChild: SvgIcon(
                      icon: isSideMenuOpened
                          ? CustomIcons.angleLeftSvg
                          : CustomIcons.angleRightSvg,
                      radius: 50,
                    ),
                  ))
          ],
        ),
        bottomNavigationBar: (Responsive.isMobile(context))
            ? BottomNavigationBarContainer(
                children: List.generate(
                  bottonNavs.length,
                  (index) {
                    final riveIcon = bottonNavs[index].riveAsset;
                    return ValueListenableBuilder(
                      valueListenable: RiveNavUtils.selectedBottomNavUser,
                      builder: (BuildContext context, value, Widget? child) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedBar(
                              isActive: riveIcon ==
                                  RiveNavUtils.selectedBottomNavUser.value,
                            ),
                            CircularButton(
                              onPressed: () {
                                RiveNavUtils.animateTheIconForBottom(index);
                                pageController.jumpToPage(index);
                              },
                              shadow: false,
                              circularButtonChild: Opacity(
                                opacity: riveIcon ==
                                        RiveNavUtils.selectedBottomNavUser.value
                                    ? 1
                                    : 0.5,
                                child: RiveAnimation.asset(
                                  riveIcon.src,
                                  artboard: riveIcon.artboard,
                                  onInit: (artboard) {
                                    RiveNavUtils.riveOnInItForBottom(
                                        index, artboard);
                                  },
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
              )
            : null,
      ),
    );
  }
}
