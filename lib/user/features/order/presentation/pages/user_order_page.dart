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
import 'package:tech_haven/user/features/order/presentation/bloc/user_order_page_bloc.dart';
import 'package:tech_haven/core/common/widgets/order_tile.dart';

class UserOrderPage extends StatelessWidget {
  const UserOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Trigger order retrieval when the page loads
    context.read<UserOrderPageBloc>().add(GetAllOrdersForUserEvent());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Responsive.isMobile(context) 
          ? const CustomBackButton() 
          : null,
        title: Text(
          'Your Orders', 
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: InkWell(
              onTap: () {
                GoRouter.of(context)
                    .pushNamed(AppRouteConstants.userOrderHistoryPage);
              },
              child: SvgIcon(
                icon: CustomIcons.clockSvg, 
                radius: 25,
                color: Colors.black87, 
              ),
            ),
          )
        ],
      ),
      body: BlocConsumer<UserOrderPageBloc, UserOrderPageState>(
        listener: (context, state) {
          // Error handling and state management
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
          // Empty state with minimalist design
          if (state is GetAllOrderListSuccess) {
            return state.listOfOrderDetails.isEmpty 
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_bag_outlined, 
                        size: 100, 
                        // ignore: deprecated_member_use
                        color: Colors.black.withOpacity(0.4),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No Orders Yet',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white,
                        Colors.grey.shade50,
                      ],
                    ),
                  ),
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16, 
                      vertical: 20
                    ),
                    itemCount: state.listOfOrderDetails.length,
                    itemBuilder: (context, index) {
                      return OrderTile(
                        isUser: true,
                        onTap: () {
                          GoRouter.of(context).pushNamed(
                            AppRouteConstants.userOrderDetailsPage,
                            extra: state.listOfOrderDetails[index]
                          );
                        },
                        order: state.listOfOrderDetails[index],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        // ignore: deprecated_member_use
                        color: Colors.black.withOpacity(0.1),
                        thickness: 0.5,
                      );
                    },
                  ),
                );
          }
          
          // Loading state with subtle shimmer
          return Center(
            child: Shimmer.fromColors(
              baseColor: Colors.black12,
              highlightColor: Colors.black26,
              child: Container(
                width: 200,
                height: 50,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}