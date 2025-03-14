import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/custom_back_button.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/responsive/responsive.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/user/features/order/presentation/bloc/user_order_page_bloc.dart';
import 'package:tech_haven/core/common/widgets/order_tile.dart';

class UserOrderPage extends StatelessWidget {
  const UserOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    context.read<UserOrderPageBloc>().add(GetAllOrdersForUserEvent());
    // });

    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        leading: Responsive.isMobile(context) ? const CustomBackButton() : null,
        backgroundColor: AppPallete.whiteColor,
        forceMaterialTransparency: true,
        elevation: 0,
        title: const Text('Your Order'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 5,
            ),
            child: InkWell(
                onTap: () {
                  GoRouter.of(context)
                      .pushNamed(AppRouteConstants.userOrderHistoryPage);
                },
                child: const SvgIcon(icon: CustomIcons.clockSvg, radius: 25)),
          )
        ],
      ),
      body: BlocConsumer<UserOrderPageBloc, UserOrderPageState>(
        listener: (context, state) {
          if (state is GetAllOrderListFailed) {
            Fluttertoast.showToast(msg: state.message);
          }
          if (state is UpdateOrderDeliveryFailed) {
            Fluttertoast.showToast(msg: state.message);
          }
          if (state is DeliverOrderToAdminSuccess) {
            context.read<UserOrderPageBloc>().add(GetAllOrdersForUserEvent());
          }
          if (state is DeliverOrderToAdminFailed) {
            Fluttertoast.showToast(msg: state.message);
          }
        },
        builder: (context, state) {
          return state is GetAllOrderListSuccess &&
                  state.listOfOrderDetails.isNotEmpty
              ? ListView.separated(
                  itemCount: state.listOfOrderDetails.length,
                  itemBuilder: (context, index) {
                    return OrderTile(
                      isUser: true,
                      onTap: () {
                        GoRouter.of(context).pushNamed(
                            AppRouteConstants.userOrderDetailsPage,
                            extra: state.listOfOrderDetails[index]);
                      },
                      order: state.listOfOrderDetails[index],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                )
              : state is GetAllOrderListSuccess &&
                      state.listOfOrderDetails.isEmpty
                  ? const Center(
                      child: Text('No Orders Left To Deliver'),
                    )
                  : Shimmer.fromColors(
                      baseColor: Colors.grey.shade100,
                      highlightColor: Colors.grey.shade300,
                      child: Container(),
                    );
        },
      ),
    );
  }
}
