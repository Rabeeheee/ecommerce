import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/widgets/custom_back_button.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      leading: const CustomBackButton(),
      backgroundColor: AppPallete.whiteColor,
      forceMaterialTransparency: true,
      elevation: 0,
      title: Text(title),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
