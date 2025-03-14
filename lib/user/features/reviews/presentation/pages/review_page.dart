import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/common/widgets/appbar_searchbar.dart';
import 'package:tech_haven/core/common/widgets/review_display_widget.dart';
import 'package:tech_haven/user/features/details/data/models/review_route_model.dart';
import 'package:tech_haven/user/features/reviews/presentation/bloc/review_page_bloc.dart';
// import '../bloc/product_search_bloc.dart';
// import '../bloc/product_search_event.dart';
// import '../bloc/product_search_state.dart';
// import '../../core/common/widgets/appbar_searchbar.dart';
// import '../../domain/entities/product.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key, required this.reviewRouteModel});

  final ReviewRouteModel reviewRouteModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarSearchBar(
        favouriteIconNeeded: false,
        backButton: true,
      ),
      body: SafeArea(
          child: BlocListener<ReviewPageBloc, ReviewPageState>(
        listener: (context, state) {
          // if (state is UpdateHelpfulUsersFailedState) {
          //   context.read<DetailsPageBloc>().add(GetAllReviewOfProductEvent(productID: reviewRouteModel.listOfReview[].productID))
            GoRouter.of(context).pop();
          // }
        },
        child: ListView.separated(
          itemCount: reviewRouteModel.listOfReview.length,
          itemBuilder: (context, index) {
            return ReveiwDisplayWidget(
              reviewModel: reviewRouteModel.listOfReview[index],
              userID: reviewRouteModel.userID,
              onPressed: () {},
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
        ),
      )),
    );
  }
}
