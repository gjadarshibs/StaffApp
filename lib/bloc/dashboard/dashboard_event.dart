part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();
}

class DashboardLoaded extends DashboardEvent {
  @override
  List<Object> get props => [];
}
