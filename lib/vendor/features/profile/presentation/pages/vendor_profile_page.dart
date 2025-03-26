import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/user/features/profile/presentation/widgets/profile_welcome_text.dart';
import 'package:tech_haven/user/features/profile/presentation/widgets/tile_bar_button.dart';
import 'package:tech_haven/vendor/core/common/widget/vendor_app_bar.dart';
import 'package:tech_haven/vendor/features/profile/presentation/bloc/vendor_profile_bloc.dart';

class VendorProfilePage extends StatelessWidget {
  const VendorProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // return Center(child: Text('No'),);
    context
        .read<VendorProfileBloc>()
        .add(const GetVendorProfileEvent());

    return SafeArea(
      child: Scaffold(
          appBar: const VendorAppBar(
            title: 'Profile',
            bottom: null,
          ),
          body: SingleChildScrollView(
            child: BlocConsumer<VendorProfileBloc, VendorProfileState>(
              listener: (context, state) {
                if (state is VendorProfileError) {
                  Fluttertoast.showToast(msg: state.message);
                }
              },
              builder: (context, state) {
                if (state is VendorProfileLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is VendorProfileLoaded) {
                  return Column(
                    children: [
                      //hello nice to meet you
                      ProfileWelcomeText(
                        color: state.vendor.color,
                        imageURL: state.vendor.businessPicture ??
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/2048px-Default_pfp.svg.png',
                        name: state.vendor.userName,
                        subText: 'Enjoy Selling with Tech Haven',
                        onTapSettingIcon: () {},
                      ),
                      TileBarButton(
                        title: 'Help Center',
                        onTap: () {
                          GoRouter.of(context)
                              .pushNamed(AppRouteConstants.helpCenterPage);
                        },
                        icon: CustomIcons.questionMarkSvg,
                      ),
                    ],
                  );
                } else {
                  return const Center(child: Text('Failed to load profile'));
                }
              },
            ),
          )),
    );
  }
}
