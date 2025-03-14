import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/common/widgets/appbar_searchbar.dart';
import 'package:tech_haven/core/common/widgets/custom_blur_button.dart';
import 'package:tech_haven/user/features/details/presentation/route%20params/to_about_product_page.dart';
import 'package:tech_haven/user/features/details/presentation/widgets/specification_list_view.dart';

class AboutProductPage extends StatefulWidget {
  const AboutProductPage({
    super.key,
    required this.toAboutProductPage,
  });

  final ToAboutProductPage toAboutProductPage;

  @override
  State<AboutProductPage> createState() => _AboutProductPageState();
}

class _AboutProductPageState extends State<AboutProductPage>
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
    return Scaffold(
      appBar: const AppBarSearchBar(
        favouriteIconNeeded: true,
        backButton: true,
      ),
      body: Column(
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
            child: TabBarView(
              controller: _tabController,
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      widget.toAboutProductPage.overview,
                      style: const TextStyle(
                        overflow: TextOverflow.fade,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                SpecificationListView(
                  canScroll: true,
                  specifications: widget.toAboutProductPage.specifications,
                )
              ],
            ),
          ),
          SizedBox(
            height: 60,
            child: CustomBlurButton(
                up: true,
                title: 'Go Back',
                onPressed: () {
                  GoRouter.of(context).pop();
                }),
          )
        ],
      ),
    );
  }
}
