import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
      fontFamily: 'BeVietnamPro',

      // brightness: Brightness.light,
      primaryColor: AppPallete.primaryAppColor,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppPallete.primaryAppButtonColor),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor:
              WidgetStateProperty.all<Color>(AppPallete.primaryAppButtonColor),
        ),
      ),
      scaffoldBackgroundColor: AppPallete.backgroundColor

      // bottomSheetTheme: const BottomSheetThemeData(
      //   showDragHandle: true,
      //   elevation: 0,
      //   modalElevation: 0,
      //   backgroundColor: Colors.transparent,
      //   modalBackgroundColor: Colors.transparent,
      //   dragHandleSize: Size(
      //     double.maxFinite,
      //     20,
      //   ),
      //   // constraints: BoxConstraints(maxHeight: 30, minHeight: 20),
      //   shape: BeveledRectangleBorder(
      //     borderRadius: BorderRadius.all(
      //       Radius.circular(
      //         0,
      //       ),
      //     ),
      //   ),
      // ),
      // iconButtonTheme: IconButtonThemeData(
      //   style: ButtonStyle(
      //     backgroundColor: MaterialStateProperty.all<Color>(
      //         AppPallete.primaryAppButtonColor),
      //   ),
      // )
      // inputDecorationTheme: InputDecorationTheme(
      //   border: OutlineInputBorder(
      //       borderRadius: BorderRadius.circular(20.0),
      //       borderSide: BorderSide.none),
      //   filled: true,
      //   fillColor: Colors.grey.withOpacity(
      //     0.1,
      //   ),
      // ),
      );

  static var inputDecoration = InputDecoration(
    filled: true,
    fillColor: AppPallete.whiteColor,
    contentPadding: const EdgeInsets.only(top: 10),
    prefixIcon: SvgPicture.asset(
      CustomIcons.searchSvg,
      theme: const SvgTheme(
        currentColor: AppPallete.greyTextColor,
      ),
      fit: BoxFit.scaleDown,
      height: 50,
    ),
    hintText: 'Search Chats',
    hintStyle: const TextStyle(color: AppPallete.greyTextColor),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
      borderSide: BorderSide(
        color: AppPallete.borderColor,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
      fontFamily: 'BeVietnamPro',

      // brightness: Brightness.light,
      primaryColor: AppPallete.primaryAppColor,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppPallete.primaryAppButtonColor),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor:
              WidgetStateProperty.all<Color>(AppPallete.primaryAppButtonColor),
        ),
      ),
      scaffoldBackgroundColor: AppPallete.backgroundColor,
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          backgroundColor:
              WidgetStateProperty.all<Color>(AppPallete.primaryAppButtonColor),
        ),
      )

      // inputDecorationTheme: InputDecorationTheme(
      //   border: OutlineInputBorder(
      //       borderRadius: BorderRadius.circular(20.0),
      //       borderSide: BorderSide.none),
      //   filled: true,
      //   fillColor: Colors.grey.withOpacity(
      //     0.1,
      //   ),
      // ),
      );
}
