import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/global_title_text.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class ProfileWelcomeText extends StatelessWidget {
  const ProfileWelcomeText({
    super.key,
    required this.name,
    required this.subText,
    required this.imageURL,
    required this.onTapSettingIcon,
    required this.color,
  });

  final String name;
  final int color;
  final String? imageURL;
  final String subText;
  final void Function()? onTapSettingIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      color: AppPallete.lightgreyColor,
      height: 80,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Profile image with shimmer effect or initials
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: imageURL == null ? Color(color) : Colors.transparent,
            ),
            child: ClipOval(
              child: imageURL != null
                  ? Image.network(
                      imageURL!,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: 60.0,
                              height: 60.0,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                          );
                        }
                      },
                    )
                  : Center(
                      child: Text(
                        name.isNotEmpty ? name[0] : '?',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
            ),
          ),
          // Welcome text and subtext
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlobalTitleText(
                    title: 'Hello! $name',
                    fontSize: 15,
                  ),
                  Text(
                    subText,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          // Settings icon
          InkWell(
            onTap: onTapSettingIcon,
            child: const SvgIcon(
              icon: CustomIcons.settingSvg,
              radius: 25,
            ),
          ),
        ],
      ),
    );
  }
}
