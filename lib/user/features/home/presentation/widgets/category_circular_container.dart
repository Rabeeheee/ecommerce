import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tech_haven/core/entities/category.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class CategoryCircularContainer extends StatelessWidget {
  const CategoryCircularContainer({super.key, this.category});

  final Category? category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: category == null
          ? null
          : () {
              GoRouter.of(context).pushNamed(
                AppRouteConstants.productsPage,
                pathParameters: {'searchQuery': category!.id},
              );
            },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 5,
              offset: const Offset(0, 3),
            )
          ],
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (category == null)
                ? Shimmer.fromColors(
                    baseColor: Colors.grey.shade100,
                    highlightColor: Colors.grey.shade300,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: AppPallete.primaryAppColor,
                    ),
                  )
                : CachedNetworkImage(
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      radius: 30,
                      backgroundImage: imageProvider,
                    ),
                    imageUrl: category!.imageURL,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey.shade100,
                      highlightColor: Colors.grey.shade300,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: AppPallete.primaryAppColor,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        Image.asset('assets/images/category.jpg',width: 50,height: 50,),
                  ),
            // const SizedBox(height: 8),
            Text(
              category?.categoryName ?? 'Loading',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
