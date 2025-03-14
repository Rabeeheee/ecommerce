import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tech_haven/core/entities/trending_product.dart';
import 'package:tech_haven/core/responsive/responsive.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/user/features/home/presentation/bloc/home_page_bloc.dart';

class AdvertisementContainer extends StatelessWidget {
  final TrendingProduct? trendingProduct;

  const AdvertisementContainer({super.key, required this.trendingProduct});

  // final Color _dominantColor = Colors.blue;

  // @override
  @override
  Widget build(BuildContext context) {
    return trendingProduct != null
        ? AdvertisementCard(
            trendingProduct: trendingProduct!,
          )
        : Shimmer.fromColors(
            baseColor: Colors.grey.shade100,
            highlightColor: Colors.grey.shade300,
            child: AdvertisementCard(
              trendingProduct: trendingProduct,
            ));
  }
}

class AdvertisementCard extends StatelessWidget {
  const AdvertisementCard({
    super.key,
    required this.trendingProduct,
  });

  final TrendingProduct? trendingProduct;

  @override
  Widget build(BuildContext context) {
    return trendingProduct != null
        ? Container(
            height: 150,
            decoration: BoxDecoration(
                color: AppPallete.primaryAppColor,
                borderRadius: Responsive.isMobile(context)
                    ? const BorderRadius.all(Radius.zero)
                    : BorderRadius.circular(10)),
            // width: 50,
            padding: const EdgeInsets.all(10),
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
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              overflow: TextOverflow.fade,
                            ),
                            softWrap: true,
                          ),
                          Text(
                            trendingProduct!.productName,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                            ),
                            // overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                        ],
                      ),
                      BlocListener<HomePageBloc, HomePageState>(
                        listenWhen: (previous, current) =>
                            current is GetTrendingProductState,
                        listener: (context, state) {
                          if (state is GetProductForAdvertisementSuccess) {
                            GoRouter.of(context).pushNamed(
                                AppRouteConstants.detailsPage,
                                extra: state.product);
                            // context
                            //     .read<HomePageBloc>()
                            //     .add(GetNowTrendingProductEvent());
                          }
                          if (state is GetProductForAdvertisementFailed) {
                            Fluttertoast.showToast(msg: state.message);
                          }
                        },
                        child: SizedBox(
                          height: 30,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              context.read<HomePageBloc>().add(
                                  GetProductForAdvertisement(
                                      productID: trendingProduct!.productID));
                            },
                            child: const Text(
                              'Order Now',
                              style: TextStyle(
                                  color: AppPallete.primaryAppButtonColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 150,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipOval(
                          child: Container(
                            height: 120,
                            width: 120,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  AppPallete.gradient2,
                                  AppPallete.gradient1,
                                ],
                              ),
                            ),
                          ),
                        ),
                        ClipOval(
                          child: SizedBox(
                            width: 150,
                            height: 150,
                            child: Stack(
                              children: [
                                //blur effect
                                BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 3,
                                    sigmaY: 3,
                                  ),
                                  child: Container(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        CachedNetworkImage(
                          imageUrl: trendingProduct!.productImageURL,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey.shade100,
                            highlightColor: Colors.grey.shade300,
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              color: Colors.white,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container(
            height: 150,
          );
  }
}
