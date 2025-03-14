import 'dart:ui';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_haven/core/utils/show_snackbar.dart';
import 'package:tech_haven/user/features/home/presentation/bloc/home_page_bloc.dart';
import 'package:tech_haven/user/features/home/presentation/widgets/category_circular_container.dart';

class CategoryIconListView extends StatelessWidget {
  const CategoryIconListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      alignment: Alignment.center,
      child: BlocConsumer<HomePageBloc, HomePageState>(
        listener: (context, state) {
          if (state is GetAllSubCategoriesFailedState) {
            showSnackBar(
                context: context,
                title: 'Oh',
                content: state.message,
                contentType: ContentType.failure);
          }
        },
        buildWhen: (previous, current) => current is GetAllSubCategoriesState,
        builder: (context, state) {
          if (state is GetAllSubCategoriesSuccessState) {
            return GridView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 100,
              ),
              scrollDirection:
                  Axis.horizontal, // Set scroll direction to horizontal
              itemCount: state.listOfSubCategories.length,
              itemBuilder: (BuildContext context, int index) {
                // final currentSubCategory = state.listOfSubCategories[index];
                //this is the main column which will contain the two list parellel listviews
                return CategoryCircularContainer(
                  category: state.listOfSubCategories[index],
                );
              },
            );
          }
          return ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
  PointerDeviceKind.touch,
  PointerDeviceKind.mouse,
},),
            child: GridView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 100,
              ),
              scrollDirection:
                  Axis.horizontal, // Set scroll direction to horizontal
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                //this is the main column which will contain the two list parellel listviews
                return const CategoryCircularContainer();
              },
            ),
          );
        },
      ),
    );
  }
}
