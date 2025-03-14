part of 'ordered_products_page_bloc.dart';


abstract class OrderedProductsPageState extends Equatable {
  const OrderedProductsPageState();

  @override
  List<Object> get props => [];
}

class OrderedProductsPageInitial extends OrderedProductsPageState {}

class OrderedProductsPageLoading extends OrderedProductsPageState {}

class OrderedProductsPageLoaded extends OrderedProductsPageState {
  final List<UserOrderedProduct> products;

  const OrderedProductsPageLoaded({required this.products});

  @override
  List<Object> get props => [products];
}

class OrderedProductsPageError extends OrderedProductsPageState {
  final String message;

  const OrderedProductsPageError({required this.message});

  @override
  List<Object> get props => [message];
}