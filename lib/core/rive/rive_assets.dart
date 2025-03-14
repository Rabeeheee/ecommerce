import 'package:rive/rive.dart';
import 'package:tech_haven/core/common/icons/icons.dart';

class NavItemModel {
  final String title;
  final RiveAsset riveAsset;
  NavItemModel({
    required this.title,
    required this.riveAsset,
  });
}

class ProfileSideItemModel {
  final String title;
  final String icon;

  ProfileSideItemModel({required this.icon, required this.title});
}

class RiveAsset {
  final String src, artboard, stateMachineName, title;
  late SMIBool? input;

  RiveAsset(
    this.src, {
    required this.artboard,
    required this.stateMachineName,
    required this.title,
    this.input,
  });
  set setInput(SMIBool status) {
    input = status;
  }
}

List<NavItemModel> bottonNavs = [
  NavItemModel(
    title: 'Home',
    riveAsset: RiveAsset(
      'assets/rive/animated_icon_set_.riv',
      artboard: 'HOME',
      stateMachineName: 'HOME_Interactivity',
      title: 'Home',
    ),
  ),
  NavItemModel(
    title: 'Search',
    riveAsset: RiveAsset(
      'assets/rive/animated_icon_set_.riv',
      artboard: 'SEARCH',
      stateMachineName: 'SEARCH_Interactivity',
      title: 'Search',
    ),
  ),
  // NavItemModel(
  //   title: 'Notification',
  //   riveAsset: RiveAsset(
  //     'assets/rive/animated_icon_set_.riv',
  //     artboard: 'BELL',
  //     stateMachineName: 'BELL_Interactivity',
  //     title: 'Notification',
  //   ),
  // ),
  NavItemModel(
    title: 'Profile',
    riveAsset: RiveAsset(
      'assets/rive/animated_icon_set_.riv',
      artboard: 'USER',
      stateMachineName: 'USER_Interactivity',
      title: 'Profile',
    ),
  ),
  NavItemModel(
    title: 'Cart',
    riveAsset: RiveAsset(
      'assets/rive/animated_icon_set_.riv',
      artboard: 'CART',
      stateMachineName: 'CART_Interactivity',
      title: 'Cart',
    ),
  )
];

List<NavItemModel> browseSideMenus = [
  NavItemModel(
    title: 'Home',
    riveAsset: RiveAsset(
      'assets/rive/animated_icon_set_.riv',
      artboard: 'HOME',
      stateMachineName: 'HOME_Interactivity',
      title: 'Home',
    ),
  ),
  NavItemModel(
    title: 'Search',
    riveAsset: RiveAsset(
      'assets/rive/animated_icon_set_.riv',
      artboard: 'SEARCH',
      stateMachineName: 'SEARCH_Interactivity',
      title: 'Search',
    ),
  ),
  NavItemModel(
    title: 'Cart',
    riveAsset: RiveAsset(
      'assets/rive/animated_icon_set_.riv',
      artboard: 'CART',
      stateMachineName: 'CART_Interactivity',
      title: 'Cart',
    ),
  )
];
List<ProfileSideItemModel> profileSideMenus = [
  ProfileSideItemModel(
    icon: CustomIcons.orderListSvg,
    title: 'Your Orders',
  ),
  ProfileSideItemModel(
    icon: CustomIcons.phoneOutlined,
    title: 'Verify Phone Number',
  ),
  ProfileSideItemModel(
    icon: CustomIcons.cartSvg,
    title: 'Enter Vendor Mode',
  ),
  ProfileSideItemModel(
    icon: CustomIcons.questionMarkSvg,
    title: 'Help Center',
  ),
     ProfileSideItemModel(
    icon: CustomIcons.fileCheck,
    title: 'Terms and Conditions',
  ),
     ProfileSideItemModel(
    icon: CustomIcons.lockOutlinedSvg,
    title: 'Privacy Policy',
  ),
   ProfileSideItemModel(
    icon: CustomIcons.exclamationSvg,
    title: 'About Us',
  ),
  ProfileSideItemModel(
    icon: CustomIcons.rightArrowExitSvg,
    title: 'Sign Out',
  ),
];
