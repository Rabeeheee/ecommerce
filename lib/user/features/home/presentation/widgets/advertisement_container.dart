import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tech_haven/core/entities/trending_product.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/user/features/home/presentation/bloc/home_page_bloc.dart';

class AdvertisementContainer extends StatelessWidget {
  final TrendingProduct? trendingProduct;

  const AdvertisementContainer({super.key, required this.trendingProduct});

  @override
  Widget build(BuildContext context) {
    return trendingProduct != null
        ? AdvertisementCard(trendingProduct: trendingProduct!)
        : Shimmer.fromColors(
          baseColor: Colors.grey.shade100,
          highlightColor: Colors.grey.shade300,
          child: AdvertisementCard(trendingProduct: trendingProduct),
        );
  }
}

class AdvertisementCard extends StatelessWidget {
  const AdvertisementCard({super.key, required this.trendingProduct});

  final TrendingProduct? trendingProduct;

  @override
  Widget build(BuildContext context) {
    return trendingProduct != null
        ? Container(
          height: 170,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 0, 0, 0),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          trendingProduct!.trendingText,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          trendingProduct!.productName,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    BlocListener<HomePageBloc, HomePageState>(
                      listenWhen:
                          (previous, current) =>
                              current is GetTrendingProductState,
                      listener: (context, state) {
                        if (state is GetProductForAdvertisementSuccess) {
                          GoRouter.of(context).pushNamed(
                            AppRouteConstants.detailsPage,
                            extra: state.product,
                          );
                        }
                        if (state is GetProductForAdvertisementFailed) {
                          Fluttertoast.showToast(msg: state.message);
                        }
                      },
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          context.read<HomePageBloc>().add(
                            GetProductForAdvertisement(
                              productID: trendingProduct!.productID,
                            ),
                          );
                        },
                        child: const Text(
                          'Order Now',
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 140,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Background circle gradient
                      ClipOval(
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color.fromARGB(0, 255, 255, 255),
                                AppPallete.gradient1,
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Blur effect
                      ClipOval(
                        child: SizedBox(
                          width: 130,
                          height: 130,
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                            child: Container(color: Colors.transparent),
                          ),
                        ),
                      ),
                      // Product image
                      // Product image
                      ClipOval(
                        child: CachedNetworkImage(
                          imageUrl:
                              trendingProduct!.productImageURL,
                          imageBuilder: (context, imageProvider) {
                            if (kDebugMode) {
                              print(
                              "Image loaded successfully: ${trendingProduct!.productImageURL}",
                            );
                            }
                            
                            return Image(
                              image: imageProvider,
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            );
                          },
                          placeholder: (context, url) {
                            if (kDebugMode) {
                              print("Loading image: $url");
                            }
                            if (kDebugMode) {
                              print("Final Image URL: ${Uri.encodeFull(trendingProduct!.productImageURL)}");
                            }

                            return Shimmer.fromColors(
                              baseColor: Colors.grey.shade100,
                              highlightColor: Colors.grey.shade300,
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                color: Colors.white,
                              ),
                            );
                          },
                          errorWidget: (context, url, error) {
                            if (kDebugMode) {
                              print("Error loading image: $url, Error: $error");
                            }
                            return Image.asset('assets/images/trending.jpg', fit: BoxFit.cover,);
                          },
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
        : Container(height: 170);
  }
}
