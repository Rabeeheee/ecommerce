part of 'ordered_products_page_bloc.dart';

abstract class OrderedProductsPageEvent extends Equatable {
  const OrderedProductsPageEvent();

  @override
  List<Object> get props => [];
}

class FetchOrderProductsEvent extends OrderedProductsPageEvent {

  final String orderId;

  const FetchOrderProductsEvent({
    required this.orderId,
  });

}