import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tech_haven/core/common/widgets/loader.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/vendor/features/manageproduct/presentation/bloc/manage_product_bloc.dart';

class UnPublishedPage extends StatelessWidget {
  const UnPublishedPage({super.key, required this.listOfPublishedProduct});
  final List<Product> listOfPublishedProduct;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ManageProductBloc, ManageProductState>(
        builder: (context, state) {
          if (state is ManageProductLoadingState) {
            return const Loader();
          }
          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [],
            body: listOfPublishedProduct.isNotEmpty
                ? ListView.builder(
                    itemCount: listOfPublishedProduct.length,
                    itemBuilder: (context, index) {
                      return Slidable(
                        // enabled:,
                        endActionPane: ActionPane(
                            motion: const StretchMotion(),
                            children: [
                              // SlidableAction(
                              //   onPressed: (context) {},
                              //   backgroundColor: Colors.red,
                              //   foregroundColor: Colors.white,
                              //   icon: Icons.delete,
                              //   label: 'Delete',
                              //   padding: const EdgeInsets.all(
                              //     2,
                              //   ),
                              // ),
                              SlidableAction(
                                onPressed: (context) {
                                  context.read<ManageProductBloc>().add(
                                        UpdateTheProductPublishEvent(
                                          product:
                                              listOfPublishedProduct[index],
                                          publish: true,
                                        ),
                                      );
                                },
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                icon: Icons.publish_rounded,
                                label: 'Publish',
                                padding: const EdgeInsets.all(
                                  2,
                                ),
                              ),
                            ]),
                        child: ListTile(
                          leading: Container(
                              height: 50,
                              width: 50,
                              decoration: const BoxDecoration(
                                color: AppPallete.darkgreyColor,
                              ),
                              child: CachedNetworkImage(
                                imageUrl: listOfPublishedProduct[index]
                                    .displayImageURL,
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
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
                                fit: BoxFit
                                    .contain, // Adjust this based on your requirement
                              )),
                          title: Text(listOfPublishedProduct[index].name),
                          subtitle:
                              Text('AED${listOfPublishedProduct[index].prize}'),
                          // trailing:
                          onTap: () {
                            GoRouter.of(context).pushNamed(
                                AppRouteConstants.registerProductPage,
                                extra: listOfPublishedProduct[index]);
                          },
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text("Your Unpublished Products are empty"),
                  ),
          );
        },
      ),
    );
  }
}
