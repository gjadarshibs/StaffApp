part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();
}

class DashboardInitial extends DashboardState {
  @override
  List<Object> get props => [];
}

class DashboardLoadSuccess extends DashboardState {
  DashboardLoadSuccess({this.shortcuts, this.upcomingTrips});

  final List<ShortcutModel> shortcuts;
  final List<UpcomingTrip> upcomingTrips;

  @override
  List<Object> get props => [shortcuts, upcomingTrips];
}
