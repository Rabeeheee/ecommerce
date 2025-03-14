// import 'package:flutter/material.dart';
// import 'package:tech_haven/core/theme/app_pallete.dart';
// import 'package:tech_haven/user/features/notification/presentation/pages/subpages/user_chat_page.dart';
// import 'package:tech_haven/user/features/notification/presentation/pages/subpages/notification_page.dart';
// import 'package:tech_haven/user/features/notification/presentation/widgets/tab_text.dart';

// class MainNotificationPage extends StatelessWidget {
//   const MainNotificationPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         bottom: false,
//         child: DefaultTabController(
//           length: 2,
//           child: Scaffold(
//             appBar: AppBar(
//               toolbarHeight: 0,
//               automaticallyImplyLeading: false,
//               bottom: const TabBar(
//                 indicatorWeight: 1,
//                 indicatorPadding: EdgeInsets.only(top: 45),
//                 indicatorSize: TabBarIndicatorSize.tab,
//                 indicator: BoxDecoration(
//                   color: AppPallete.primaryAppButtonColor,
//                 ),
//                 dividerHeight: 0,
//                 tabs: [
                
//                   Tab(
//                     child: TabText(
//                       title: 'Chats',
//                     ),
//                   ),
//                   Tab(
//                     child: TabText(
//                       title: 'Notifications',
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             body: const TabBarView(
//               children: [
//                 UserChatPage(),
//                 NotificationPage(),
//               ],
//             ),
//           ),
//         ));
//   }
// }


