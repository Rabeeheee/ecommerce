// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:tech_haven/core/entities/product.dart';
// import 'package:tech_haven/core/theme/app_pallete.dart';
// import 'package:tech_haven/user/features/details/presentation/bloc/details_page_bloc.dart';

// class AvailableColorHorizontalListView extends StatelessWidget {
//   const AvailableColorHorizontalListView({
//     super.key,
//     required this.product,
//   });

//   final Product product;

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Padding(
//         padding: const EdgeInsets.only(
//           bottom: 5,
//           right: 5,
//           left: 5,
//         ),
//         child: BlocBuilder<DetailsPageBloc, DetailsPageState>(
//           buildWhen: (previous, current) =>
//               current is GetAllImagesForProductState,
//           builder: (context, state) {
//             if (state is GetAllImagesForProductSuccess) {
//               // print('success');
//               return GridView.builder(
//                 // shrinkWrap: true,
//                 scrollDirection: Axis.horizontal,
//                 gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//                   maxCrossAxisExtent: 175,
//                 ),
//                 itemCount: state.allImages.length,
//                 itemBuilder: (context, index) {
//                   final mainImage = state.allImages[index]!.first.imageURL;
//                   return Container(
//                     width: 100,
//                     height: 100,
//                     margin: const EdgeInsets.all(
//                       5,
//                     ),
//                     decoration: BoxDecoration(
//                       borderRadius: const BorderRadius.all(
//                         Radius.circular(
//                           10,
//                         ),
//                       ),
//                       border: Border.all(
//                         color: state.currentSelectedIndex == index
//                             ? AppPallete.primaryAppColor
//                             : AppPallete.darkgreyColor,
//                         width: 2,
//                       ),
//                     ),
//                     child: InkWell(
//                       onTap: () {
//                         // print(index);
//                         context
//                             .read<DetailsPageBloc>()
//                             .add(ChangeProductColorEvent(index: index));
//                       },
//                       child: Center(
//                         child: CachedNetworkImage(
//                           imageUrl: mainImage,
//                           placeholder: (context, url) => Shimmer.fromColors(
//                             baseColor: Colors.grey.shade100,
//                             highlightColor: Colors.grey.shade300,
//                             child: Container(
//                               width: double.infinity,
//                               height: double.infinity,
//                               color: Colors.white,
//                             ),
//                           ),
//                           errorWidget: (context, url, error) =>
//                               const Icon(Icons.error),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             }
//             return GridView.builder(
//               // shrinkWrap: true,
//               scrollDirection: Axis.horizontal,
//               gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//                 maxCrossAxisExtent: 175,
//               ),
//               itemCount: 1,
//               itemBuilder: (context, index) {
//                 final mainImage = product.displayImageURL;
//                 return Container(
//                   width: 100,
//                   height: 100,
//                   margin: const EdgeInsets.all(
//                     5,
//                   ),
//                   decoration: BoxDecoration(
//                     borderRadius: const BorderRadius.all(
//                       Radius.circular(
//                         10,
//                       ),
//                     ),
//                     border: Border.all(
//                       color: AppPallete.darkgreyColor,
//                       width: 2,
//                     ),
//                   ),
//                   child: InkWell(
//                     onTap: () {},
//                     child: Center(
//                       child: Image.network(
//                         mainImage,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
