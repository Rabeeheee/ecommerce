import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tech_haven/core/responsive/responsive.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/utils/show_snackbar.dart';
import 'package:tech_haven/user/features/home/presentation/bloc/home_page_bloc.dart';

class CarouselBannerContainer extends StatelessWidget {
  const CarouselBannerContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
            if(state.listOfBanners.isEmpty){
              return SizedBox();
            }
            return CarouselSlider.builder(
              options: _carouselOptions(context),
              itemCount: state.listOfBanners.length,
              itemBuilder: (context, index, realIndex) {
                final banner = state.listOfBanners[index];
                return GestureDetector(
                  onTap: () {
                    context.read<HomePageBloc>().add(
                          BannerProductNavigateEvent(
                            productID: banner.productID,
                          ),
                        );
                  },
                  child: _buildBannerCard(banner.imageURL),
                );
              },
            );
          }
          // Placeholder shimmer while loading
          return CarouselSlider.builder(
            options: _carouselOptions(context),
            itemCount: 5,
            itemBuilder: (context, index, realIndex) {
              return _buildShimmerCard();
            },
          );
        },
      ),
    );
  }

  CarouselOptions _carouselOptions(BuildContext context) {
    return CarouselOptions(
      aspectRatio: 16 / 9,
      viewportFraction: Responsive.isMobile(context)
          ? 0.8
          : Responsive.isTablet(context)
              ? 0.6
              : Responsive.isDesktop(context)
                  ? 0.4
                  : 0.8,
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
      autoPlayInterval: const Duration(seconds: 4),
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      autoPlayCurve: Curves.easeInOut,
    );
  }

  Widget _buildBannerCard(String imageUrl) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image(
                image: imageProvider,
                fit: BoxFit.cover
              ),
              // Gradient overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      // ignore: deprecated_member_use
                      Colors.black.withOpacity(0.4),
                      Colors.transparent,
                      // ignore: deprecated_member_use
                      Colors.black.withOpacity(0.3),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              // Optional: Add a subtle text or icon overlay if needed
              Positioned(
                bottom: 10,
                right: 10,
                child: Icon(Icons.shopping_cart, color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
      placeholder: (context, url) => _buildShimmerCard(),
      errorWidget: (context, url, error) => _buildErrorCard(),
    );
  }

  Widget _buildShimmerCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade100,
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.shade300,
          ),
        ),
      ),
    );
  }

  Widget _buildErrorCard() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 5,
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        'assets/images/banner.jpg',
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    ),
  );
}

}
