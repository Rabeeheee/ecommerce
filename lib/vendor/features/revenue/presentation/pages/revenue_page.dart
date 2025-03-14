import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tech_haven/core/common/widgets/custom_drop_down.dart';
import 'package:tech_haven/core/common/widgets/global_title_text.dart';
import 'package:tech_haven/core/constants/constants.dart';
import 'package:tech_haven/core/enum/date_filter.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/core/utils/sum.dart';
import 'package:tech_haven/vendor/core/common/widget/vendor_app_bar.dart';
import 'package:tech_haven/vendor/features/revenue/presentation/bloc/revenue_bloc.dart';
// necessary imports

class MoneyWithdrawalPage extends StatelessWidget {
  const MoneyWithdrawalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('No'),);
    // TextEditingController dateSearchEditingController = TextEditingController();
    // context.read<RevenueBloc>().add(GetRevenueEvent());
    // context
    //     .read<RevenueBloc>()
    //     .add(const GetListOfRevenueDataEvent(dateFilter: DateFilter.thismonth));

    // return SafeArea(
    //   child: Scaffold(
    //     extendBody: true,
    //     resizeToAvoidBottomInset: false,
    //     appBar: const VendorAppBar(
    //       title: 'Profits',
    //       bottom: null,
    //     ),
    //     body: SingleChildScrollView(
    //       child: Column(
    //         children: [
    //           BlocConsumer<RevenueBloc, RevenueState>(
    //             listener: (context, state) {
    //               if (state is GetListOfRevenueDataFailedState) {
    //                 Fluttertoast.showToast(msg: state.message);
    //               }
    //               if (state is GetRevenueFailed) {
    //                 Fluttertoast.showToast(msg: state.message);
    //               }
    //             },
    //             buildWhen: (previous, current) =>
    //                 current is RevenueWholeDataState,
    //             builder: (context, state) {
    //               if (state is GetRevenueSuccess) {
    //                 return Container(
    //                   padding: const EdgeInsets.all(10),
    //                   child: Column(
    //                     children: [
    //                       Container(
    //                         height: 250,
    //                         width: double.infinity,
    //                         decoration: const BoxDecoration(
    //                           color: AppPallete.whiteColor,
    //                           boxShadow: [
    //                             Constants.globalBoxBlur,
    //                           ],
    //                           borderRadius: BorderRadius.all(
    //                             Radius.circular(10),
    //                           ),
    //                         ),
    //                         child: Column(
    //                           children: [
    //                             Expanded(
    //                               child: Column(
    //                                 mainAxisAlignment:
    //                                     MainAxisAlignment.spaceEvenly,
    //                                 children: [
    //                                   const Text(
    //                                     'Overall Profit So Far',
    //                                     style: TextStyle(
    //                                       color: AppPallete.greyTextColor,
    //                                       fontWeight: FontWeight.w600,
    //                                     ),
    //                                   ),
    //                                   Text(
    //                                     'AED${state.revenue.currentBalance}',
    //                                     style: const TextStyle(
    //                                       fontSize: 40,
    //                                       fontWeight: FontWeight.w700,
    //                                     ),
    //                                   ),
    //                                 ],
    //                               ),
    //                             ),
    //                             // Container(
    //                             //   height: 50,
    //                             //   width: double.infinity,
    //                             //   margin: const EdgeInsets.all(8),
    //                             //   child: const RoundedRectangularButton(
    //                             //     title: 'Withdraw Cash',
    //                             //   ),
    //                             // )
    //                           ],
    //                         ),
    //                       ),
    //                       const SizedBox(
    //                         height: 30,
    //                       ),
    //                       // Text(
    //                       //   'Total Earning So Far : AED \$${state.revenue.currentBalance + state.revenue.withdrewAmount}',
    //                       // ),
    //                       // const SizedBox(
    //                       //   height: 20,
    //                       // ),
    //                     ],
    //                   ),
    //                 );
    //               }
    //               return Container(
    //                 alignment: Alignment.center,
    //                 child: const CircularProgressIndicator(),
    //               );
    //             },
    //           ),
    //           BlocBuilder<RevenueBloc, RevenueState>(
    //             buildWhen: (previous, current) =>
    //                 current is GetListOfRevenueDataSuccessState,
    //             builder: (context, state) {
    //               if (state is GetListOfRevenueDataSuccessState) {
    //                 final totalAmount = state.listOfVendorPayment
    //                     .fold<int>(0, (sum, item) => sum + item.totalAmount);

    //                 return Padding(
    //                   padding: const EdgeInsets.all(10),
    //                   child: Column(
    //                     children: [
    //                       Row(
    //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                         children: [
    //                           const GlobalTitleText(
    //                             title: 'Revenue Overview',
    //                           ),
    //                           SizedBox(
    //                             width: 170,
    //                             child: CustomDropDown<DateFilter>(
    //                               searchEditingController: dateSearchEditingController,
    //                               hintText: 'Month',
    //                               items: DateFilter.values,
    //                               currentItem: state.dateFilter,
    //                               onChanged: (value) {
    //                                 context.read<RevenueBloc>().add(
    //                                       GetListOfRevenueDataEvent(
    //                                           dateFilter: value!),
    //                                     );
    //                               },
    //                             ),
    //                           )
    //                         ],
    //                       ),
    //                       Row(
    //                         crossAxisAlignment: CrossAxisAlignment.center,
    //                         mainAxisAlignment: MainAxisAlignment.center,
    //                         children: [
    //                           GlobalTitleText(
    //                               title: state.dateFilter == DateFilter.today
    //                                   ? "Today's : "
    //                                   : state.dateFilter == DateFilter.lastYear
    //                                       ? "Last Year's : "
    //                                       : state.dateFilter ==
    //                                               DateFilter.thismonth
    //                                           ? "This Month's : "
    //                                           : state.dateFilter ==
    //                                                   DateFilter.thisyear
    //                                               ? "This Year's : "
    //                                               : state.dateFilter ==
    //                                                       DateFilter.lastmonth
    //                                                   ? "Last Month's : "
    //                                                   : '',
    //                               fontSize: 15),
    //                           GlobalTitleText(
    //                               title:
    //                                   'AED${changeAmountDecimal(amount: totalAmount)}'),
    //                         ],
    //                       ),
    //                       ListView.separated(
    //                         physics: const NeverScrollableScrollPhysics(),
    //                         shrinkWrap: true,
    //                         itemBuilder: (context, index) {
    //                           final currentPaymentModel =
    //                               state.listOfVendorPayment[index];
    //                           return ListTile(
    //                             style: ListTileStyle.list,
    //                             tileColor:
    //                                 AppPallete.primaryAppColor.withGreen(170),
    //                             title: Text(
    //                                 'Date: ${formatDateTime(currentPaymentModel.dateTime)}'),
    //                             subtitle: Text(
    //                                 'Total Profit: \$${changeAmountDecimal(amount: currentPaymentModel.totalAmount)}'),
    //                           );
    //                         },
    //                         separatorBuilder: (context, index) {
    //                           return const Divider();
    //                         },
    //                         itemCount: state.listOfVendorPayment.length,
    //                       )
    //                     ],
    //                   ),
    //                 );
    //               }
    //               return Shimmer.fromColors(
    //                 baseColor: Colors.grey.shade100,
    //                 highlightColor: Colors.grey.shade300,
    //                 child: Column(
    //                   children: [
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       children: [
    //                         const GlobalTitleText(
    //                           title: 'Revenue Overview',
    //                         ),
    //                         SizedBox(
    //                           width: 170,
    //                           child: CustomDropDown<DateFilter>(
    //                             searchEditingController: dateSearchEditingController,
    //                             hintText: 'Select Date Filter',
    //                             items: DateFilter.values,
    //                             currentItem: DateFilter.thismonth,
    //                             onChanged: (value) {
    //                               context.read<RevenueBloc>().add(
    //                                     GetListOfRevenueDataEvent(
    //                                         dateFilter: value!),
    //                                   );
    //                             },
    //                           ),
    //                         )
    //                       ],
    //                     ),
    //                     const Row(
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       crossAxisAlignment: CrossAxisAlignment.center,
    //                       children: [
    //                         GlobalTitleText(title: 'Monthly : ', fontSize: 15),
    //                         GlobalTitleText(title: '1241'),
    //                       ],
    //                     ),
    //                     ListView.separated(
    //                       physics: const NeverScrollableScrollPhysics(),
    //                       shrinkWrap: true,
    //                       itemBuilder: (context, index) {
    //                         return const ListTile();
    //                       },
    //                       separatorBuilder: (context, index) {
    //                         return const Divider();
    //                       },
    //                       itemCount: 12,
    //                     )
    //                   ],
    //                 ),
    //               );
    //             },
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
