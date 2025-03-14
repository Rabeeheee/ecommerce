part of 'manage_product_bloc.dart';

sealed class ManageProductEvent extends Equatable {
  const ManageProductEvent();

  @override
  List<Object> get props => [];
}

final class GetAllProductsEventForManage extends ManageProductEvent {
  // final String vendorID;
  const GetAllProductsEventForManage();
}

final class UpdateTheProductPublishEvent extends ManageProductEvent {
  final bool publish;
  final Product product;
  const UpdateTheProductPublishEvent(
      {required this.product, required this.publish});
}
