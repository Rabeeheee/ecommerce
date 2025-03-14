import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
// import 'package:tech_haven/core/common/icons/icons.dart';
// import 'package:tech_haven/core/common/widgets/svg_icon.dart';
// import 'package:tech_haven/core/constants/constants.dart';
// import 'package:tech_haven/core/theme/app_pallete.dart';

// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:shimmer/shimmer.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.name,
    required this.email,
    required this.imageURL,
    required this.onTapSettingIcon,
    required this.userColor,
  });

  final String name;
  final String email;
  final String? imageURL;
  final void Function()? onTapSettingIcon;
  final int userColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: imageURL != null
          ? Container(
              clipBehavior: Clip.antiAlias,
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: CachedNetworkImage(
                imageUrl: imageURL!,
                imageBuilder: (context, imageProvider) => Image(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey.shade100,
                  highlightColor: Colors.grey.shade300,
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 1,
                          blurRadius: 5,
                          color: Colors.black12,
                        )
                      ],
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Color(userColor),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  name.isNotEmpty ? name[0] : '',
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
              ),
            )
          : Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Color(userColor),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  name.isNotEmpty ? name[0] : '',
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
      title: Text(
        name,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      subtitle: Text(
        email,
        style: const TextStyle(
          color: Colors.white70,
        ),
      ),
      trailing: InkWell(
        onTap: onTapSettingIcon,
        child: const Icon(
          Icons.settings,
          color: Colors.white,
          size: 25,
        ),
      ),
    );
  }
}
