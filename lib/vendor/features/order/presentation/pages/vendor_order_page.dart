import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/common/widgets/order_tile.dart';
import 'package:tech_haven/vendor/core/common/widget/vendor_app_bar.dart';
import 'package:tech_haven/vendor/features/order/presentation/bloc/vendor_order_page_bloc.dart';

class VendorOrderPage extends StatelessWidget {
  const VendorOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('No'),);
    // // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    // context.read<VendorOrderPageBloc>().add(GetAllOrdersForVendorEvent());
    // // });
    // return Scaffold(
    //   resizeToAvoidBottomInset: true,
    //   extendBody: true,
    //   extendBodyBehindAppBar: true,
    //   appBar: const VendorAppBar(title: 'Your Order', bottom: null),
    //   body: BlocConsumer<VendorOrderPageBloc, VendorOrderPageState>(
    //     listener: (context, state) {
    //       if (state is GetAllOrderListFailed) {
    //         Fluttertoast.showToast(msg: state.message);
    //       }
    //       if (state is UpdateOrderDeliveryFailed) {
    //         Fluttertoast.showToast(msg: state.message);
    //       }
    //       if (state is DeliverOrderToAdminSuccess) {
    //         context
    //             .read<VendorOrderPageBloc>()
    //             .add(GetAllOrdersForVendorEvent());
    //       }
    //       if (state is DeliverOrderToAdminFailed) {
    //         Fluttertoast.showToast(msg: state.message);
    //       }
    //     },
    //     builder: (context, state) {
    //       return state is GetAllOrderListSuccess
    //           ? state.listOfOrderDetails.isNotEmpty
    //               ? ListView.separated(
    //                   itemCount: state.listOfOrderDetails.length,
    //                   itemBuilder: (context, index) {
    //                     return OrderTile(
    //                       onPressedDeliverButton: () {
    //                         context.read<VendorOrderPageBloc>().add(
    //                               DeliverOrderToAdminEvent(
    //                                 order: state.listOfOrderDetails[index],
    //                               ),
    //                             );
    //                       },
    //                       isUser: false,
    //                       onTap: () {
    //                         GoRouter.of(context).pushNamed(
    //                             AppRouteConstants.vendorOrderDetailsPage,
    //                             extra: state.listOfOrderDetails[index]);
    //                       },
    //                       order: state.listOfOrderDetails[index],
    //                     );
    //                   },
    //                   separatorBuilder: (BuildContext context, int index) {
    //                     return const SizedBox(
    //                       height: 10,
    //                     );
    //                   },
    //                 )
    //               : const Center(
    //                   child: Text("You don't have any order"),
    //                 )
    //           : Shimmer.fromColors(
    //               baseColor: Colors.grey.shade100,
    //               highlightColor: Colors.grey.shade300,
    //               child: Container(),
    //             );
    //     },
    //   ),
    // );
  }
}
