import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tech_haven/core/common/widgets/appbar_searchbar.dart';
import 'package:tech_haven/core/common/widgets/global_title_text.dart';
import 'package:tech_haven/core/common/widgets/loader.dart';
import 'package:tech_haven/core/responsive/responsive.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/core/utils/show_snackbar.dart';
import 'package:tech_haven/user/features/searchcategory/presentation/bloc/search_category_bloc.dart';
import 'package:tech_haven/user/features/searchcategory/presentation/cubit/search_category_cubit.dart';

class SearchCategoryPage extends StatelessWidget {
  const SearchCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SearchCategoryCubit>().changeIndex(0);
    PageController pageController = PageController();
    
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!SearchCategoryBloc.isDataLoaded) {
        // If data is not loaded and not loading, fetch the data
        BlocProvider.of<SearchCategoryBloc>(context)
            .add(const GetAllSearchCategoryEvent(refreshPage: false));
      }
    });
    
    return SafeArea(
      bottom: false,
      child: Scaffold(
        extendBody: true,
        appBar: const AppBarSearchBar(),
        body: BlocConsumer<SearchCategoryBloc, SearchCategoryState>(
          listener: (context, blocState) {
            if (blocState is SearchCategoryAllCategoryLoadedFailed) {
              showSnackBar(
                  context: context,
                  title: 'Oh',
                  content: blocState.message,
                  contentType: ContentType.failure);
            }
          },
          builder: (context, blocState) {
            if (blocState is SearchCategoryLoading) {
              return const Center(child: Loader());
            }
            if (blocState is! SearchCategoryAllCategoryLoadedSuccess) {
              return const Center(
                child: Text(
                  'Ready to explore categories?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }
            final mainCategoryModel = blocState.allCategoryModel;

            return BlocBuilder<SearchCategoryCubit, int>(
              builder: (context, pageIndex) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left sidebar categories menu
                    Container(
                      width: Responsive.isMobile(context) ? 120 : 200,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        color: AppPallete.darkgreyColor.withOpacity(0.5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListView.builder(
                        primary: true,
                        itemCount: mainCategoryModel.length,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemBuilder: (context, listTileindex) {
                          final isSelected = listTileindex == pageIndex;
                          return Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 2, 
                              horizontal: 8,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppPallete.lightgreyColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ]
                                  : null,
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, 
                                vertical: 4,
                              ),
                              leading: Container(
                                width: 4,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color.fromARGB(255, 0, 0, 0)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              onTap: () {
                                context
                                    .read<SearchCategoryCubit>()
                                    .changeIndex(listTileindex);
                                pageController.animateToPage(listTileindex,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut);
                              },
                              splashColor: AppPallete.primaryAppColor.withOpacity(0.3),
                              horizontalTitleGap: 8,
                              titleAlignment: ListTileTitleAlignment.center,
                              title: Text(
                                mainCategoryModel[listTileindex].categoryName,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                  color: isSelected 
                                      ? const Color.fromARGB(255, 0, 0, 0)
                                      : null,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                softWrap: true,
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    // Right content area
                    Expanded(
                      child: BlocBuilder<SearchCategoryCubit, int>(
                        builder: (context, indexState) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                              ),
                              child: PageView.builder(
                                controller: pageController,
                                onPageChanged: (value) {
                                  context
                                      .read<SearchCategoryCubit>()
                                      .changeIndex(value);
                                },
                                itemCount: mainCategoryModel.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, mainPageIndex) {
                                  final subCategoryModel =
                                      mainCategoryModel[mainPageIndex]
                                          .subCategories;
                                  return SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // Category Title
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 16),
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 24,
                                                  width: 4,
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromARGB(255, 0, 0, 0),
                                                    borderRadius: BorderRadius.circular(2),
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                GlobalTitleText(
                                                  title: mainCategoryModel[mainPageIndex]
                                                      .categoryName,
                                                  fontSize: 18,
                                                ),
                                              ],
                                            ),
                                          ),
                                          
                                          // Main Category Image
                                          Container(
                                            margin: const EdgeInsets.only(bottom: 20),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(16),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black.withOpacity(0.1),
                                                  blurRadius: 10,
                                                  offset: const Offset(0, 4),
                                                ),
                                              ],
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(16),
                                              child: ConstrainedBox(
                                                constraints:
                                                    const BoxConstraints(maxHeight: 300),
                                                child: AspectRatio(
                                                  aspectRatio: 16 / 9,
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        mainCategoryModel[mainPageIndex]
                                                            .imageURL,
                                                    fit: BoxFit.cover,
                                                    placeholder: (context, url) =>
                                                        Shimmer.fromColors(
                                                      baseColor: Colors.grey.shade100,
                                                      highlightColor:
                                                          Colors.grey.shade300,
                                                      child: Container(
                                                        width: double.infinity,
                                                        height: double.infinity,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Container(
                                                              color: AppPallete.lightgreyColor,
                                                              child: const Center(
                                                                child: Icon(
                                                                  Icons.error_outline,
                                                                  size: 40,
                                                                  color: Colors.red,
                                                                ),
                                                              ),
                                                            ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          
                                          // Subcategories Accordion
                                          BlocBuilder<SearchCategoryAccordionCubit,
                                              int>(
                                            builder: (context, state) {
                                              return ListView.separated(
                                                itemCount: subCategoryModel.length,
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                separatorBuilder: (context, index) => 
                                                    const SizedBox(height: 8),
                                                itemBuilder: (context, accordionIndex) {
                                                  final variantCategoryModel =
                                                      subCategoryModel[accordionIndex]
                                                          .subCategories;
                                                  final isOpen = state == accordionIndex &&
                                                      mainPageIndex == pageIndex;
                                                          
                                                  return Container(
                                                    margin: const EdgeInsets.only(bottom: 8),
                                                    decoration: BoxDecoration(
                                                      color: isOpen 
                                                          ? AppPallete.lightgreyColor.withOpacity(0.3) 
                                                          : Colors.white,
                                                      borderRadius: BorderRadius.circular(12),
                                                      border: Border.all(
                                                        color: isOpen 
                                                            ? const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5) 
                                                            : Colors.grey.withOpacity(0.2),
                                                        width: 1,
                                                      ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black.withOpacity(0.05),
                                                          blurRadius: 5,
                                                          offset: const Offset(0, 2),
                                                        ),
                                                      ],
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(12),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment.start,
                                                        children: [
                                                          // Accordion header
                                                          InkWell(
                                                            splashColor:
                                                                AppPallete.lightgreyColor,
                                                            onTap: () {
                                                              context
                                                                  .read<
                                                                      SearchCategoryAccordionCubit>()
                                                                  .changeAccordionIndex(
                                                                      accordionIndex);
                                                            },
                                                            child: Padding(
                                                              padding: const EdgeInsets.symmetric(
                                                                vertical: 12, 
                                                                horizontal: 16,
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Container(
                                                                        height: 12,
                                                                        width: 4,
                                                                        decoration: BoxDecoration(
                                                                          color: isOpen
                                                                              ? const Color.fromARGB(255, 0, 0, 0)
                                                                              : Colors.grey.withOpacity(0.5),
                                                                          borderRadius: BorderRadius.circular(2),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(width: 8),
                                                                      Text(
                                                                        subCategoryModel[accordionIndex].categoryName,
                                                                        style: TextStyle(
                                                                          fontSize: 14,
                                                                          fontWeight: isOpen ? FontWeight.w600 : FontWeight.w500,
                                                                          color: isOpen ? const Color.fromARGB(255, 0, 0, 0) : null,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  AnimatedContainer(
                                                                    duration: const Duration(milliseconds: 300),
                                                                    decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: isOpen 
                                                                          ? const Color.fromARGB(255, 0, 0, 0).withOpacity(0.1) 
                                                                          : Colors.transparent,
                                                                    ),
                                                                    padding: const EdgeInsets.all(4),
                                                                    child: Icon(
                                                                      isOpen
                                                                          ? Icons.keyboard_arrow_up_rounded
                                                                          : Icons.keyboard_arrow_down_rounded,
                                                                      color: isOpen ? const Color.fromARGB(255, 0, 0, 0) : Colors.grey,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          
                                                          // Accordion content - grid items
                                                          if (isOpen)
                                                            AnimatedContainer(
                                                              duration: const Duration(milliseconds: 300),
                                                              padding: const EdgeInsets.only(
                                                                left: 16, 
                                                                right: 16, 
                                                                bottom: 16,
                                                              ),
                                                              child: GridView.builder(
                                                                shrinkWrap: true,
                                                                physics:
                                                                    const NeverScrollableScrollPhysics(),
                                                                itemCount:
                                                                    variantCategoryModel
                                                                        .length,
                                                                gridDelegate:
                                                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                                                      maxCrossAxisExtent: Responsive.isMobile(context) ? 120 : 160,
                                                                      mainAxisExtent: 120,
                                                                      mainAxisSpacing: 12,
                                                                      crossAxisSpacing: 12,
                                                                    ),
                                                                itemBuilder:
                                                                    (context, index) {
                                                                  return InkWell(
                                                                    onTap: () {
                                                                      GoRouter.of(context).pushNamed(
                                                                          AppRouteConstants
                                                                              .productsPage,
                                                                          pathParameters: {
                                                                            'searchQuery':
                                                                                variantCategoryModel[
                                                                                        index]
                                                                                    .id
                                                                          });
                                                                    },
                                                                    child: Container(
                                                                      decoration: BoxDecoration(
                                                                        color: Colors.white,
                                                                        borderRadius: BorderRadius.circular(10),
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            color: Colors.black.withOpacity(0.05),
                                                                            blurRadius: 4,
                                                                            offset: const Offset(0, 2),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      child: Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .spaceEvenly,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .center,
                                                                        children: [
                                                                          Expanded(
                                                                            flex: 2,
                                                                            child: Container(
                                                                              width: double.infinity,
                                                                              padding: const EdgeInsets.all(8),
                                                                              child: ClipRRect(
                                                                                borderRadius: BorderRadius.circular(8),
                                                                                child: CachedNetworkImage(
                                                                                  imageUrl: variantCategoryModel[index].imageURL,
                                                                                  placeholder: (context, url) => Shimmer.fromColors(
                                                                                    baseColor: Colors.grey.shade100,
                                                                                    highlightColor: Colors.grey.shade300,
                                                                                    child: Container(
                                                                                      width: double.infinity,
                                                                                      height: double.infinity,
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                  ),
                                                                                  errorWidget: (context, url, error) => const Icon(
                                                                                    Icons.error_outline,
                                                                                    color: Colors.red,
                                                                                  ),
                                                                                  fit: BoxFit.contain,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets.all(6),
                                                                            child: Text(
                                                                              variantCategoryModel[index].categoryName,
                                                                              textAlign: TextAlign.center,
                                                                              style: const TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.w500,
                                                                              ),
                                                                              maxLines: 2,
                                                                              overflow: TextOverflow.ellipsis,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}


// class ListViewWithAccordion extends StatelessWidget {
//   const ListViewWithAccordion({
//     super.key,
//     required this.mainCategoryModel,
//   });

//   final List<Category> mainCategoryModel;

//   @override
//   Widget build(BuildContext context) {
//     PageController pageController = PageController();
//     return BlocBuilder<SearchCategoryCubit, int>(
//       builder: (context, state) {
//         int currentPage = state;

//         return PageView.builder(
//           controller: pageController,
//           // itemExtent: 1000,
//           // shrinkWrap: true,
//           // padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
//           itemCount: mainCategoryModel.length,
//           scrollDirection: Axis.vertical,
//           itemBuilder: (context, pageIndex) {
           
//             final subCategoryModel = mainCategoryModel[pageIndex].subCategories;
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 GlobalTitleText(
//                   title: mainCategoryModel[pageIndex].categoryName,
//                   fontSize: 16,
//                 ),
//                 AspectRatio(
//                   aspectRatio: 16 / 9,
//                   child: Container(
//                     margin: const EdgeInsets.only(top: 10),
//                     width: double.infinity,
//                     color: AppPallete.lightgreyColor,
//                     child: Image.network(
//                       mainCategoryModel[pageIndex].imageURL,
//                       fit: BoxFit.fitHeight,
//                     ),
//                   ),
//                 ),
//                 BlocBuilder<SearchCategoryAccordionCubit, int>(
//                   builder: (context, state) {
//                     return ListView.builder(
//                       itemCount: subCategoryModel.length,
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemBuilder: (context, accordionIndex) {
//                         final variantCategoryModel =
//                             subCategoryModel[accordionIndex].subCategories;
//                         return Container(
//                           margin: const EdgeInsets.only(top: 10),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               InkWell(
//                                 splashColor: AppPallete.lightgreyColor,
//                                 onTap: () {
//                                   context
//                                       .read<SearchCategoryAccordionCubit>()
//                                       .changeAccordionIndex(accordionIndex);
//                                 },
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     GlobalTitleText(
//                                       title: subCategoryModel[accordionIndex]
//                                           .categoryName,
//                                     ),
//                                     Icon(
//                                       state == accordionIndex
//                                           ? Icons.keyboard_arrow_up_rounded
//                                           : Icons.keyboard_arrow_down_rounded,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               if (state == accordionIndex && pageIndex == 1)
//                                 GridView.builder(
//                                   shrinkWrap: true,
//                                   physics: const NeverScrollableScrollPhysics(),
//                                   itemCount: variantCategoryModel.length,
//                                   gridDelegate:
//                                       const SliverGridDelegateWithMaxCrossAxisExtent(
//                                           maxCrossAxisExtent: 100,
//                                           mainAxisExtent: 100),
//                                   itemBuilder: (context, index) {
//                                     return InkWell(
//                                       onTap: () {},
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceEvenly,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         children: [
//                                           Expanded(
//                                             flex: 2,
//                                             child: Image.network(
//                                               variantCategoryModel[
//                                                       accordionIndex]
//                                                   .imageURL,
//                                               fit: BoxFit.fitHeight,
//                                             ),
//                                           ),
//                                           Text(
//                                             variantCategoryModel[accordionIndex]
//                                                 .categoryName,
//                                             textAlign: TextAlign.center,
//                                             style: const TextStyle(
//                                               fontSize: 12,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     );
//                                   },
//                                 ),
//                             ],
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
// }

// class SideListViewTiles extends StatelessWidget {
//   const SideListViewTiles({
//     super.key,
//     required this.mainCategoryModel,
//   });

//   final List<Category> mainCategoryModel;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 140,
//       height: MediaQuery.of(context).size.height,
//       child: ListView.builder(
//         primary: true,
//         itemCount: mainCategoryModel.length,
//         itemBuilder: (context, listTileindex) {
//           return BlocBuilder<SearchCategoryCubit, int>(
//             builder: (context, state) {
//               return ListTile(
//                 tileColor: listTileindex == state
//                     ? AppPallete.lightgreyColor
//                     : AppPallete.darkgreyColor,
//                 contentPadding: const EdgeInsets.symmetric(horizontal: 0),
//                 leading: Container(
//                   width: 5,
//                   decoration: BoxDecoration(
//                     color: listTileindex == state
//                         ? AppPallete.primaryAppButtonColor
//                         : null,
//                     borderRadius: const BorderRadius.only(
//                       topRight: Radius.circular(10),
//                       bottomRight: Radius.circular(10),
//                     ),
//                   ),
//                 ),
//                 onTap: () {
//                   context
//                       .read<SearchCategoryCubit>()
//                       .changeIndex(listTileindex);
//                 },
//                 splashColor: AppPallete.primaryAppColor,
//                 horizontalTitleGap: 0,
//                 titleAlignment: ListTileTitleAlignment.center,
//                 title: Text(
//                   mainCategoryModel[listTileindex].categoryName,
//                   style: const TextStyle(
//                     fontSize: 10,
//                     fontWeight: FontWeight.w400,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 2,
//                   softWrap: true,
//                 ),
//                 trailing: Container(
//                   width: 1,
//                 ),
//                 selectedColor: AppPallete.whiteColor,
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }