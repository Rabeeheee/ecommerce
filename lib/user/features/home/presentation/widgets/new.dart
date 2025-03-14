
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:tech_haven/core/constants/constants.dart';
// import 'package:tech_haven/core/theme/app_pallete.dart';

// class CarouselBannerContainer extends StatelessWidget {
//   const CarouselBannerContainer({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: ConstrainedBox(
//         constraints: const BoxConstraints(
//           minHeight: 275,
//           maxHeight: 410,
//         ),
//         child: CarouselSlider(
//           options: CarouselOptions(
//             aspectRatio: 16 / 9, // Set aspect ratio to 16:9
//             viewportFraction: 0.8, // Set width of carousel items
//             enlargeCenterPage: true,
//             enableInfiniteScroll: true,
//           ),
//           items:
//               //here there must be builder of items from the firebase
//               [
//             Container(
//               decoration: const BoxDecoration(
//                 color: AppPallete.whiteColor,
//                 boxShadow: [Constants.globalBoxBlur],
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(
//                     10,
//                   ),
//                 ),
//                 image: DecorationImage(
//                   image: AssetImage('assets/dev/1619.jpg'),
//                 ),
//               ),
//             ),
//             Container(
//               // width: 480,
//               decoration: const BoxDecoration(
//                 color: AppPallete.whiteColor,
//                 boxShadow: [Constants.globalBoxBlur],
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(
//                     10,
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
