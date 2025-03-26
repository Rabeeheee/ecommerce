import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_haven/core/utils/show_snackbar.dart';
import 'package:tech_haven/user/features/home/presentation/bloc/home_page_bloc.dart';
import 'package:tech_haven/user/features/home/presentation/widgets/category_circular_container.dart';

class CategoryIconListView extends StatelessWidget {
  const CategoryIconListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
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
              padding: const EdgeInsets.symmetric(horizontal: 10),
              physics: const AlwaysScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 120,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: state.listOfSubCategories.length,
              itemBuilder: (BuildContext context, int index) {
                return CategoryCircularContainer(
                  category: state.listOfSubCategories[index],
                );
              },
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            physics: const AlwaysScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 120,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
            ),
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            itemBuilder: (BuildContext context, int index) {
              return const CategoryCircularContainer();
            },
          );
        },
      ),
    );
  }
}
