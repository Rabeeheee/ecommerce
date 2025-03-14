part of 'revenue_bloc.dart';

sealed class RevenueState extends Equatable {
  const RevenueState();

  @override
  List<Object> get props => [];
}

final class RevenueInitial extends RevenueState {}

final class RevenueLoading extends RevenueState {}

final class RevenueWholeDataState extends RevenueState {}

final class GetRevenueSuccess extends RevenueWholeDataState {
  final Revenue revenue;
  GetRevenueSuccess({required this.revenue});
}

final class GetRevenueFailed extends RevenueWholeDataState {
  final String message;
  GetRevenueFailed({required this.message});
}

final class GetListOfRevenueDataState extends RevenueState {}

final class GetListOfRevenueDataLoadingState
    extends GetListOfRevenueDataState {}

final class GetListOfRevenueDataSuccessState extends GetListOfRevenueDataState {
  final List<VendorPayment> listOfVendorPayment;
  final DateFilter dateFilter;
  GetListOfRevenueDataSuccessState({required this.listOfVendorPayment,required this.dateFilter});
}

final class GetListOfRevenueDataFailedState extends GetListOfRevenueDataState {
  final String message;
  GetListOfRevenueDataFailedState({required this.message});
}
