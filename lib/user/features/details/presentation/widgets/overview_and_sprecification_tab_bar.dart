import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/common/widgets/custom_blur_button.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/user/features/details/presentation/route%20params/to_about_product_page.dart';
import 'package:tech_haven/user/features/details/presentation/widgets/specification_list_view.dart';

class OverviewAndSpecificationTabBar extends StatefulWidget {
  const OverviewAndSpecificationTabBar({
    super.key,
    required this.overview,
    required this.specifications,
  });

  final String overview;
  final Map<String, String> specifications;

  @override
  State<OverviewAndSpecificationTabBar> createState() =>
      _OverviewAndSpecificationTabBarState();
}

class _OverviewAndSpecificationTabBarState
    extends State<OverviewAndSpecificationTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          controller: _tabController,
          tabs: const [
            Tab(text: 'Overview'),
            Tab(text: 'Specifications'),
          ],
        ),
        Expanded(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              TabBarView(
                controller: _tabController,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      widget.overview,
                      overflow: TextOverflow.fade,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SpecificationListView(
                    specifications: widget.specifications,
                  )
                ],
              ),
              Positioned(
                  // bottom: 20,
                  child: SizedBox(
                height: 60,
                child: CustomBlurButton(
                    title: 'More About this Item.',
                    onPressed: () {
                      GoRouter.of(context).pushNamed(
                          AppRouteConstants.aboutProductPage,
                          extra: ToAboutProductPage(
                              overview: widget.overview,
                              specifications: widget.specifications));
                    }),
              ))
            ],
          ),
        ),
      ],
    );
  }
}
