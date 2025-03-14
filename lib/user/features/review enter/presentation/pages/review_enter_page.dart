import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/common/widgets/custom_app_bar.dart';
import 'package:tech_haven/core/common/widgets/rounded_rectangular_button.dart';
import 'package:tech_haven/core/common/widgets/star_rating_widget.dart';
import 'package:tech_haven/user/features/review%20enter/data/models/review_enter_route_model.dart';
import 'package:tech_haven/user/features/review%20enter/presentation/bloc/review_enter_page_bloc.dart';

class ReviewEnterPage extends StatefulWidget {
  const ReviewEnterPage({super.key, required this.reviewRouteModel});

  final ReviewEnterRouteModel reviewRouteModel;
  // final Product product;

  @override
  State<ReviewEnterPage> createState() => _ReviewEnterPageState();
}

class _ReviewEnterPageState extends State<ReviewEnterPage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppBar(title: 'Rate ${widget.reviewRouteModel.product.name}'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Rate the product:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8.0),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              StarRatingWidget(
                isForReviewPage: true,
                starSize: 22,
                starSpacing: 15,
                onValueChanged: (newValue) {
                  starValueNotifier.value = newValue;
                  starValueNotifierForReviewPage.value = newValue;
                },
              ),
            ]),
            const SizedBox(height: 16.0),
            const Text(
              'Write your review:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: SingleChildScrollView(
                child: BlocConsumer<ReviewEnterPageBloc, ReviewEnterPageState>(
                  listener: (context, state) {
                    if (state is ReviewEnterPageSuccess) {
                      GoRouter.of(context).pop();
                    }
                  },
                  builder: (context, state) {
                    return TextField(
                      enabled: state is! ReviewEnterPageLoading,
                      controller: _controller,
                      maxLines: null,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Type your review here',
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            BlocBuilder<ReviewEnterPageBloc, ReviewEnterPageState>(
              builder: (context, state) {
                return RoundedRectangularButton(
                  isLoading: state is ReviewEnterPageLoading,
                  // title: '',
                  title: 'Submit Review',
                  onPressed: () {
                    if (_controller.text.isNotEmpty &&
                        (starValueNotifier.value > 0 ||
                            starValueNotifierForReviewPage.value > 0)) {
                      context.read<ReviewEnterPageBloc>().add(AddReviewEvent(
                            listOfReviews: widget.reviewRouteModel.listOfReview,
                            userRating: starValueNotifier.value,
                            userReview: _controller.text,
                            product: widget.reviewRouteModel.product,
                          ));
                    } else {
                      Fluttertoast.showToast(
                        msg: 'Please Enter Your Review about this product',
                      );
                    }
                  },
                );
              },
            )
            // ElevatedButton(/
          ],
        ),
      ),
    );
  }
}
