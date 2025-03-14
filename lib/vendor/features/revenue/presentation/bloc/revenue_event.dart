part of 'revenue_bloc.dart';

sealed class RevenueEvent extends Equatable {
  const RevenueEvent();

  @override
  List<Object> get props => [];
}

final class GetRevenueEvent extends RevenueEvent {}

final class GetListOfRevenueDataEvent extends RevenueEvent {
final DateFilter dateFilter;
  const GetListOfRevenueDataEvent({required this.dateFilter});
}
