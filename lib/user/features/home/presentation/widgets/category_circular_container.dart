import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tech_haven/core/entities/category.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class CategoryCircularContainer extends StatelessWidget {
  const CategoryCircularContainer({super.key, this.category});

  // final String? categoryName;
  // final String? imageURL;
  final Category? category;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        //this is for the whole height of onw of the listview
        (category == null)
            ? Shimmer.fromColors(
                baseColor: Colors.grey.shade100,
                highlightColor: Colors.grey.shade300,
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(0, 92, 90, 197),
                      ),
                      margin: const EdgeInsets.all(5),
                      //
                      child: const Center(
                        child: Text(
                          'Item ',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const Text(
                      'categoryName',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            : InkWell(
                // onTap: () {
                //   GoRouter.of(context).pushNamed(AppRouteConstants.productsPage,
                //       pathParameters: {'searchQuery': category!.id});
                // },
                child: Column(
                  children: [
                    // CachedNetworkImage(
                    //   imageUrl: category!.imageURL,
                    //   imageBuilder: (context, imageProvider) => Container(
                    //     height: 60,
                    //     width: 60,
                    //     clipBehavior: Clip.antiAlias,
                    //     decoration: const BoxDecoration(
                    //       shape: BoxShape.circle,
                    //       color: AppPallete.primaryAppColor,
                    //       // image: DecorationImage(
                    //       //   image: NetworkImage(
                    //       //     category!.imageURL,
                    //       //   ),
                    //       // ),
                    //     ),
                    //     margin: const EdgeInsets.all(5),
                    //   ),
                    //   placeholder: (context, url) =>
                    //     Container(
                    //     height: 60,
                    //     width: 60,
                    //     clipBehavior: Clip.antiAlias,
                    //     decoration: const BoxDecoration(
                    //       shape: BoxShape.circle,
                    //       color: AppPallete.primaryAppColor,
                    //       // image: DecorationImage(
                    //       //   image: NetworkImage(
                    //       //     category!.imageURL,
                    //       //   ),
                    //       // ),
                    //     ),
                    //     margin: const EdgeInsets.all(5),
                    //   ),
                    //   // errorWidget: (context, url, error) =>
                    //   //     const Icon(Icons.error),
                    // ),
                    CachedNetworkImage(
                      imageBuilder: (context, imageProvider) => Container(
                        height: 60,
                        width: 60,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color.fromARGB(58, 0, 0, 0),
                          image: DecorationImage(
                            image: NetworkImage(
                              category!.imageURL,
                            ),
                          ),
                        ),
                        margin: const EdgeInsets.all(5),
                      ),
                      imageUrl: category!.imageURL,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey.shade100,
                        highlightColor: Colors.grey.shade300,
                        child: Container(
                          height: 60,
                          width: 60,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppPallete.primaryAppColor,
                            image: DecorationImage(
                              image: NetworkImage(
                                category!.imageURL,
                              ),
                            ),
                          ),
                          margin: const EdgeInsets.all(5),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    Text(
                      category!.categoryName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

        // (categoryName == null)
        //     ? Shimmer.fromColors(
        //         baseColor: Colors.grey.shade100,
        //         highlightColor: Colors.grey.shade300,
        //         child: Container())
        //     :
      ],
    );
  }
}
