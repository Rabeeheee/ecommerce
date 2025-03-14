import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tech_haven/core/constants/constants.dart';
import 'package:tech_haven/core/responsive/responsive.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/core/utils/show_snackbar.dart';
import 'package:tech_haven/user/features/home/presentation/bloc/home_page_bloc.dart';

class CarouselBannerContainer extends StatelessWidget {
  const CarouselBannerContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 300,
      // margin: const EdgeInsets.all(8),
      // padding: const EdgeInsets.all(8.0),
      child: BlocConsumer<HomePageBloc, HomePageState>(
        buildWhen: (previous, current) => current is BannerCarouselState,
        listener: (context, state) {
          if (state is GetAllBannerHomeFailed) {
            showSnackBar(
              context: context,
              title: 'Oh',
              content: state.message,
              contentType: ContentType.failure,
            );
          }
          if (state is NavigateToDetailsPageSuccess) {
            GoRouter.of(context)
                .pushNamed(AppRouteConstants.detailsPage, extra: state.product);
            context.read<HomePageBloc>().add(GetAllBannerHomeEvent());
          }
          if (state is NavigateToDetailsPageFailed) {
            Fluttertoast.showToast(msg: state.message);
            context.read<HomePageBloc>().add(GetAllBannerHomeEvent());
          }
        },
        builder: (context, state) {
          if (state is GetAllBannerHomeSuccess) {
            // print('success');
            return CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 16 / 9, // Set aspect ratio to 16:9
                viewportFraction: Responsive.isMobile(context)
                    ? 0.8
                    : Responsive.isTablet(context)
                        ? 0.6
                        : Responsive.isDesktop(context)
                            ? 0.4
                            : 0.8, // Set width of carousel items
                enlargeCenterPage: true,
                enlargeFactor: Responsive.isMobile(context)
                    ? 0.3
                    : Responsive.isTablet(context)
                        ? 0.5
                        : Responsive.isDesktop(context)
                            ? 0.7
                            : 0.3,
                enlargeStrategy: CenterPageEnlargeStrategy.scale,
                enableInfiniteScroll: true,
                autoPlay: true,
              ),
              items:
                  //here there must be builder of items from the firebase
                  [
                ...List.generate(state.listOfBanners.length, (index) {
                  return CachedNetworkImage(
                    imageUrl: state.listOfBanners[index].imageURL,
                    imageBuilder: (context, imageProvider) => GestureDetector(
                      onTap: () {
                        context.read<HomePageBloc>().add(
                              BannerProductNavigateEvent(
                                productID: state.listOfBanners[index].productID,
                              ),
                            );
                      },
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        margin: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          color: AppPallete.whiteColor,
                          boxShadow: [Constants.globalBoxBlur],
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Image(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey.shade100,
                      highlightColor: Colors.grey.shade300,
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          color: AppPallete.whiteColor,
                          boxShadow: [Constants.globalBoxBlur],
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      margin: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: AppPallete.whiteColor,
                        boxShadow: [Constants.globalBoxBlur],
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: const Icon(Icons.error),
                    ),
                  );
                }),
              ],
            );
          }
          return CarouselSlider(
            options: CarouselOptions(
                aspectRatio: 16 / 9, // Set aspect ratio to 16:9
                viewportFraction: Responsive.isMobile(context)
                    ? 0.8
                    : Responsive.isTablet(context)
                        ? 0.6
                        : Responsive.isDesktop(context)
                            ? 0.4
                            : 0.8, // Set width of carousel items
                enlargeCenterPage: true,
                enlargeFactor: Responsive.isMobile(context)
                    ? 0.3
                    : Responsive.isTablet(context)
                        ? 0.5
                        : Responsive.isDesktop(context)
                            ? 0.7
                            : 0.3,
                enlargeStrategy: CenterPageEnlargeStrategy.scale,
                enableInfiniteScroll: true,
                autoPlay: true,
              ),
            items:
                //here there must be builder of items from the firebase
                [
              ...List.generate(10, (index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade100,
                  highlightColor: Colors.grey.shade300,
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: AppPallete.whiteColor,
                      boxShadow: [Constants.globalBoxBlur],
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          10,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
