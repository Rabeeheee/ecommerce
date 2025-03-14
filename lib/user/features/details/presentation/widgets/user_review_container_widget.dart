import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tech_haven/core/common/widgets/review_display_widget.dart';
import 'package:tech_haven/core/common/widgets/rounded_rectangular_button.dart';
import 'package:tech_haven/core/common/widgets/star_rating_widget.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/entities/review.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/user/features/details/data/models/review_route_model.dart';
import 'package:tech_haven/user/features/details/presentation/bloc/details_page_bloc.dart';
import 'package:tech_haven/user/features/details/presentation/widgets/star_widget.dart';
import 'package:tech_haven/user/features/review%20enter/data/models/review_enter_route_model.dart';
import '../../../../../core/common/widgets/global_title_text.dart';

class UserReviewContainerWidget extends StatelessWidget {
  const UserReviewContainerWidget({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DetailsPageBloc, DetailsPageState>(
      listener: (context, state) {
        if (state is LoadReviewFailedState) {
          Fluttertoast.showToast(msg: state.message);
        }
        if (state is LoadReviewModelFailedState) {
          Fluttertoast.showToast(msg: state.message);
        }
      },
      buildWhen: (previous, current) => current is LoadReviewsState,
      builder: (context, reviewState) {
        if (reviewState is LoadReviewSuccessState) {
          // print(reviewState.allUserOwnedProducts.length);
          if (reviewState.listOfReviews.isNotEmpty) {
            // print(
            //     (reviewState.allUserOwnedProducts.contains(product.productID)));
            context
                .read<DetailsPageBloc>()
                .add(GetProductReviewEvent(productID: product.productID));
            return Column(
              // physics: const NeverScrollableScrollPhysics(),
              // shrinkWrap: true,
              children: [
                if (reviewState.allUserOwnedProducts
                    .contains(product.productID))
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            GlobalTitleText(title: 'Rate this Product'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: StarRatingWidget(
                                starSize: 20,
                                starSpacing: 20,
                                isForReviewPage: false,
                                onValueChanged: (double newValue) {
                                  GoRouter.of(context).pushNamed(
                                    AppRouteConstants.reviewEnterPage,
                                    extra: ReviewEnterRouteModel(
                                        listOfReview: reviewState.listOfReviews,
                                        product: product,
                                        userRating: newValue),
                                  );
                                  starValueNotifier.value = newValue;
                                  starValueNotifierForReviewPage.value =
                                      newValue;
                                },
                                // valueNotifier: starValueNotifier,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  height: 100,
                  child: BlocBuilder<DetailsPageBloc, DetailsPageState>(
                    buildWhen: (previous, current) =>
                        current is LoadReviewModelState,
                    builder: (context, modelState) {
                      // print(modelState is LoadReviewModelSuccessState);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const GlobalTitleText(
                            title: 'User Reviews',
                          ),
                          Expanded(
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //for the rating
                                Text(
                                  calculateTotalReview(
                                          totalReviews:
                                              reviewState.listOfReviews)
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w700),
                                ),
                                //column for the star and subtext
                                const SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    StarsWidget(
                                        value: calculateTotalReview(
                                            totalReviews:
                                                reviewState.listOfReviews)),
                                    Text(
                                      'Based on ${reviewState.listOfReviews.length} reviews',
                                      style: const TextStyle(
                                        color: AppPallete.greyTextColor,
                                        fontSize: 12,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          const Divider()
                        ],
                      );
                    },
                  ),
                ),
                ReveiwDisplayWidget(
                  reviewModel: reviewState.listOfReviews[0],
                  userID: reviewState.userID,
                ),
                if (reviewState.listOfReviews.length > 1)
                  ReveiwDisplayWidget(
                    reviewModel: reviewState.listOfReviews[1],
                    userID: reviewState.userID,
                  ),
                Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    height: 50,
                    width: double.infinity,
                    child: RoundedRectangularButton(
                      onPressed: () {
                        GoRouter.of(context).pushNamed(
                            AppRouteConstants.fullReviewPage,
                            extra: ReviewRouteModel(
                                listOfReview: reviewState.listOfReviews,
                                userID: reviewState.userID));
                      },
                      title: 'VIEW MORE',
                      outlined: true,
                    )),
                const Divider(),
              ],
            );
          } else {
            return SizedBox(
              width: double.infinity,
              height: 60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Let Your's be the first review for this product",
                  ),
                  if (reviewState.allUserOwnedProducts
                      .contains(product.productID))
                    StarRatingWidget(
                      isForReviewPage: false,
                      onValueChanged: (newValue) {
                        GoRouter.of(context).pushNamed(
                          AppRouteConstants.reviewEnterPage,
                          extra: ReviewEnterRouteModel(
                              listOfReview: reviewState.listOfReviews,
                              product: product,
                              userRating: newValue),
                        );
                        starValueNotifier.value = newValue;
                        starValueNotifierForReviewPage.value = newValue;
                      },
                      // valueNotifier: starValueNotifier,
                    ),
                ],
              ),
            );
          }
        } else if (reviewState is LoadReviewFailedState) {
          return const Center(
              // child: Text('There is no Review for this product Yet'),
              );
        }
        return Shimmer.fromColors(
            baseColor: Colors.grey.shade100,
            highlightColor: Colors.grey.shade300,
            child: Column(
              // physics: const NeverScrollableScrollPhysics(),
              // shrinkWrap: true,
              children: [
                ReveiwDisplayWidget(
                  reviewModel: Review(
                    reviewID: 'reviewID',
                    productID: '',
                    userReview: 'userReview',
                    dateTime: DateTime.now(),
                    userProfile: null,
                    userID: 'userID',
                    listOfHelpFulUsers: [],
                    userName: 'userName',
                    userRating: 5,
                  ),
                  userID: '',
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  height: 100,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GlobalTitleText(
                        title: 'User Reviews',
                      ),
                      Expanded(
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //for the rating
                            Text(
                              '4.5',
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.w700),
                            ),
                            //column for the star and subtext
                            SizedBox(
                              width: 5,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                StarsWidget(
                                  value: 0.0,
                                ),
                                Text(
                                  'Based on 0 reviews',
                                  style: TextStyle(
                                    color: AppPallete.greyTextColor,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Divider()
                    ],
                  ),
                ),
                ReveiwDisplayWidget(
                  reviewModel: Review(
                    reviewID: 'reviewID',
                    productID: '',
                    userReview: 'userReview',
                    dateTime: DateTime.now(),
                    userProfile: null,
                    userID: 'userID',
                    listOfHelpFulUsers: [],
                    userName: 'userName',
                    userRating: 5,
                  ),
                  userID: '',
                ),
                ReveiwDisplayWidget(
                  reviewModel: Review(
                    reviewID: 'reviewID',
                    userReview: 'userReview',
                    dateTime: DateTime.now(),
                    userProfile: null,
                    userID: 'userID',
                    listOfHelpFulUsers: [],
                    productID: '',
                    userName: 'userName',
                    userRating: 5,
                  ),
                  userID: '',
                ),
                Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    height: 50,
                    width: double.infinity,
                    child: const RoundedRectangularButton(
                      title: 'VIEW MORE',
                      outlined: true,
                    )),
                const Divider(),
              ],
            ));
      },
    );
  }

  double calculateTotalReview({required List<Review> totalReviews}) {
    if (totalReviews.isEmpty) return 0;

    double totalRating = 0.0;

    for (var review in totalReviews) {
      totalRating += review.userRating;
    }

    double averageRating = totalRating / totalReviews.length;

    // Ensure the rating is capped at 5
    if (averageRating > 5) {
      averageRating = 5;
    }

    return double.parse(averageRating.toStringAsFixed(1));
  }
}
