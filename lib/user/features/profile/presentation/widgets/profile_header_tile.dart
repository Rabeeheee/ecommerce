import 'package:flutter/material.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class ProfileHeaderTile extends StatelessWidget {
  const ProfileHeaderTile({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      color: AppPallete.lightgreyColor,
      height: 45,
      width: double.infinity,
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }
}