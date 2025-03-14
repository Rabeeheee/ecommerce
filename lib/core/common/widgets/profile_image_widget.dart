import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/widgets/circular_button.dart';
import 'package:tech_haven/core/constants/constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({
    super.key,
    required this.image,
    required this.userColor,
    required this.username,
    this.initialImage,
    required this.onPressed,
  });

  final ValueNotifier<dynamic>
      image; // Change to dynamic to support both File and Uint8List
  final Color userColor;
  final String? initialImage;
  final ValueNotifier<String> username;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                spreadRadius: Constants.globalBoxBlur.spreadRadius,
                blurRadius: Constants.globalBoxBlur.blurRadius,
                color: AppPallete.primaryAppColor,
              ),
            ],
          ),
        ),
        ValueListenableBuilder<dynamic>(
          valueListenable: image,
          builder: (context, value, child) {
            return Container(
              alignment: Alignment.center,
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: userColor,
                image: image.value != null
                    ? image.value is File
                        ? DecorationImage(
                            image: FileImage(image.value),
                            fit: BoxFit.cover,
                          )
                        : DecorationImage(image: MemoryImage(image.value))
                    : (initialImage != null && initialImage!.isNotEmpty)
                        ? DecorationImage(
                            image: NetworkImage(initialImage!),
                            fit: BoxFit.cover,
                          )
                        : null,
              ),
              child: image.value == null &&
                      (initialImage == null || initialImage!.isEmpty)
                  ? ValueListenableBuilder<String>(
                      valueListenable: username,
                      builder: (context, value, child) {
                        return Text(
                          username.value.isNotEmpty
                              ? username.value.substring(0, 1).toUpperCase()
                              : '',
                          style: const TextStyle(
                            fontSize: 100,
                          ),
                        );
                      },
                    )
                  : const SizedBox(),
            );
          },
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: CircularButton(
            onPressed: onPressed,
            circularButtonChild: const Icon(
              Icons.camera_alt,
              color: AppPallete.whiteColor,
            ),
            diameter: 50,
          ),
        ),
      ],
    );
  }
}
