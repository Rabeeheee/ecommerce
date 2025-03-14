// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:tech_haven/features/profileSet/presentation/pages/sign_up_welcome_page.dart';

// class MyCustomRouteTransition {
//   final Widget route;
//   final GoRouterState state;
//   MyCustomRouteTransition({required this.state, required this.route});
//   final transition = CustomTransitionPage(
//     transitionDuration: const Duration(milliseconds: 5000),
//     key: state.pageKey,
//     child: const SignUpWelcomePage(),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       final tween = Tween(
//         begin: const Offset(0, -1),
//         end: Offset.zero,
//       ).animate(
//         CurvedAnimation(parent: animation, curve: Curves.easeInOut),
//       );
//       return SlideTransition(
//         position: tween,
//         child: child,
//       );
//     },
//   );
// }
