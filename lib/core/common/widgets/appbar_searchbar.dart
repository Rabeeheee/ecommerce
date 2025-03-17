import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/common/bloc/common_bloc.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/custom_back_button.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/core/theme/theme.dart';

class AppBarSearchBar extends StatelessWidget implements PreferredSizeWidget {
  final String hintText;
  final bool favouriteIconNeeded;
  final bool deliveryPlaceNeeded;
  final bool backButton;
  final bool enabled;
  final bool isForSliver;
  final bool autoFocus;
  final void Function(String)? onChanged;
  const AppBarSearchBar({
    super.key,
    this.isForSliver = false,
    this.hintText = 'What are you looking for?',
    this.favouriteIconNeeded = true,
    this.deliveryPlaceNeeded = true,
    this.backButton = false,
    this.enabled = false,
    this.autoFocus = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    context.read<CommonBloc>().add(GetUserLocationDataEvent());

    return SingleChildScrollView(
      child: Container(
        color: isForSliver ? Colors.transparent : Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                if (backButton) const CustomBackButton(),
                if (backButton) const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      GoRouter.of(
                        context,
                      ).pushNamed(AppRouteConstants.searchPage);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: AppPallete.lightgreyColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.search,
                            color: AppPallete.greyTextColor,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              onChanged: onChanged,
                              enabled: enabled,
                              decoration: InputDecoration(
                                hintText: hintText,
                                border: InputBorder.none,
                              ),
                              autofocus: autoFocus,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (favouriteIconNeeded) ...[
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(
                        context,
                      ).pushNamed(AppRouteConstants.favoritePage);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppPallete.lightgreyColor,
                        shape: BoxShape.circle,
                      ),
                      child: const SvgIcon(
                        icon: CustomIcons.heartSvg,
                        radius: 20,
                        color: AppPallete.greyTextColor,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            if (deliveryPlaceNeeded) const SizedBox(height: 10),
            if (deliveryPlaceNeeded)
              GestureDetector(
                onTap: () {
                  GoRouter.of(context).pushNamed(AppRouteConstants.googleMapPage);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppPallete.lightgreyColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: BlocConsumer<CommonBloc, CommonState>(
                    listener: (context, state) {
                      if (state is LocationFailedState) {
                        Fluttertoast.showToast(msg: state.message);
                      }
                    },
                    builder: (context, state) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 1,
                            ), 
                            child: const SvgIcon(
                              icon: CustomIcons.mapPinSvg,
                              radius:
                                  20,
                              color: AppPallete.greyTextColor,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Delivering to:',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppPallete.greyTextColor,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              state is LocationSuccessState &&
                                      state.location != null
                                  ? '${state.location!.location}'
                                  : "Click here to enter your location", overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          const SvgIcon(
                            icon: CustomIcons.chevronDownSvg,
                            radius: 20,
                            color: AppPallete.greyTextColor,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 110);
}
