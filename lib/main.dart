import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tech_haven/core/common/bloc/common_bloc.dart';
import 'package:tech_haven/core/common/cubits/app_cubit/app_user_cubit.dart';
import 'package:tech_haven/core/routes/app_route_config.dart';
import 'package:tech_haven/core/theme/theme.dart';
import 'package:tech_haven/firebase_options.dart';
import 'package:tech_haven/user/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tech_haven/init_dependencies.main.dart';
import 'package:tech_haven/user/features/cart/presentation/bloc/cart_page_bloc.dart';
import 'package:tech_haven/user/features/checkout/presentation/bloc/checkout_bloc.dart';
import 'package:tech_haven/user/features/details/presentation/bloc/details_page_bloc.dart';
import 'package:tech_haven/user/features/favorite/presentation/bloc/favorite_page_bloc.dart';
import 'package:tech_haven/user/features/help%20center/presentation/bloc/help_center_bloc.dart';
import 'package:tech_haven/user/features/home/presentation/bloc/home_page_bloc.dart';
import 'package:tech_haven/user/features/map/presentation/bloc/map_page_bloc.dart';
import 'package:tech_haven/user/features/order%20history/presentation/bloc/user_order_history_page_bloc.dart';
import 'package:tech_haven/user/features/order/presentation/bloc/user_order_page_bloc.dart';
import 'package:tech_haven/user/features/ordredProducts/presentation/bloc/ordered_products_page_bloc.dart';
import 'package:tech_haven/user/features/products/presentation/bloc/products_page_bloc.dart';
import 'package:tech_haven/user/features/profile%20edit/presentation/bloc/profile_edit_page_bloc.dart';
import 'package:tech_haven/user/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:tech_haven/user/features/review%20enter/presentation/bloc/review_enter_page_bloc.dart';
import 'package:tech_haven/user/features/reviews/presentation/bloc/review_page_bloc.dart';
import 'package:tech_haven/user/features/search/presentation/bloc/search_page_bloc.dart';
import 'package:tech_haven/user/features/searchcategory/presentation/bloc/search_category_bloc.dart';
import 'package:tech_haven/user/features/searchcategory/presentation/cubit/search_category_cubit.dart';
import 'package:tech_haven/vendor/features/manageproduct/presentation/bloc/manage_product_bloc.dart';
import 'package:tech_haven/vendor/features/order/presentation/bloc/vendor_order_page_bloc.dart';
import 'package:tech_haven/vendor/features/orderdetails/presentation/bloc/vendor_order_details_bloc.dart';
import 'package:tech_haven/vendor/features/profile/presentation/bloc/vendor_profile_bloc.dart';
import 'package:tech_haven/vendor/features/registerproduct/presentation/bloc/get_images_bloc.dart';
import 'package:tech_haven/vendor/features/registerproduct/presentation/bloc/register_product_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:tech_haven/vendor/features/registervendor/presentation/bloc/register_vendor_bloc.dart';
import 'package:tech_haven/vendor/features/revenue/presentation/bloc/revenue_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    if (!kIsWeb) {
      await dotenv.load(fileName: ".env");
      Stripe.publishableKey = dotenv.env["STRIPE_PUBLISH_KEY"]!;
      await Stripe.instance.applySettings();
    }
  } catch (e, stack) {
    log(e.toString(), stackTrace: stack);
  }

  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  await initDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
        BlocProvider(create: (context) => serviceLocator<AuthBloc>()),
        BlocProvider(create: (context) => serviceLocator<ReviewPageBloc>()),
        BlocProvider(create: (_) => serviceLocator<HomePageBloc>()),
        BlocProvider(create: (context) => serviceLocator<MapPageBloc>()),
        BlocProvider(create: (_) => serviceLocator<HelpCenterBloc>()),
        BlocProvider(create: (context) => serviceLocator<SearchCategoryBloc>()),
        BlocProvider(create: (_) => serviceLocator<SearchCategoryCubit>()),
        BlocProvider(create: (_) => serviceLocator<UserOrderHistoryPageBloc>()),
        BlocProvider(create: (_) => serviceLocator<DetailsPageBloc>()),
        BlocProvider(create: (_) => serviceLocator<RegisterProductBloc>()),
        BlocProvider(create: (_) => serviceLocator<ManageProductBloc>()),
        BlocProvider(create: (_) => serviceLocator<GetImagesBloc>()),
        BlocProvider(create: (_) => serviceLocator<FavoritePageBloc>()),
        BlocProvider(create: (_) => serviceLocator<CartPageBloc>()),
        BlocProvider(create: (_) => serviceLocator<MapPageBloc>()),
        BlocProvider(create: (_) => serviceLocator<CommonBloc>()),
        BlocProvider(create: (_) => serviceLocator<CheckoutBloc>()),
        BlocProvider(create: (_) => serviceLocator<ProfileBloc>()),
        BlocProvider(create: (_) => serviceLocator<SearchCategoryCubit>()),
        BlocProvider(
          create: (_) => serviceLocator<SearchCategoryAccordionCubit>(),
        ),
        BlocProvider(create: (_) => serviceLocator<ProductsPageBloc>()),
        BlocProvider(create: (_) => serviceLocator<RegisterVendorBloc>()),
        BlocProvider(create: (_) => serviceLocator<VendorOrderPageBloc>()),
        BlocProvider(create: (_) => serviceLocator<VendorOrderDetailsBloc>()),
        BlocProvider(create: (_) => serviceLocator<RevenueBloc>()),
        BlocProvider(create: (_) => serviceLocator<UserOrderPageBloc>()),
        BlocProvider(create: (_) => serviceLocator<SearchPageBloc>()),
        BlocProvider(create: (_) => serviceLocator<ReviewEnterPageBloc>()),
        BlocProvider(create: (_) => serviceLocator<ProfileEditPageBloc>()),
        BlocProvider(create: (_) => serviceLocator<OrderedProductsPageBloc>()),
        BlocProvider(create: (_) => serviceLocator<VendorProfileBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

///hlshdfkjs
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      themeAnimationDuration: const Duration(milliseconds: 500),
      themeAnimationCurve: Curves.easeOut,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      title: 'Tech Haven',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      // routerConfig: AppRoutes.goRouter,
      routeInformationProvider: AppRoutes.goRouter.routeInformationProvider,
      routeInformationParser: AppRoutes.goRouter.routeInformationParser,
      routerDelegate: AppRoutes.goRouter.routerDelegate,
    );
  }
}
