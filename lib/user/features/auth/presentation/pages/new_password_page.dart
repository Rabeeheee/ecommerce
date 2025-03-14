// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:tech_haven/core/routes/app_route_constants.dart';
// import 'package:tech_haven/core/theme/app_pallete.dart';
// import 'package:tech_haven/user/features/auth/presentation/widgets/authentication_container.dart';
// import 'package:tech_haven/core/common/widgets/custom_text_form_field.dart';

// class NewPasswordPage extends StatefulWidget {
//   const NewPasswordPage({super.key});

//   @override
//   State<NewPasswordPage> createState() => _NewPasswordPageState();
// }

// class _NewPasswordPageState extends State<NewPasswordPage> {
//   TextEditingController passwordController = TextEditingController();

//   TextEditingController newPasswordController = TextEditingController();

//   @override
//   void initState() {
//     passwordController.dispose();
//     newPasswordController.dispose();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppPallete.primaryAppColor,
//       body: Stack(
//         alignment: Alignment.bottomCenter,
//         children: [
//           Container(),
//           Positioned(
//             bottom: -50,
//             child: AuthenticationContainer(
//               height: 450,
//               title: 'New Password',
//               subTitle: 'Enter your new Password here',
//               columnChildren: [
//                 CustomTextFormField(
//                   textEditingController: passwordController,
//                   labelText: 'New Password',
//                   hintText: '',
//                   isObscureText: true,
//                 ),
//                 CustomTextFormField(
//                   textEditingController: newPasswordController,
//                   labelText: 'Re-enter New Password',
//                   hintText: '',
//                   isObscureText: true,
//                 )
//               ],
//               buttonNeeded: true,
//               buttonText: 'Confirm',
//               onPressedElevatedButton: () {
//                 GoRouter.of(context)
//                     .pushReplacementNamed(AppRouteConstants.signupWelcomePage);
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
