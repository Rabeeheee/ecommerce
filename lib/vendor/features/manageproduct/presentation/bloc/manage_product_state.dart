part of 'manage_product_bloc.dart';

sealed class ManageProductState extends Equatable {
  const ManageProductState();

  @override
  List<Object> get props => [];
}

final class ManageProductInitial extends ManageProductState {}

final class ManageProductPageState extends ManageProductState {}

final class ManageProductLoadingState extends ManageProductPageState {}

final class ManageProductPageActionState extends ManageProductPageState {}

final class GetAllProductsSuccess extends ManageProductPageState {
  final List<Product> listOfProductModel;
  GetAllProductsSuccess({required this.listOfProductModel});
}

final class GetAllProductFailed extends ManageProductPageState {
  final String message;
  GetAllProductFailed({required this.message});
}

final class UpdateTheProductPublishState extends ManageProductState {}

final class UpdateTheProductPublishSuccessState
    extends UpdateTheProductPublishState {}

final class UpdateTheProductPublishFailedState
    extends UpdateTheProductPublishState {
  final String message;
  UpdateTheProductPublishFailedState({required this.message});
}
