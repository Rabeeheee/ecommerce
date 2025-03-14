// import 'package:flutter/material.dart';
// import 'package:tech_haven/core/common/icons/icons.dart';
// import 'package:tech_haven/core/common/widgets/circular_button.dart';
// import 'package:tech_haven/core/common/widgets/global_title_text.dart';
// import 'package:tech_haven/core/common/widgets/svg_icon.dart';
// import 'package:tech_haven/core/theme/app_pallete.dart';
// import 'package:tech_haven/core/theme/theme.dart';
// import 'package:tech_haven/user/features/message/presentation/pages/widgets/message_card.dart';

// class MessagePage extends StatelessWidget {
//   const MessagePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // forceMaterialTransparency: true,
//         automaticallyImplyLeading: false,
//         toolbarHeight: 65,
//         leadingWidth: 100,
//         backgroundColor: AppPallete.primaryAppColor,
//         leading: Row(
//           children: [
//             CircularButton(
//               onPressed: () {},
//               color: AppPallete.primaryAppColor,
//               shadow: false,
//               diameter: 50,
//               circularButtonChild: const SvgIcon(
//                 icon: CustomIcons.arrowLeftSvg,
//                 radius: 15,
//               ),
//             ),
//             const CircleAvatar(
//               radius: 25,
//             )
//           ],
//         ),
//         title: const GlobalTitleText(
//           title: 'Name',
//         ),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: 10,
//               itemBuilder: (context, index) {
//                 return const MessageCard();
//               },
//             ),
//           ),
//           Container(
//             height: 50,
//             padding: const EdgeInsets.symmetric(
//               vertical: 5,
//               horizontal: 5,
//             ),
//             decoration: const BoxDecoration(
//               color: Colors.transparent,
//               // borderRadius: BorderRadius.all(
//               //   Radius.circular(
//               //     50,
//               //   ),
//               // ),
//             ),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextFormField(
//                     decoration: AppTheme.inputDecoration.copyWith(
//                       hintText: 'Message',
//                       prefixIcon: GestureDetector(
//                         onTap: () {
//                           //on click the emoji
//                         },
//                         child: const SvgIcon(
//                           icon: CustomIcons.faceGrinSvg,
//                           radius: 15,
//                           color: AppPallete.greyTextColor,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 // const SizedBox(
//                 //   width: 5,
//                 // ),
//                 CircularButton(
//                   onPressed: () {},
//                   circularButtonChild: const SvgIcon(
//                     icon: CustomIcons.microphoneSvg,
//                     radius: 25,
//                   ),
//                   diameter: 55,
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
