import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:tech_haven/core/constants/constants.dart';
import 'package:tech_haven/core/rive/rive_assets.dart';
import 'package:tech_haven/core/rive/rive_utils.dart';

class RiveNavUtils {
  static ValueNotifier<RiveAsset> selectedBottomNavUser =
      ValueNotifier(bottonNavs[0].riveAsset);
  static ValueNotifier<String> selectedBottomNavVendor =
      ValueNotifier(Constants.vendorListOfIcons[0]);
  static ValueNotifier<RiveAsset> selectedSideBarBrowser =
      ValueNotifier(browseSideMenus[0].riveAsset);

  static ValueNotifier<int> selectedSideBarTotal = ValueNotifier(0);
  static void animateTheIconForBottom(int index) {
    final riveIcon = bottonNavs[index].riveAsset;
    riveIcon.input?.change(true);
    Future.delayed(const Duration(seconds: 1), () {
      riveIcon.input?.change(false);
    });
    // setState(() {
    selectedBottomNavUser.value = riveIcon;
    // });
  }

  static void animateTheIconForSideMenu(int index) {
    final riveIcon = browseSideMenus[index].riveAsset;
    riveIcon.input?.change(true);
    Future.delayed(const Duration(seconds: 1), () {
      riveIcon.input?.change(false);
    });
    // setState(() {
    selectedSideBarBrowser.value = riveIcon;
    selectedSideBarTotal.value = index;
    // });
  }

  static void riveOnInItForSideMenu(int index, Artboard artboard) {
    final riveIcon = browseSideMenus[index].riveAsset;
    StateMachineController? controller = RiveUtils.getRiveController(artboard,
        stateMachineName: riveIcon.stateMachineName);
    riveIcon.setInput = controller.findInput<bool>('active') as SMIBool;
    riveIcon.input?.change(false);
  }

  static void riveOnInItForBottom(int index, Artboard artboard) {
    final riveIcon = bottonNavs[index].riveAsset;
    StateMachineController? controller = RiveUtils.getRiveController(artboard,
        stateMachineName: riveIcon.stateMachineName);
    riveIcon.setInput = controller.findInput<bool>('active') as SMIBool;
    riveIcon.input?.change(false);
  }
}
