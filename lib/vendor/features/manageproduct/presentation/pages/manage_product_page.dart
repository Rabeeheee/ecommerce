import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_haven/core/common/widgets/loader.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/user/features/notification/presentation/widgets/tab_text.dart';
import 'package:tech_haven/vendor/core/common/widget/vendor_app_bar.dart';
import 'package:tech_haven/vendor/features/manageproduct/presentation/bloc/manage_product_bloc.dart';
import 'package:tech_haven/vendor/features/manageproduct/presentation/pages/subpages/published_page.dart';
import 'package:tech_haven/vendor/features/manageproduct/presentation/pages/subpages/unplubished_page.dart';

class ManageProductPage extends StatelessWidget {
  const ManageProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // BlocProvider.of<ManageProductBloc>(context).emit(ManageProductInitial());
      BlocProvider.of<ManageProductBloc>(context)
          .add(const GetAllProductsEventForManage());
    });
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: BlocConsumer<ManageProductBloc, ManageProductState>(
          listener: (context, state) {
            if (state is UpdateTheProductPublishSuccessState) {
              BlocProvider.of<ManageProductBloc>(context)
                  .add(const GetAllProductsEventForManage());
            }
          },
          builder: (context, state) {
            if (state is ManageProductLoadingState) {
              return const Loader();
            }
            if (state is GetAllProductsSuccess) {
              return Scaffold(
                appBar: const VendorAppBar(
                  title: 'Manage Products',
                  bottom: TabBar(
                    indicatorWeight: 1,
                    indicatorPadding: EdgeInsets.only(top: 45),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                      color: AppPallete.primaryAppButtonColor,
                    ),
                    dividerHeight: 0,
                    tabs: [
                      Tab(
                        child: TabText(
                          title: 'Published',
                        ),
                      ),
                      Tab(
                        child: TabText(
                          title: 'UnPublished',
                        ),
                      ),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    PublishedPage(
                      listOfPublishedProduct: state.listOfProductModel
                          .where((element) => element.isPublished == true)
                          .toList(),
                    ),
                    UnPublishedPage(
                      listOfPublishedProduct: state.listOfProductModel
                          .where((element) => element.isPublished == false)
                          .toList(),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
