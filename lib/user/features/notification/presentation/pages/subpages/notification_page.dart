// import 'package:flutter/material.dart';
// import 'package:tech_haven/core/common/widgets/global_title_text.dart';
// import 'package:tech_haven/core/theme/app_pallete.dart';

// class NotificationPage extends StatelessWidget {
//   const NotificationPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.separated(
//         itemCount: 10,
//         itemBuilder: (context, index) {
//           return Container(
//             decoration: const BoxDecoration(),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 //container for the picture
//                 Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 10),
//                   height: 50,
//                   width: 50,
//                   decoration: const BoxDecoration(
//                       color: Colors.red, shape: BoxShape.circle),
//                 ),
//                 //container for the title and the subtitle
//                 Container(
//                   child: const Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         GlobalTitleText(
//                           title: 'Notification Heading',
//                         ),
//                         Text(
//                           'The standard Lorem Ipsum passage is: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
//                           style: TextStyle(
//                             color: AppPallete.greyTextColor,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//         separatorBuilder: (BuildContext context, int index) {
//           return const Divider();
//         },
//       ),
//     );
//   }
// }
